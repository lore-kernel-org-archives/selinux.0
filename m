Subject: Re: Question concerning building policy modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1187798223.20340.10.camel@moss-lions.epoch.ncsc.mil>
References: <1187203804.26375.69.camel@moss-lions.epoch.ncsc.mil>
	 <46CB51E8.5020603@redhat.com>
	 <1187781201.1451.221.camel@moss-spartans.epoch.ncsc.mil>
	 <1187787478.13874.57.camel@gorn>
	 <1187798223.20340.10.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 17:04:53 +0000
Message-Id: <1187802293.13874.81.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 11:57 -0400, James Carter wrote:
> On Wed, 2007-08-22 at 12:57 +0000, Christopher J. PeBenito wrote:
> > On Wed, 2007-08-22 at 07:13 -0400, Stephen Smalley wrote:
> > > On Tue, 2007-08-21 at 16:58 -0400, Daniel J Walsh wrote:
> > > > James Carter wrote:
> > > > > Instead, the information to build a module for Fedora is in
> > > > > the /usr/share/selinux/devel directory.  This directory would seem to be
> > > > > independent of the policy type, even though it is only for building
> > > > > Fedora policies.  This seems confusing.  The devel directory should have
> > > > > stuff that all policies need or could use.
> > > > >
> > > > > Wouldn't it make sense that if I wanted to build a module for the
> > > > > current policy, I would use the Makefile in devel which would look
> > > > > at /etc/selinux/config and include the Makefile for the current policy,
> > > > > but if I wanted to compile for a particular policy, I would just use the
> > > > > Makefile in its /usr/share directory?
> > > > >
> > > > >   
> > > > This is an old argument, between strict and targeted policy.   I did not 
> > > > like the idea of building
> > > > policy modules different for each type of policy,  Since almost everyone 
> > > > is exactly the same or would not work on different policies.  This seems 
> > > > to be proven to be correct as we move to strict/targeted policy merge. 
> > > > 
> > > > So you add a level of complexity with very little value.  Just imagine a 
> > > > third party shipping multiple policies for the
> > > > same package depending on an infinite number of policy packages.
> > > > 
> > > > targeted, strict, mls, olpc, CDS-ABC.
> > > > 
> > > > And almost guaranteed the same policy package would work for all or the 
> > > > package will only really work on one (MLS).  So I went with the least 
> > > > common denominator and only ship one devel package.  All interfaces for 
> > > > all packages ship. 
> > > 
> > > But does this allow people using a policy other than targeted to build
> > > loadable modules using the /usr/share/selinux/devel/Makefile?  Or do
> > > they have to separately install refpolicy to do that?  That's the
> > > problem, IIUC.
> > 
> > It works because the headers are currently the same between the policy
> > types.  
> Which is not always the case.

Yes, which is why the upstream still has the separate sets.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
