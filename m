MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: secadm/sysadm discussion
Date: Mon, 18 Feb 2008 12:01:12 -0500
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8C3741A@HAVOC.tcs-sec.com>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com> <200802150855.47722.paul.moore@hp.com> <1203088187.3669.241.camel@bluejay.goodinassociates.com> <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil> <1203089944.13618.40.camel@gorn> <1203091760.3669.249.camel@bluejay.goodinassociates.com> <1203091792.13618.56.camel@gorn> <1203092070.3669.251.camel@bluejay.goodinassociates.com> <1203092610.13618.58.camel@gorn> <1203093415.3669.258.camel@bluejay.goodinassociates.com> <47B60285.9010801@redhat.com> <1203341839.13618.71.camel@gorn>
From: "Chad Hanson" <chanson@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Jeremiah Jahn" <jeremiah@goodinassociates.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Paul Moore" <paul.moore@hp.com>, "selinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I would concur that something like sysadm is needed.  But in the current
mls/strict configuration sysadm has too much power. 

The ability to customize roles and there respective powers in a modular
manner seems like a good idea. Hopefully this could lead to more
directed policy instead of blanket allow rules. These are hard to deal
with when people require changes to the default behavior.

-Chad

> On Fri, 2008-02-15 at 16:22 -0500, Daniel J Walsh wrote:
> > <rant>
> > 
> > 
> > Personally I think sysadm_t is a waste of time.  It is a poor mans
> > unconfined_t and should be eliminated from the face of the earth.
All
> > it does is generate Bugs and avc messages without supplying any real
> > security.  It makes no sense, as a confinement of a root user since
it
> > is so easily gotten around.  If you have an administrator of a
machine,
> > that you want to confine, start with only allowing him the privs
that
> > are required to do his job.  You can't start by saying he can do
> > everything except ABC.
> 
> As long as policy is used in a strict configuration, sysadm will be
> needed.  I would prefer to tighten it up.
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
