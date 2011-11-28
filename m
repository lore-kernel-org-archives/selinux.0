Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pASEdHcD020920
	for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2011 09:39:18 -0500
Received: from nm2-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pASEdGZE012322
	for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2011 14:39:17 GMT
Message-ID: <1322491154.74761.YahooMailClassic@web87009.mail.ird.yahoo.com>
Date: Mon, 28 Nov 2011 14:39:14 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1] policycoreutils: Added SELinux config file man page.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds an selinux_config(5) man page to policycoreutils. 

I hope the name is okay as config(5) has already been taken.

The man page mentions a couple of configuration files that I will send over
the next few days. I will add these additions to the libselinux man pages as
they are really used by the library functions (I'll also send man pages for 
all the remaining libselinux function config files). 

I've also updated sestatus(8) to give the SELinux root directory where config
is located plus an sestatus.conf(5) man page - patch to follow.

Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
