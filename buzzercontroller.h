#ifndef BUZZERCONTROLLER_H
#define BUZZERCONTROLLER_H

#include "qqmlregistration.h"
#include <QObject>
#include <QNetworkReply>

class BuzzerController : public QObject
{
    Q_PROPERTY(uint quantidade READ quantidade WRITE setQuantidade NOTIFY quantidadeChanged)
    Q_PROPERTY(uint tempo READ tempo WRITE setTempo NOTIFY tempoChanged)
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BuzzerController(QObject *parent = nullptr);
    uint quantidade() const;
    Q_INVOKABLE void setQuantidade(uint quantidade);
    uint tempo() const;
    Q_INVOKABLE void setTempo(uint tempo);

    Q_INVOKABLE void acionar();

public slots:
    void requestFinished(QNetworkReply *);
private:
    uint qtd;
    uint time;
    uint estado = 1;
signals:
    void quantidadeChanged();
    void tempoChanged();
    void errorOccurred(QNetworkReply::NetworkError errorCode);
};

#endif // BUZZERCONTROLLER_H
