Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LDBU0g018708
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 09:11:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LDBSVL018735
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 13:11:28 GMT
Subject: Re: MLS directory write constraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>, dwalsh@redhat.com, sgrubb@redhat.com
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, joe@nall.com
In-Reply-To: <20070820205258.GA23508@w-m-p.com>
References: <1187613297.27524.10.camel@gorn>
	 <20070820205258.GA23508@w-m-p.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 09:10:23 -0400
Message-Id: <1187701836.13874.5.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-08-20 at 15:52 -0500, Klaus Weidner wrote: 
> On Mon, Aug 20, 2007 at 08:34:57AM -0400, Christopher J. PeBenito wrote:
> > After doing some work on some MLS systems last week, I observed some
> > constraint denials like this:
> > 
> > type=AVC msg=audit(1187122358.679:120): avc:  denied  { write } for
> > pid=2829 comm="foo" name="run" dev=dm-0 ino=3309608
> > scontext=system_u:system_r:foo_t:s15:c0.c1023
> > tcontext=system_u:object_r:var_run_t:s0-s15:c0.c1023
> > tclass=dir
> > 
> > Where a daemon has TE rules for creating it's PID file in /var/run, but
> > gets denied by this MLS constraint:
> > 
> > mlsconstrain { file ... dir ... } { write create setattr relabelfrom append unlink link rename mounton }
> > 	(( l1 eq l2 ) or
> > 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> > 	 (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
> > 	 ( t1 == mlsfilewrite ) or
> > 	 ( t2 == mlstrustedobject ));
> > 
> > It seems like it should be able to create a file in the directory, since
> > the daemon's level is within the range of the directory.
> 
> Ranged directories are an information leak in an MLS system, the current
> restrictions are intentionally set the way they are to prevent them.
> 
> For the CC evaluation of LSPP compliance, we needed to draw a line
> between explicit data flows (which need to be enforced by the OS), and
> covert channels (which are beyond the scope of the evaluation). 
> 
> The method we used to decide this was to check if an interface allows
> creation of arbitrary textual/binary data that can be read at another
> level - if that's the case, the OS needs to enforce the strict LSPP MLS
> constraints and prevent write down. Unfortunately directory write
> operations to ranged directories would break this constraint since the
> filenames can be chosen arbitrarily and read at lower levels, and this
> must not be allowed for untrusted subjects.

Does RHEL5 LSPP have a polyinstantiated /var/run?  If not, then every
daemon that doesn't run with a system low level will need this at a
minimum, thus partially negating what you are trying to do.

> You'd need to use one of the subject or object override attributes to
> permit this access if you need it - that's what they are there for, and
> if you need more granularity it may make sense to define a
> "mlswritetorangeddir" attribute to allow only this specific override. For
> LSPP compliance, the default behavior for untrusted subjects should
> remain not to allow it.

I see that the constraints are different in the 2.4.6-67 LSPP policy.
Is this the final one?  I want to make sure that the LSPP policy changes
have been integrated upstream.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
