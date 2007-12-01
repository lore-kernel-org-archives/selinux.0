Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lB18FR7f019550
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 03:15:27 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB18FQD9002934
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 08:15:26 GMT
Received: by wa-out-1112.google.com with SMTP id k22so3134200waf
        for <selinux@tycho.nsa.gov>; Sat, 01 Dec 2007 00:15:25 -0800 (PST)
Message-ID: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
Date: Sat, 1 Dec 2007 17:15:25 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: libsepol.expand_terule_helper: duplicate TE rule
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I try to install apache.pp,

libsepol.expand_terule_helper: duplicate TE rule for httpd_t
exim_exec_t:process system_mail_t
libsepol.expand_module: Error during expand
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!

I can't find any lines concerning exim_exec_t anywhere...
Please help.


-- 
Shintaro Fujiwara
segatex project (SELinux policy tool)
http://sourceforge.net/projects/segatex/
Home page
http://intrajp.no-ip.com/
Blog
http://intrajp.no-ip.com/nucleus/
CMS
http://intrajp.no-ip.com/xoops/
Wiki
http://intrajp.no-ip.com/pukiwiki/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
