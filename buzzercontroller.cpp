#include "buzzercontroller.h"
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QDebug>

static QNetworkReply *reply = nullptr;
static QNetworkAccessManager *manager = nullptr;

BuzzerController::BuzzerController(QObject *parent)
    : QObject{parent}
{
    qDebug() << "Inicializando buzzer controller";
    manager = new QNetworkAccessManager();
    QObject::connect(::manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinished(QNetworkReply*)));
}

uint BuzzerController::quantidade() const
{
    return qtd;
}

void BuzzerController::setQuantidade(uint quantidade)
{
    qtd = quantidade;
    emit quantidadeChanged();
}

uint BuzzerController::tempo() const
{
    return this->time;
}

void BuzzerController::setTempo(uint tempo)
{
    this->time = tempo;
    emit tempoChanged();
}

void BuzzerController::acionar()
{
    QUrl url("http://192.168.1.2:2711/buzzer");
    QNetworkRequest req(url);
    QString payload;

    qDebug() << "Enviando request para" << url;
    payload = QString("{\"estado\":%1,\"tempo_segundos\":%2,\"quantidade_vezes\":%3}").arg(estado).arg(time).arg(qtd);
    qDebug() << "payload" << payload.toStdString().c_str();
    req.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("application/json"));
    reply = manager->post(req, payload.toLatin1());
}

void BuzzerController::requestFinished(QNetworkReply *reply)
{
    qDebug() << "request finished: " << reply->error();
    if(reply->error() != QNetworkReply::NoError) {
        emit errorOccurred(reply->error());
    }
}
