Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21724
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 05:44:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA16201
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 09:43:09 GMT
Received: from mailgate5.cinetic.de (mailgate5.cinetic.de [217.72.192.165])
        by jazzband.ncsc.mil  with ESMTP id JAA16197 for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 09:43:08 GMT
Received: from web.de (fmomail01.dlan.cinetic.de [172.20.1.45])
	by mailgate5.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id g7T9ikX09394
	for selinux@tycho.nsa.gov; Thu, 29 Aug 2002 11:44:46 +0200
Date: Thu, 29 Aug 2002 11:44:46 +0200
Message-Id: <200208290944.g7T9ikX09394@mailgate5.cinetic.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Mark=20M=FCller?= <trusted@web.de>
To: selinux@tycho.nsa.gov
Subject: Re: Direct logins (via local and ssh) as httpd_admin_r?
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Do you have the following in your rbac file?
> allow system_r httpd_admin_r;
Bingo! Thanks for the fast answer Direct logins are now possible, but

a role change with newrole -r back to user_r does not work. Its curious:

$ newrole -r user_r
$ Authenticating webadmin.
$ Password: 
$ newrole: error: chsidwebadmin@linux:~> 

newrole just quits with error: chsid

The log says:

avc:  denied  { relabelto } for  pid=785 exe=/usr/local/selinux/bin/newrole path=/1 dev=00:07 ino=3 scontext=webadmin:httpd_admin_r:httpd_admin_t tcontext=webadmin:object_r:httpd_admin_devpts_t tclass=chr_file

And the rules that do not work:
allow httpd_admin_t httpd_admin_devpts_t:chr_file { relabelfrom relabelto };
allow httpd_admin_t user_t:process { transition };
allow httpd_admin_r user_r;

Where is the difference between direct login as httpd_admin_r and the usual way user_r -> httpd_admin_r via newrole? I can switch between user_r and httpd..._r with newrole if i login first as user_r.

> I think that the SE Linux log messages should be more verbose in such=20
> situations, they should mention when it's a constraint or role issue rath=
> er=20
> than the usual domain/type issues.
Indeed. There was no hint towards the role allow issue.

______________________________________________________________________________
WEB.DE MyPage - Ultimatives Kommunikationstool! Ihre Message sofort
online! Domain aenderbar! http://www.das.ist.aber.ne.lustige.sache.ms/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
