Subject: Re: user_trans/user_trans_boolean macro
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110820329.16850.8.camel@cobra.ivg2.net>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 12:19:55 -0500
Message-Id: <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 12:12 -0500, Ivan Gyurdiev wrote:
> Well, the role (arg $1) is the user... but I guess I could make that
> into a separate argument, and rename the macro for general usage if you
> prefer.

Seems confusing, as it has nothing to do with a user identity; the
argument is the prefix of a role (and its initial domain).

> By the way, for the second statement I tried to put the role inside the
> boolean, but that wouldn't work for some reason - syntax error?

The conditional policy extensions are only supported for TE rules (not
only in the policy compiler, but all the way down to the kernel logic).
It would be possible to extend to cover RBAC statements as well, but
would obviously require further work.

> That's what I figured it probably does - should I get rid of it?
> I do remember denials without it, but I could test and see.

I'd omit it unless the program truly needs to re-exec itself.

> Well, no, but I usually get denials anyway - there were denials for
> tvtime, gift, and games, but none for mplayer and mozilla, so I thought
> that perhaps they don't need it. It does seem rather strange that
> mozilla wouldn't need it for host lookups.

Yes, since it is all handled internally by the library routines.  I'd be
hesitant to remove without testing with nscd enabled.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
