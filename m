MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] checkpolicy: implement handling of unknown classesandpermissions
Date: Thu, 27 Sep 2007 09:35:02 -0400
Message-ID: <1190900103.4282.2.camel@gorn.columbia.tresys.com>
In-Reply-To: <1190395644.15178.5.camel@gorn.columbia.tresys.com>
References: <1189103186.3418.35.camel@localhost.localdomain> <1190144886.14037.105.camel@moss-spartans.epoch.ncsc.mil> <1190395644.15178.5.camel@gorn.columbia.tresys.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Eric Paris" <eparis@redhat.com>, <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-21 at 13:27 -0400, Christopher J. PeBenito wrote:
> On Tue, 2007-09-18 at 15:48 -0400, Stephen Smalley wrote:
> > On Thu, 2007-09-06 at 14:26 -0400, Eric Paris wrote:
> > > Add a new command line options, -U (allow,reject,deny), to
> > checkmodule
> > > and checkpolicy which sets the handle_unknown config flag.  Default
> > to
> > > deny unknowns which is how things have been in the past.  Also add
> > > dismod and dispol support.
> > >
> > > -Eric
> > 
> > Thanks, merged as of checkpolicy 2.0.4.
> > 
> > Chris/Dan:  we need some way to select the flag setting for the policy
> > build.  The -U {allow,reject,deny} setting needs to be passed to
> > checkmodule _only_ when building the base module, or to checkpolicy
> > when
> > building a monolithic policy.
> 
> Here is a patch for this, I haven't committed this to trunk yet, as I'd
> prefer to wait for the next stable release of the toolchain (when its
> that, btw?).

I committed a slightly modified version of this that won't add the -U
setting unless the build.conf setting is used, for compatibility with
the stable toolchain branch.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
