Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h45C9nI4026026
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 08:09:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h45C8EVf008310
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 12:08:54 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h45C6w4D008240
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 12:07:38 GMT
Subject: Re: strange avc messages on oom
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200305042131.30060.russell@coker.com.au>
References: <200305042131.30060.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1052136220.1377.713.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 05 May 2003 08:03:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-05-04 at 07:31, Russell Coker wrote:
> The following messages appeared after a kde process went into a loop and used 
> all available memory.  The kde process names /usr/bin/kdeinit had the context 
> rjc:user_r:user_t.  I don't know what pid 1169 was, but after logging out 
> (killing all KDE processes) it was gone.
> 
> avc:  denied  { sys_admin } for  pid=1169 exe=/usr/bin/kdeinit capability=21 
> scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
> tclass=capability
> 
> avc:  denied  { sys_rawio } for  pid=1169 exe=/usr/bin/kdeinit capability=17 
> scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
> tclass=capability
> 
> avc:  denied  { sys_admin } for  pid=1169 exe=/usr/bin/kdeinit capability=21 
> scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
> tclass=capability
> Out of Memory: Killed process 17695 (kdeinit).

The OOM killer (mm/oom_kill.c) performs CAP_SYS_ADMIN and CAP_SYS_RAWIO
checks against each process as part of selecting a good process to kill
when the system runs out of memory.  The scontext and tcontext are the
ones passed to the actual permission check, and correspond to the
process that is being checked for capability checks.  The pid and exe
information are always derived from the current process, which in this
case is not actually the one being checked.  A similar issue shows up
for some of the networking checks performed during network input
processing.  However, in the common case, the current process is
relevant.

It would be possible to have the hook functions explicitly save the
relevant process (task) in the audit data structure prior to invoking
the permission check, and have the audit code use that passed
information rather than relying on the current process.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
