Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CGcQVI001103
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 12:38:26 -0400
Received: from web36609.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CGcO8g013742
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 16:38:25 GMT
Date: Tue, 12 Jun 2007 09:38:19 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1181662393.17547.203.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <616061.57558.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2007-06-12 at 08:08 -0700, Casey Schaufler wrote:
> ...
> > 
> > The file capabilty mechanism has been through two CC evaluations
> > for which I have the certificates, so I think that you may have
> > trouble substantiating your claim that it lacks an analyzable policy.
> 
> I'll clarify:  The file capability mechanism encodes policy in the
> filesystem state on a per-file basis,

Uh, yeah. They are stored in extended attributes. This provides
superior locality of reference. Extended attributes are a good
thing for security mechanisms, just have a read through the threads
about AA on the LSM list.

> so to analyze the effective policy
> of the system, you have to snapshot the current per-file capability
> bitmaps scattered throughout your filesystem,

You need to know where you've put them. It's not a matter of going
out and finding them, it's a matter of being careful where you
put them in the first place. You make it sound hard. It isn't,
and it has been done successfully.

> and even then, your
> ability to analyze reachability is limited by the lack of explicit
> transition controls.  Versus being able to analyze a TE policy where the
> capability state is directly encoded based on equivalence classes
> (types), and you can directly check reachability all without looking at
> the filesystem state.

It's true. Capabilities don't implement TE. They aren't intended
to, and the arguement that they are flawwed because they don't is
distracting.
   
> ...
> > 
> > Well, I don't like it, but I do appreciate the fact that the
> > disintegration is explicit.
> > 
> > Do y'all plan to let the rest of the world know what you're up
> > to, or do you plan to present this as a feit accompli?
> 
> I'm not sure what that means.  It is just a patch to selinux (it touches
> no other code, and has no side effects in the absence of new policy),
> and it would go in via the usual route, which ultimately should include
> posting to linux-kernel.  No different than a patch to any other kernel
> subsystem.

Always be wary when Stephen says "just"!

You're right, you are "just" changing the way SELinux uses existing
interfaces. You are "just" abandoning the notion of LSM stacking.
You are "just" taking the first step toward replacing the Linux
security model with the SELinux security model.

And you are correct, it's all being done within framework, policy,
and procedures. Groan Grumble Snort Complain. Well, carry on then.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
