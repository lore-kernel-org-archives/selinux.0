Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IKoBRb005334
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:50:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IKlkB2025373
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:47:46 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4IKliwi025276
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:47:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Date: Wed, 19 May 2004 06:48:52 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
References: <20040518104026.GC24333@lkcl.net> <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil> <20040518185135.GL24917@lkcl.net>
In-Reply-To: <20040518185135.GL24917@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190648.52415.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 04:51, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > checkpolicy takes the union of all such allow rules, so you end up with
> > both read and getattr.  You can check at runtime via compute_av.
>
>  ah ha.  man compute_av equals undocumented oops okay, let's see

I'll start work on man pages for that program and the others that go with it.  
I think that help2man is the correct solution.

>  May 18 14:35:43 tv kernel: avc:  denied  { destroy } for  pid=1522
>  exe=/usr/X11R6/bin/wdmLogin key=0 scontext=system_u:system_r:initrc_t
>  tcontext=system_u:syste
>  m_r:initrc_t tclass=shm
>
>  try:
>
> 	tv:/etc/selinux# compute_av system_u:system_r:xdm_xserver_t
> 								system_u:system_r:initrc_t shm
> 	allowed= null
>
>  uhn???

If you want to match the AVC message then try the following:
compute_av system_u:system_r:initrc_t system_u:system_r:initrc_t shm

>  okay, let's try this:
>
> 	tv:/etc/selinux# compute_av lkcl:sysadm_r:sysadm_t
>                             system_u:object_r:xserver_exec_t file
>
> 	allowed= { ioctl read write create getattr setattr lock relabelfrom
> 	relabelto append unlink link rename execute execute_no_trans entrypoint
> 	}
>
>  hm, so there is light, but what colour.
>
>  so lkcl as a sysadm can run the xserver, but the xserver being run
>  from xdm as system, at initialisation time, is banned???

The tests you have done show that when sysadm_t runs xserver_exec_t it may be 
an entrypoint into another domain, also that xdm_xserver_t has no access to 
shared memory regions created by initrc_t.  Not that it matters as your real 
problem seems to be having a wdm executable labeled with the wrong type such 
that it doesn't transition into xdm_t when it is run from initrc_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
