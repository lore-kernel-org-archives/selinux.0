Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VHshHa004419
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 13:54:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6VHrVFB013663
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 17:53:31 GMT
Received: from bastille.dss.state.va.us ([198.204.97.18])
	by jazzswing.ncsc.mil  with SMTP id h6VHrLGD013623
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 17:53:31 GMT
Received: from odin.dss.state.va.us (dssfw.dss.state.va.us [209.96.167.2])
	by pop3a.dss.state.va.us (8.12.8/8.11.6) with ESMTP id h6VHs49M027299
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 13:54:04 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Don Mills <drm2@dss.state.va.us>
Reply-To: drm2@dss.state.va.us
To: selinux@tycho.nsa.gov
Subject: Problems compiling libsecure
Date: Thu, 31 Jul 2003 13:53:58 -0400
MIME-Version: 1.0
Message-Id: <200307311353.59002.drm2@dss.state.va.us>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To any helpful soul:
	I am trying to compile and install the latest SE linux (2003071106) from the 
lsm-2.4-selinux-2003071106.tgz package.  I am following the step by step 
instructions rather than the quick install, and everything is proceeding fine 
until I attempt to compile libsecure whereupon I get(pardon my linewrap): 

cc -o fstat_secure.o -c -I../include -I/usr/local/selinux/include\ 
fstat_secure.c
In file included from fstat_secure.c:5:
xstat_conv.h: In function `xstat_conv':
xstat_conv.h:59: structure has no member named `st_atim'
xstat_conv.h:60: structure has no member named `st_atim'
xstat_conv.h:61: structure has no member named `st_mtim'
xstat_conv.h:62: structure has no member named `st_mtim'
xstat_conv.h:63: structure has no member named `st_ctim'
xstat_conv.h:64: structure has no member named `st_ctim'
make[1]: *** [fstat_secure.o] Error 1

Now I don't profess to be a C programmer (or even close!) but I think that bit 
of code is calling for the kernel's stat structure?  I tried copying the 
lsm-2.4 /include/asm/stat* to the libsecure/include but no help there...I 
also tried commenting out various includes from kernel_stat.h but no help 
there either.
Other possibly helpful info: compiling on 2.4.7 kernel w/ gcc 2.96 20000731 
(old RedHat 7.1 laptop).  Any thoughts? TIA...
	D
-- 
Don Mills
SCSA SCNA CCNP CCDP
CISSP CQS-VPN
Network Security/WAN Architect
VA Dept. of Social Services
drm2@dss.state.va.us



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
