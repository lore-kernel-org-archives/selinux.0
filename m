Message-Id: <200404131830.i3DIUlJx012722@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "SELinux List" <SELinux@tycho.nsa.gov>
Cc: "'Selinux Dev'" <selinux-dev@tresys.com>
Subject: RE: Policy backward compatibility
Date: Tue, 13 Apr 2004 14:31:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1081863227.21530.69.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> 
> On Tue, 2004-04-13 at 09:22, Stephen Smalley wrote:
> > And, yes, this will require separate policy.conf files for the different
> > versions, but that is going to be necessary anyway for significant
> > changes to the policy.  Even for the netlink class partitioning, you
> > don't want to compile a newer policy.conf that has the fine-grained
> > netlink classes with an older checkpolicy, as the best it could do would
> > be to map them all to the old netlink class, possibly opening up
> > unintended access.
> 
> And likewise for any significant use of booleans, since the
> compatibility code just discards the conditional statements entirely
> rather than generating statements based on the initial boolean value...
> 

It is clear that generating old format binary policies from policy.conf
files with significant use of new features is not going to work well. This
doesn't mean, however, that checkpolicy shouldn't have the ability to
generate an old binary policy format from a policy.conf that doesn't use
those features.

I think that keeping multiple versions of checkpolicy around (that have to
be compiled from separate source trees) is going to be a huge problem. The
modutils example is not exactly analogous. In that case it was clear that
there were only going to be 2 versions of the utilities. In the checkpolicy
case there are going to be at least 3 and likely more. I definitely
understand that maintaining backwards compatibility code can be problematic
- Apol supports policies as old as pre-version 11, for example. I believe
this will be less of a problem than the multiple versions of checkpolicy,
though.

I suggest that binary compatibility can be dropped from the kernel. It was
useful for the conditional policy transition, but I think it can be dropped
without too much user pain. I also suggest that the backwards compatibility
should be retained in the same way as it is now for checkpolicy. That means
that by default checkpolicy only generates the latest version and if the
user requests, it will generate a specific older version binary (through the
-c VERSION flag). If the policy.conf file they are compiling uses newer
features it can take an appropriate action (like dropping the conditional
policy) or refuse to generate the policy entirely.

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
