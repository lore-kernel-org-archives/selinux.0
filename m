Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8LFPrrT025572
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 11:25:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8LFOqaY029282
	for <selinux@tycho.nsa.gov>; Tue, 21 Sep 2004 15:24:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@redhat.com>
Subject: Re: File types that are not sysadmfiles...
Date: Wed, 22 Sep 2004 01:25:36 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <414DA0A7.1000708@gentoo.org> <200409211508.59158.russell@coker.com.au> <1095777744.5427.9.camel@nexus.verbum.private>
In-Reply-To: <1095777744.5427.9.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409220125.36337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Sep 2004 00:42, Colin Walters <walters@redhat.com> wrote:
> On Tue, 2004-09-21 at 15:08 +1000, Russell Coker wrote:
> > --- /usr/src/se/policy/domains/program/unused/hald.te   2004-09-17
> > 22:01:26.000000000 +1000
> > +++ ./domains/program/unused/hald.te    2004-09-20 08:47:12.000000000
> > +1000
> > @@ -34,11 +34,10 @@
> >  allow hald_t self:capability { net_admin sys_admin };
> >  can_network(hald_t)
> >  can_ypbind(hald_t)
> > -dbusd_client(system, hald_t)
>
> Why did you do this?  Certainly the HAL daemon is a client of the system
> bus...

ifdef(`dbusd.te', `
allow hald_t system_dbusd_t:dbus { acquire_svc };
dbusd_client(system, hald_t)
')

In the above policy in hald.te someone had made a type and put dbus.te instead 
of dbusd.te.  As that didn't work as desired someone else apparently put 
dbusd_client(system, hald_t) later on in the policy.  We only need one 
instance of dbusd_client(system, hald_t), so now that the dbus.te bug is 
fixed I'm removing the extra one.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
