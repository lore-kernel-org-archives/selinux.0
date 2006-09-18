Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8II0d2Q016062
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 14:00:39 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8II09uA025491
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 18:00:10 GMT
Received: by nf-out-0910.google.com with SMTP id q29so3129952nfc
        for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 11:00:35 -0700 (PDT)
Message-ID: <f71a82820609181100n151c9a21r3e65e87b824af288@mail.gmail.com>
Date: Tue, 19 Sep 2006 03:00:34 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Introduction to SELinux tool
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

Mr James Morris encouraged me to post
about my project, so I'm trying to address
about my SELinux policy tool.

1 Name
 segatex
2 Characteristic
 Make a module just pushing buttons
in GUI.
3 Language
 C++
4 Requirements
 Qt
5 Lisence
 GPL
6 Targets
 Begginers using targeted policy
7 How it works
 Copies audit.log to my_log.
 Read from my_log.
 Through the engine, it generates
 interfaced policy and be ready to
 be installed.
 You can edit my_policy.
 You can install or remove my_policy.
 You can install and update SELinux rpms.
 You can autorelabel your system.
 All these could be done by buttons in GUI.
8 Download
 http://sourceforge.net/projects/segatex/

Thank you.
*****************
Shintaro Fujiwara
member JSELUG
JGSDF
*****************
myhomepage
http://intrajp.no-ip.com
myblog
http://intrajp.no-ip.com/nucleus/
SELinux wiki(JSELUG)
http://intrajp.no-ip.com/pukiwiki/
SELinux forum(JSELUG)
http://intrajp.no-ip.com/xoops/

PS
This time I send this from gmail.
My sony-address benn totaly rejected somehow.
I hope the administrator recieves this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
