Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IMX5Rb006069
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:33:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IMX2AR002990
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 22:33:02 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4IMX1Hn002985 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 22:33:02 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 18 May 2004 20:59:14 -0000
Date: Tue, 18 May 2004 20:56:37 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518205637.GF7348@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil> <20040518185135.GL24917@lkcl.net> <200405190648.52415.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405190648.52415.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 06:48:52AM +1000, Russell Coker wrote:
> On Wed, 19 May 2004 04:51, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > checkpolicy takes the union of all such allow rules, so you end up with
> > > both read and getattr.  You can check at runtime via compute_av.
> >
> >  ah ha.  man compute_av equals undocumented oops okay, let's see
> 
> I'll start work on man pages for that program and the others that go with it.  
> I think that help2man is the correct solution.
> 
> >  May 18 14:35:43 tv kernel: avc:  denied  { destroy } for  pid=1522
> >  exe=/usr/X11R6/bin/wdmLogin key=0 scontext=system_u:system_r:initrc_t
> >  tcontext=system_u:syste
> >  m_r:initrc_t tclass=shm
> >
> >  try:
> >
> > 	tv:/etc/selinux# compute_av system_u:system_r:xdm_xserver_t
> > 								system_u:system_r:initrc_t shm
> > 	allowed= null
> >
> >  uhn???
> 
> If you want to match the AVC message then try the following:
> compute_av system_u:system_r:initrc_t system_u:system_r:initrc_t shm

allowed= { create destroy read write unix_read unix_write }

> >  okay, let's try this:
> >
> > 	tv:/etc/selinux# compute_av lkcl:sysadm_r:sysadm_t
> >                             system_u:object_r:xserver_exec_t file
> >
> > 	allowed= { ioctl read write create getattr setattr lock relabelfrom
> > 	relabelto append unlink link rename execute execute_no_trans entrypoint
> > 	}
> >
> >  hm, so there is light, but what colour.
> >
> >  so lkcl as a sysadm can run the xserver, but the xserver being run
> >  from xdm as system, at initialisation time, is banned???
> 
> The tests you have done show that when sysadm_t runs xserver_exec_t it may be 
> an entrypoint into another domain, also that xdm_xserver_t has no access to 
> shared memory regions created by initrc_t.  Not that it matters as your real 
> problem seems to be having a wdm executable labeled with the wrong type such 
> that it doesn't transition into xdm_t when it is run from initrc_t.

 i don't pretend to understand everything yet in order to appreciate
 what you say, however i successfully built a debian selinux 2.6.6
 kernel (faked up a debian/rules etc in order to convince make-kpkg to run)
 and installed it on both the build and target system: suddenly
 things have got a lot better...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
