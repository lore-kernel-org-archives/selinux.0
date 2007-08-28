Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SDU2Ta032254
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 09:30:03 -0400
Received: from mo10.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SDTwM5007968
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 13:30:00 GMT
Date: Tue, 28 Aug 2007 22:29:54 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: selinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp, busybox@kaigai.gr.jp
Subject: [ANN] BusyBox SELinux support
Message-Id: <20070828222954.a16e91f8.himainu-ynakam@miomio.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

People in Japan SELinux Users Group(JSELUG)
are porting SELinux commands and options and others 
to BusyBox(www.busybox.net).

We want people to test BusyBox with SELinux support.
We would like to report progress here.

1. Applets
Following are merged and included in busybox 1.7.0.
* Commands:
chcon runcon getenforce getsebool load_policy 
matchpathcon selinuxenabled setenforce restorecon setfiles
* Options:
cp, ls, mkdir, mv, id, install, stat, find

2. Domain assignment support
We proposed 15byte wrapper to assign domain to busybox applets, 
and is merged to svn tree for busybox.
http://www.busybox.net/lists/busybox/2007-August/028551.html
http://www.busybox.net/lists/busybox/2007-August/028579.html

Here, what we are doing about embedded SELinux is described:
http://www.kaigai.gr.jp/index.php?TODO_en

Do you want other applets or options?
And if you find bugs or comments, please tell us(busybox@kaigai.gr.jp).

Regards,
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
