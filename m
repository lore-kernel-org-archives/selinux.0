Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA9MUM6t008679
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2012 17:30:22 -0500
Received: from staEX7mb4.telecom.sna.samsung.com ([105.52.12.130]) by cuda3.sta.samsung.com with ESMTP id L486YFhaRzvt6Hpa for <selinux@tycho.nsa.gov>; Fri, 09 Nov 2012 16:26:23 -0600 (CST)
From: Shuiqing Wang <s.wang@sta.samsung.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 9 Nov 2012 16:26:22 -0600
Subject: reload seandroid policy
Message-ID: <C1432A7484D61749AF22A060C2B03C5D0B537D7F54@StaEx7mb3.telecom.sna.samsung.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am new to SEAndroid and I have a couple of questions about reloading
policy, on Android 4.0.4.

1. I read from the SEAndroid wiki that I can copy a new policy file
to /data/system, and issue a "setprop selinux.reload_policy 1" command
in adb shell to trigger a reload of policy. I did this but nothing
happened. How do I know the reload is successful or not? I checked dmesg
but saw nothing useful.

2. How to I know which policy file is pointed to by the kernel currently
if multiple policies exist on my device? Is there a adb shell command or
log file that can help?

Thanks,
Shuiqing


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
