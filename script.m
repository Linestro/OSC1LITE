obj = OSC136H;
if obj.ConnectToFirst == 0
    obj.SetAllHigh
%     obj.SetAllZero
else
    prinf("doomed")
end