#ifndef REPLAYTIMELINE_H
#define REPLAYTIMELINE_H

#include <QTime>
#include <QMap>
#include <QList>
#include <QQuickPaintedItem>
namespace Ui {
class ReplayTimeline;
}
enum IntervalType{
    VIDEOLOSS = 0,
    VIDEONORMAL,
    VIDEOALARM,
    TIMELINE24H=10,
    TIMELINE2H,
    TIMELINE1H,
    TIMELINE30M,
};
class TimeInterval{
public:
    IntervalType type;
    QTime startTime;
    QTime endTime;
};


class ReplayTimeline : public QQuickPaintedItem
{
    Q_OBJECT


public:
    explicit ReplayTimeline();
    ~ReplayTimeline();

    Q_INVOKABLE void setSizeType(int type);
    void init();
    void setDate(QDate date);

public slots:
    void slot_24hSelect();
    void slot_2hSelect();
    void slot_1hSelect();
    void slot_30mSelect();
protected:
    void paint(QPainter *painter);

//    void mousePressEvent(QMouseEvent* event);
//    void mouseMoveEvent(QMouseEvent *event);
//    void mouseReleaseEvent(QMouseEvent *event);
//    void hoverMoveEvent(QMouseEvent *event);

private:
    Ui::ReplayTimeline *ui;
    void initTimeLineInterval();
    //在指定区间链表中寻找包含指定时间的区间
    TimeInterval *findInterval(QList<TimeInterval*> &list,QTime &time);

    void drawBg(QPainter *painter);
    void drawScale(QPainter *painter,IntervalType type);
    void drawValue(QPainter *painter);
    IntervalType scaleType = TIMELINE24H;//刻度类型

    QTime replayCurrentTime;
    QList<TimeInterval*> listTimeInterval24H;
    QList<TimeInterval*> listTimeInterval2H;
    QList<TimeInterval*> listTimeInterval1H;
    QList<TimeInterval*> listTimeInterval30M;

    //4个回放窗口的不同类型区间链表
    QList<TimeInterval*> listVideoInterval1;
    QList<TimeInterval*> listVideoInterval2;
    QList<TimeInterval*> listVideoInterval3;
    QList<TimeInterval*> listVideoInterval4;

    QRectF rectFIndicator;

};

#endif // REPLAYTIMELINE_H