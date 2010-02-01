Subject: Re: how to trace an avc denial
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1264873435.12042.15.camel@localhost>
References: <1264873435.12042.15.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 09:29:40 -0500
Message-Id: <1265034580.12435.16.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-01-30 at 18:43 +0100, Stefan Schulze Frielinghaus wrote:
> Hi all,
> 
> I'm trying to create a policy for pidgin and hit the following problem:
> When pidgin is started via the GNOME menu "Applications -> Internet ->
> Pidgin" then I get the following AVC:
> 
> type=1400 audit(1264870417.250:22382): avc:  denied  { search } for
> pid=9114 comm="pidgin" name="1" dev=proc ino=160141
> scontext=unconfined_u:unconfined_r:pidgin_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:init_t:s0 tclass=dir
> type=1400 audit(1264870417.250:22382): avc:  denied  { read } for
> pid=9114 comm="pidgin" name="exe" dev=proc ino=160142
> scontext=unconfined_u:unconfined_r:pidgin_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:init_t:s0 tclass=lnk_file
> 
> At the moment I just don't audit the denials:
> 
> require {
>         type init_t;
> }
> 
> dontaudit pidgin_t init_t:dir search;
> dontaudit pidgin_t init_t:lnk_file read;
> 
> What I would like to do is find out if pidgin itself is
> accessing /proc/1/exe or if it is a library. A simple
> "grep -R '/proc/' ./pidgin-source" does not provide any helpful output.
> My guess is that it is a leaked file descriptor because if I start
> pidgin from a shell, then I do not have this problem (I have a rule for
> user terminals and so on).
> 
> Summarized, how can I find out which library or application part is
> causing an AVC? I know there won't be any magical way to find the exact
> part ;-) but some general rules or tips would be very appreciated.
> Sometimes I use strace, e.g. to find out that a library is doing a call
> I'm interested in but this time strace does not help me. So any
> comments/suggestions are very welcomed.

You might also try enabling syscall audit on the particular process via
auditctl and see if that gives you any more insight, although that will
still be limited to the syscalls.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
