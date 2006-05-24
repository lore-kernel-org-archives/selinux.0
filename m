Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Jeremy Katz <katzj@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148410219.24463.234.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
	 <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
	 <4473531C.2010802@redhat.com>
	 <1148410219.24463.234.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 24 May 2006 13:24:52 -0400
Message-Id: <1148491493.16558.42.camel@orodruin.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-23 at 14:50 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-23 at 14:23 -0400, Daniel J Walsh wrote:
> > Stephen Smalley wrote:
> > > Below is an updated version of the kernel patch to support rpm labeling
> > > of files before policy load, with a couple of bug fixes and a re-base to
> > > 2.6.17-rc4-mm3.  Note that before we can upstream this, we need to
> > > resolve the issues of how rpm will check file label validity after
> > > policy load (e.g. calling security_check_context(3) on each label from
> > > the header), what corrective action rpm will take if a file label is
> > > invalid (options suggested include relabeling to unlabeled_t, relabeling
> > > to the context returned by the system policy via matchpathcon, or
> > > reverting the install), and the issues raised by Karl above (as they
> > > also affect the ability of rpm to perform such verification and
> > > correction sanely).
> > >
> > >   
> > As far as I understand it, rpm will not go back and check the whether 
> > the context are sane.  If the
> > postinstall of policy fails, the context on disk will be incorrect and 
> > treated like unlabeled_t.
> 
> I don't think that is really a viable option.  It is undesirable from
> both a robustness POV and a security POV.  rpm shouldn't leave the
> filesystem littered with files that have invalid contexts (which could
> later be turned into valid contexts by another package's policy module,
> suddenly granting access to those files or permissions to those
> executables unexpectedly), nor should it leave the system littered with
> packages whose policy couldn't be installed, as the package software may
> then run with the wrong permissions.

So the thing not covered in my other mail is "policy couldn't be
installed" -- but what would cause that to be the case?  I'd rather make
it so that we don't hit that (via dependencies, as I'm guessing that's
the likely culprit) rather than trying to hack around it.

Jeremy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
