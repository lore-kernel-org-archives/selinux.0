Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA9Mpk4I009762
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2012 17:51:47 -0500
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: Shuiqing Wang <s.wang@sta.samsung.com>,
        "selinux@tycho.nsa.gov"
	<selinux@tycho.nsa.gov>
Subject: RE: reload seandroid policy
Date: Fri, 9 Nov 2012 22:51:12 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E38365476710@ALA-MBA.corp.ad.wrs.com>
References: <C1432A7484D61749AF22A060C2B03C5D0B537D7F54@StaEx7mb3.telecom.sna.samsung.com>
In-Reply-To: <C1432A7484D61749AF22A060C2B03C5D0B537D7F54@StaEx7mb3.telecom.sna.samsung.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You can run the command on the host:

$ adb shell dmesg | grep 'Loaded policy from'

This will give you the answers to both your questions.  When SE Android loads policy, it
shows the path of the policy file that it loads.  The output on one of my running systems
just a moment ago was:

<4>[152862.099407] SELinux: Loaded policy from /data/system/sepolicy.24



________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Shuiqing Wang [s.wang@sta.samsung.com]
Sent: Friday, November 09, 2012 1:26 PM
To: selinux@tycho.nsa.gov
Subject: reload seandroid policy

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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
