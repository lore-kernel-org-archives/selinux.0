Date: Mon, 11 Jun 2007 17:24:02 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
Message-ID: <20070611222402.GA21593@sergelap.austin.ibm.com>
References: <20070611204336.GA30846@sergelap.austin.ibm.com> <620792.60154.qm@web36608.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <620792.60154.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> 
> --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > Extend SELinux to allow capabilities to be granted authoritatively.
> > > Introduces a new cap_override access vector to indicate when the
> > > secondary module (i.e. capability or dummy) check should be skipped.
> > > Handle the new class gracefully even if the policy does not yet have
> > > it defined.
> > 
> > Cool.
> > 
> > If we decide to have this take the place of the file capabilities i
> > guess we're all set, but if both are going upstream, do you think
> > CONFIG_SECURITY_FILE_CAPABILITIES and selinux should be mutually
> > exclusive?
> 
> We're already living in a non-stacking LSM environment, so whatever
> SELinux wants to do with capabilities is Stephen's affair, I suppose.
> I assume that this is in preparation for file based capabilities

Well it arguably obviates the need for file based capabilities :)

Stephen, I assume the intent would be to simply assign capabilities to
TE types, not to eventually add a new 'capability' field to the selinux
context akin to the mls field?

That changes how one uses these a bit, in an interesting way.  Let's say
we want users running ping to get CAP_NET_RAW.  If ping were then
exploited to exec something else, then with capabilities it would lose
CAP_NET_RAW.  How should (or should?) that be emulated in selinux?

thanks,
-serge

> and dealing with interactions with them. My only concern is that you
> seem to be sneaking around the "additional restrictions" LSM model,
> with the justification being that the bit you're taking authority over
> is also an LSM module. I am not convinced that you're completely
> within the spirit of the thing, although I would hesitate to accuse
> you of not playing nicely quite yet.
> 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
