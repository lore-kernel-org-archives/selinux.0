Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IJi6Rb004740
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:44:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IJfeB2019825
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:41:40 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
	by jazzswing.ncsc.mil  with SMTP id i4IJfdwi019819
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:41:40 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 18 May 2004 18:54:16 -0000
Date: Tue, 18 May 2004 18:51:35 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518185135.GL24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil> <20040518130244.GB24917@lkcl.net> <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil> <20040518151112.GF24917@lkcl.net> <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 01:18:26PM -0400, Stephen Smalley wrote:
> On Tue, 2004-05-18 at 11:11, Luke Kenneth Casson Leighton wrote:
> >  okay, so i... didn't add anything to file_contexts, i only
> >  created a domain/program/localstuff.te and ... hm, well i
> >  _did_ create a blank file_contexts/programs/localstuff.fc,
> >  so i'm doing a make relabel anyway, just in case.
> 
> Not necessary.
> 
> >  as i understand it, the domains define what is allowed, and the
> >  file_contexts define if you will... the starting points of those
> >  "allowances" [ i know that's clumsily put ].
> 
> We call them entrypoint executables for the domains.  Note that file
> contexts includes more than just the entrypoint executables; it
> specifies the file contexts for all files (ultimately, everything will
> match at least one pathname regex, since the /.* entry at the beginning
> of types.fc will cover anything that lacks a more specific entry).
> 
> >  e.g. file_contexts/program/xdm.fc has as its first line:
> > 
> >  /usr/bin/[xgkw]dm       -- system_u:object_r:xdm_exec_t
> > 
> >  therefore, the programs gdm, xdm, kdm and wdm all have type xdm_exec_t
> >  therefore, according to line 24 of domains/programs/xdm.te, gdm,
> >  xdm, kdm and wdm are all allowed to automatically transition from
> >  the initialisation context into a new context named xdm_t.
> > 
> >  therefore, the programs gdm, xdm, kdm and wdm are all allowed to do
> >  the things that are mentioned as allow xdm_t etc.
> 
> Right.
> 
> >  ... so why, if i [appear to be] doing things correctly, do i still
> >  get errors, for example, when i have explicitly added:
> > 
> >  allow xdm_xserver_t var_lib_t:file { getattr read };
> > 
> >  okay, just a guess: when you declare an allow, are the relevant
> >  permissions added or replaced if there already exists, say,
> >  allow xdm_xserver_t var_lib_t:file { read };
> > 
> >  and i then add, in a following line to policy.conf : 
> >  allow xdm_xserver_t var_lib_t:file { getattr };
> > 
> >  do i end up with _only_ getattr permissions or do i end up
> >  with both read _and_ getattr?
> 
> checkpolicy takes the union of all such allow rules, so you end up with
> both read and getattr.  You can check at runtime via compute_av.  

 ah ha.  man compute_av equals undocumented oops okay, let's see
 google "selinux tcontext" and google "selinux scontext" ah ha!
 you mean the three things that are in an avc log message okay,
 let's try this, from:

 May 18 14:35:43 tv kernel: avc:  denied  { destroy } for  pid=1522
 exe=/usr/X11R6/bin/wdmLogin key=0 scontext=system_u:system_r:initrc_t
 tcontext=system_u:syste
 m_r:initrc_t tclass=shm

 try:

	tv:/etc/selinux# compute_av system_u:system_r:xdm_xserver_t
								system_u:system_r:initrc_t shm
	allowed= null

 uhn???


 okay, let's try this:

	tv:/etc/selinux# compute_av lkcl:sysadm_r:sysadm_t
                            system_u:object_r:xserver_exec_t file

	allowed= { ioctl read write create getattr setattr lock relabelfrom
	relabelto append unlink link rename execute execute_no_trans entrypoint
	}

 hm, so there is light, but what colour.

 so lkcl as a sysadm can run the xserver, but the xserver being run
 from xdm as system, at initialisation time, is banned???

 ???  okay, what have i done :)



> So you
> shouldn't still get denials, unless you aren't truly loading the new
> policy into the kernel or another factor (e.g. policy/constraints) is
> coming into play.  One common mistake is if your kernel isn't up-to-date
> and doesn't accept the latest policy version, you may be loading an
> older policy version, not the one you just compiled with your new
> checkpolicy.
 
 ..o*??  mmm... erhm.... so... given that i am building on a system
 with a 2.6.5 non-selinux kernel and then installing that on a 2.6.4
 system which i am trying really hard to upgrade to 2.6.6...

 okay, i'll first try to get the target system onto the 2.6.6 kernel
 again (build just completed) and then attempt a build on that
 machine.
 
 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
