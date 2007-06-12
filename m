Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <620792.60154.qm@web36608.mail.mud.yahoo.com>
References: <620792.60154.qm@web36608.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 07:31:25 -0400
Message-Id: <1181647885.17547.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-11 at 14:43 -0700, Casey Schaufler wrote:
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
> and dealing with interactions with them. My only concern is that you
> seem to be sneaking around the "additional restrictions" LSM model,
> with the justification being that the bit you're taking authority over
> is also an LSM module. I am not convinced that you're completely
> within the spirit of the thing, although I would hesitate to accuse
> you of not playing nicely quite yet.

First, I don't think this has to be mutually exclusive of file
capabilities.  Each of them provides a way to grant capabilities to
programs.

Second, this isn't a misuse of LSM; it follows naturally from the fact
that LSM defines the capable() hook entirely (there is no base logic -
it was all moved into the capability module) and thus can
authoritatively grant capabilities.  The only reason that SELinux is
presently restrictive wrt to capabilities is because we have it calling
the secondary module.  Also, it seems that FreeBSD is going down this
path of using their MAC framework to authoritatively control their
privileges.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
