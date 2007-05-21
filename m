Subject: Re: [PATCH 1/4] selinux: add support for querying object classes
	and permissions from the running policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <Line.LNX.4.64.0705211253190.17008@d.namei>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
	 <11797619172804-git-send-email-cpebenito@tresys.com>
	 <Line.LNX.4.64.0705211253190.17008@d.namei>
Content-Type: text/plain
Date: Mon, 21 May 2007 18:44:18 +0000
Message-Id: <1179773058.10995.17.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-05-21 at 13:02 -0400, James Morris wrote:
> On Mon, 21 May 2007, Christopher J. PeBenito wrote:
> > +int security_get_classes(char ***classes, int *nclasses)
> > +{
> > +	int rc = -ENOMEM;
> > +
> > +	POLICY_RDLOCK;
> > +
> > +	*nclasses = policydb.p_classes.nprim;
> > +	*classes = kzalloc(*nclasses*sizeof(*classes),GFP_KERNEL);
> 
> Use kcalloc().
> 
> Needs to be GFP_ATOMIC because you're holding a spinlock.
[...]
> (Have you tested this with all of the lock debugging enabled ?)

Nope, my mistake.  I'm a kernel coding newbie :)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
