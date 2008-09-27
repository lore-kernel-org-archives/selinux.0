Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8RMSH7Y001002
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 18:28:17 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8RMSHvH018089
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2008 22:28:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [autotools] libselinux build system comments
Date: Sat, 27 Sep 2008 18:28:16 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E669856@exchange2.columbia.tresys.com>
References: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com> <48DE640B.10104@gmail.com>
From: "Jason Tang" <jtang@tresys.com>
To: "Vikram Noel Ambrose" <noel.ambrose@gmail.com>
Cc: <selinux@tycho.nsa.gov>, "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Vikram Noel Ambrose [mailto:noel.ambrose@gmail.com]
>> 4. libselinux is being installed to $(LIBDIR).  In this case, it should default to the system library.

> What does that mean?

libselinux and libsepol should be installed to /lib (or /lib64).  The reason is because /usr/lib may be on a different filesystem, but /lib (and /lib64) is nearly guaranteed to be available by the time the system will load the SELinux policy.

>> 7. There is no definition for the variable abs_top_srcdir in src/Makefile.am.

>Thats built in. You dont need to define it. Have a look at the resulting 
>Makefile

This probably depends upon the version of automake that read the Makefile.in.  Maybe the bleeding edge version of automake defines $(abs_top_srcdir), but the one that I am using does not.

>> 8. By default, the libselinux configuration file is written to $(SYSCONFDIR), but selinux_config.c has the path /etc/selinux hardcoded.  (N.b. the missing "selinux" subdirectory for the former path.)   

>How is that a problem?

One would expect that the default flags to configure would build working SELinux userspace libraries and tools.  Even if the end-user is expected to pass in a --sysconfdir flag to configure, selinux_config.c does not respect it.  Perhaps a patch to selinux_config.c is necessary?


-- 
Jason Tang  /  jtang@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
