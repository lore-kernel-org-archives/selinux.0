Subject: Re: object context records for Xen
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
In-Reply-To: <4A92AFB9.6070004@manicmethod.com>
References: <1250865733.2390.85.camel@moss-pluto.epoch.ncsc.mil>
	 <4A92A981.8000608@manicmethod.com>  <4A92AC4D.7080503@manicmethod.com>
	 <1251127167.2428.44.camel@moss-pluto.epoch.ncsc.mil>
	 <4A92AFB9.6070004@manicmethod.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 12:57:42 -0400
Message-Id: <1251133062.2428.57.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-24 at 11:20 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Mon, 2009-08-24 at 11:05 -0400, Joshua Brindle wrote:
> >> Joshua Brindle wrote:
> >>> Stephen Smalley wrote:
> <snip>>>>
> >> Also, is it an error condition if there are ocon's unrelated to the target
> >> platform? Is it possible to create a general policy that may work on multiple
> >> platforms and therefore have a superset of the ocons for each possible platform?
> >
> > I would plan to have checkpolicy reject invalid ocons for the specified
> > target platform, much as it rejects mls statements (or requires them)
> > depending on the MLS flag.
> >
> 
> In retrospect I'm not sure it was a great idea to make it reject mls statements 
> rather than just ignoring them :).

This way the user gets an error that the source configuration that was
specified won't be honored in the generated policy.  I think you'd at
least want a warning, and we know what usually happens to warning
messages (i.e. they get silenced).

> > There really isn't any sharing possible between the Xen policy and the
> > Linux policy, given the significantly different resources and operations
> > (thus classes and permissions), so I don't think it would be useful to
> > support a unified policy.
> >
> > In the case of Linux, Solaris, and FreeBSD, it isn't clear that they
> > actually need distinct ocontext records since they do happen to share
> > the same Unix abstractions for the most part.
> >
> 
> So even if they had same/similar policies they'd have to be rebuilt with a new 
> --target? Would each have ocon sets that just happen to be the same?
> 
> The massive amount of branching in the current reader/writer is fairly 
> discouraging, I hope we can do this in a flexible but straightforward way.

The branching only needs to happen for ocontext records that differ
between the target platforms.  So for Xen, it would disable all of the
Linux ones except for initial SIDs and add its own set.  For Solaris and
FreeBSD, the ones that are in common could always be enabled and only
the divergent ones (if any) would need to be branched based on the
target.

Realistically though I don't think we can share the same/similar
policies among them regardless.  The SEBSD experience suggested that
only the high level form of application policies could be shared but
much of the core system policy had to be custom and of course the
classes/access vectors will differ at least somewhat for each platform.
So the apache.te file might be the same but the raw statements fed into
checkpolicy/checkmodule and the resulting output will differ.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
