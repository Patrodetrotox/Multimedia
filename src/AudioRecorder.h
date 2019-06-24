#ifndef AUDIORECORDER_H
#define AUDIORECORDER_H

#include<QAudioRecorder>

class AudioRecorder : public QAudioRecorder
{

    Q_OBJECT

public:
    explicit AudioRecorder(QObject *parent = nullptr);
};

#endif // AUDIORECORDER_H
