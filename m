Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lATLfZDQ019636
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 16:41:35 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lATLfYaw013381
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 21:41:34 GMT
Received: by nz-out-0506.google.com with SMTP id i1so1584236nzh
        for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 13:41:33 -0800 (PST)
Message-ID: <f71a82820711291341h6b13c84l4acbe7f0230aeb01@mail.gmail.com>
Date: Fri, 30 Nov 2007 06:41:32 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [RFC] SELinux policies for source installation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I do not use RPM packages but install from source
for web-things like postgresql, mysql, httpd, php.

The reason is I want to use some functions not
implemented by RPM version I believe.

When I want to use SELinux, all you got is RPM based.
I mean, mainly .fc files and naturally .te files.

If SELinux guys are generous enough to incorporate
lines for source installations, more users will use SELinux.

Of course RPM version should be the base, but source installation's
path could be written with comment # with no problem.

All you have to do is just comment RPM lines and comment out
source lines.

I know that source installation, you can install by --prefix wherever you like,
but obeying guidance of installation, it could be make it standard.

How many people con and how many pro I can get ?



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
