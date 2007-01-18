Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0ILVoOb021134
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 16:31:50 -0500
Received: from web36609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0ILWiL4018720
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 21:32:44 GMT
Message-ID: <20070118213244.20020.qmail@web36609.mail.mud.yahoo.com>
Date: Thu, 18 Jan 2007 13:32:43 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: Karl MacMillan <kmacmill@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <1169152199.22731.397.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:



> If the argument is that we should favor the
> traditional over the good,
> then I think you've lost your case.

Ah, but you see, the fact that something
is traditional does not necessarily make
it bad! Call me an old fuddy duddy, but I
actually prefer MAC+Cap to TE. I
understand that many people prefer TE and
that's OK with me.

> Besides, Type Enforcement has quite
> a bit of history behind it, coming from
> at least the LOCK work in the
> early 80s, with the underlying origins traceable to
> the Lampson ('71)
> and Linden ('76) papers, so let's compare
> traditions, shall we?

If you like, although we really should have
a couple beers and an audience for that.

> > Restictive LSM modules ought to be completely
> > stackable if they are in fact strictly
> > restrictive.
> 
> Strictly restrictive relative to base Linux DAC, but
> not necessarily to
> one another.  See the issues noted in the
> next-to-last para of:
> http://www.nsa.gov/selinux/papers/module/x341.html

Yup, the shared blob is the trick to stacking.

> Also, getting the stacker module correct even for
> the "simple"
> combination of capabilities and SELinux was
> surprisingly difficult - see
> the lsm list archives for the history of that. 
> Serge made a valiant
> effort of fixing each issue as I discovered them,
> but the history shows
> that it isn't as trivial as one might think.

It's true that the Capabilities stacking in
SELinux points out some important issues.
Given the mixture of privilege models its
tough to see a better approach.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
