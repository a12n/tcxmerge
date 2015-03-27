The purpose of `tcxmerge` program is to combine training data from a
TCX file with GPS location information from a GPX file.

For each data point in the TCX data it takes corresponding elevation,
latitude and longitude values from the GPX track.

It's unlikely that TCX and GPX data are available for the same time
instants, so linear interpolation is used for missing GPX data points.

Data in the TCX file is usually from a non-GPS enabled device, whose
clock may be way off with the precise clock in a GPS receiver. So,
there's usually noticeable time lag of TCX data relative to the GPX
track data. `tcxmerge` tries to detect this lag and compensate for it
by means of cross-correlation on altitude data. If altitude data isn't
available in both data sets, no compensation will be performed.
