class ThresholdClass {
  double _threshold;
  List<double> _decibels = [];

  ThresholdClass(this._threshold);

  // サンプリング時のデシベルを追加
  void addSample(double decibel) {
    _decibels.add(decibel);
  }

  void calcThreshold() {
    double sum = 0;

    _decibels.forEach((decibel) {
      sum += decibel;
    });

    _threshold = sum / _decibels.length;
  }

  double getThreshold() {
    return _threshold;
  }
}
