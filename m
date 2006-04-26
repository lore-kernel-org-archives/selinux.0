Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3QLFtkr027716
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 17:15:55 -0400
Received: from xcgca812.northgrum.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3QLFrvp018418
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 21:15:54 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: login error with strict modular ref pol in RHEL4 
Date: Wed, 26 Apr 2006 17:15:22 -0400
Message-ID: <85A664F2F3F2D1409EE003C7D3D52EE4038A0201@xcgoh901.northgrum.com>
From: "Dinardo, Michael \(Xetron\)" <Michael.Dinardo@ngc.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu] 
> Sent: Wednesday, April 26, 2006 4:19 PM
> To: Dinardo, Michael (Xetron)
> Cc: Daniel J Walsh; selinux@tycho.nsa.gov
> Subject: Re: login error with strict modular ref pol in RHEL4 
> 
> On Wed, 26 Apr 2006 15:58:55 EDT, "Dinardo, Michael (Xetron)" said:
> 
> > 1. Installed the following (along with all other tools at
> > ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR/i386/):
> > 	selinux-policy-2.2.28-1.rhel4.src.rpm
> > 	selinux-policy-2.2.28-1.rhel4.noarch.rpm
> > 	selinux-policy-targeted-2.2.28-1.rhel4.noarch.rpm
> > 2. Installed the source from /usr/src/redhat:
> > 	rpmbuild -bp /usr/src/redhat/SPECS/selinux-policy.spec
> > 	cd /usr/src/redhat/BUILD/serefpolicy-2.2.23
> > 	make install-src
> 
> Umm.. why are you installing a 2.2.23 policy like this, when 
> you just downloaded 2.2.28?  Why isn't the 2.2.28-1 RPM 
> installable as is, and what problems are you setting yourself 
> up for by doing this behind RPM's back?

Nice catch.  My mistake.  I reinstalled using 2.2.28.  However, I can no
longer log in at all again. 

> 
> > 4. Renamed /etc/selinux/targeted to /etc/selinux/strict
> 
> No good can come from this.  Especially since rpm thinks the 
> 2.2.28.1 strict policy is installed....

I have to agree.  However, when I install 2.2.28-1 source it gets
installed in /etc/selinux/refpolicy/src.  Nothing else is installed in
this directory.  In /etc/selinux/targeted there are subdirectories for
contexts, modules, policy, etc.  Since I don't have a strict policy I am
using targeted directory to get these other components.  I would
definitely prefer to have a strict policy directory to put the source
into as I believe this may be related to my current trouble.  Is there
an appropriate strict reference policy that I could install first?

   

> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
