Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CEruIi015795
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 09:53:56 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CErxgF019673
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 14:53:59 GMT
Subject: Re: lots of execmem failures with 2.6.10
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050112112630.GA12730@yggdrasil.localdomain>
References: <20050112112630.GA12730@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1105541256.22495.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 09:47:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 06:26, Greg Norris wrote:
> When trying to boot a 2.6.10 kernel, with the SELinux patch from the NSA
> website applied, I'm getting a LOT of denial messages such as the ones
> shown below.  This hoses the boot process to the point where the box is
> essentially unusable (no networking, impossible to logon at the console,
> etc.).  Under 2.6.9, the same policy works just fine.
> 
>    audit(1105293465.527:0): avc:  denied  { execmem } for  pid=237 comm=uname scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=process
>    audit(1105293465.663:0): avc:  denied  { execmem } for  pid=240 comm=touch scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=process
>    audit(1105293466.661:0): avc:  denied  { execmem } for  pid=259 comm=sync scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=process
>    audit(1105293466.716:0): avc:  denied  { execmem } for  pid=262 comm=uname scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=process
> 
> I haven't seen any mention of this on the list... any idea what's going
> on?  My policy source files are from cvs, as of three weeks or so ago. 
> I don't mind updating to current cvs if necessary, but don't see any
> obvious updates relating to execmem.  The server is an old Pentium II
> box (nothing at all unusual about it), running Debian sid.
> 
> I can update my policy to allow the execmem easily enough, but would
> expect to find it already in cvs if this was an expected issue.  Any 
> thoughts?

The thread that discussed the new controls over executable mappings
starts at http://marc.theaimsgroup.com/?l=selinux&m=110003195017130&w=2
and the final submitted version was
http://marc.theaimsgroup.com/?l=linux-kernel&m=110200324503263&w=2.

The question is why is your userland attempting to create executable
anonymous mappings or executable writable private file mappings.  May be
related to the legacy binary issue that came up earlier, where the
mainline kernel enables read-implies-exec behavior if the binary is a
"legacy" binary, i.e. lacks PT_GNU_STACK.  What does execstack -q `which
uname` report?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
