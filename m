Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7KKrLkx024249
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 16:53:21 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7KKr5Sr022392
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 20:53:05 GMT
Received: from mail.atsec.com (localhost [127.0.0.1])
	by mail.atsec.com (Postfix) with ESMTP id 56B087209F0
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 22:53:04 +0200 (CEST)
Date: Mon, 20 Aug 2007 15:52:58 -0500
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, joe@nall.com
Subject: Re: MLS directory write constraints
Message-ID: <20070820205258.GA23508@w-m-p.com>
References: <1187613297.27524.10.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1187613297.27524.10.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 20, 2007 at 08:34:57AM -0400, Christopher J. PeBenito wrote:
> After doing some work on some MLS systems last week, I observed some
> constraint denials like this:
> 
> type=AVC msg=audit(1187122358.679:120): avc:  denied  { write } for
> pid=2829 comm="foo" name="run" dev=dm-0 ino=3309608
> scontext=system_u:system_r:foo_t:s15:c0.c1023
> tcontext=system_u:object_r:var_run_t:s0-s15:c0.c1023
> tclass=dir
> 
> Where a daemon has TE rules for creating it's PID file in /var/run, but
> gets denied by this MLS constraint:
> 
> mlsconstrain { file ... dir ... } { write create setattr relabelfrom append unlink link rename mounton }
> 	(( l1 eq l2 ) or
> 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> 	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
> 	 ( t1 == mlsfilewrite ) or
> 	 ( t2 == mlstrustedobject ));
> 
> It seems like it should be able to create a file in the directory, since
> the daemon's level is within the range of the directory.

Ranged directories are an information leak in an MLS system, the current
restrictions are intentionally set the way they are to prevent them.

For the CC evaluation of LSPP compliance, we needed to draw a line
between explicit data flows (which need to be enforced by the OS), and
covert channels (which are beyond the scope of the evaluation). 

The method we used to decide this was to check if an interface allows
creation of arbitrary textual/binary data that can be read at another
level - if that's the case, the OS needs to enforce the strict LSPP MLS
constraints and prevent write down. Unfortunately directory write
operations to ranged directories would break this constraint since the
filenames can be chosen arbitrarily and read at lower levels, and this
must not be allowed for untrusted subjects.

You'd need to use one of the subject or object override attributes to
permit this access if you need it - that's what they are there for, and
if you need more granularity it may make sense to define a
"mlswritetorangeddir" attribute to allow only this specific override. For
LSPP compliance, the default behavior for untrusted subjects should
remain not to allow it.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
