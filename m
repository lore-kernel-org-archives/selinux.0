Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119548686.28493.161.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
	 <1119470092.9358.43.camel@localhost>  <1119540816.9390.35.camel@localhost>
	 <1119546240.28493.128.camel@moss-spartans.epoch.ncsc.mil>
	 <1119548467.9390.56.camel@localhost>
	 <1119548686.28493.161.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:55:55 -0400
Message-Id: <1119549355.28493.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 13:44 -0400, Stephen Smalley wrote:
> On Thu, 2005-06-23 at 18:41 +0100, antoine wrote:
> > I removed the change, so now I can start postfix again without problems,
> > but I am back where I started with spamd:
> > 
> > audit(1119545469.251:0): avc:  denied  { transition } for  pid=19693
> > exe=/usr/bin/spamc path=/usr/sbin/sendmail dev=md3 ino=783481
> > scontext=system_u:system_r:spamd_t
> > tcontext=system_u:object_r:postfix_pipe_t tclass=process
> 
> Again, object_r in process context.

And note that this would violate both a constraint (role change in
violation of the constraint on r1 != r2) and a role allow restriction.
But audit2why just reports the first cause.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
