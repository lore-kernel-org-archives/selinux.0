Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GEAfrT006986
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 10:10:41 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7GEA2qL029883
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 14:10:02 GMT
Subject: Re: [patch] setting default role from ssh
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, nalin@redhat.com,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1092513257.4515.28.camel@nexus.verbum.private>
References: <1092513257.4515.28.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1092665369.16631.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 16 Aug 2004 10:09:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-08-14 at 15:54, Colin Walters wrote:
> A while back in a conversation with Dan we agreed that being able to do
> something like:
> 
> ssh root:sysadm_r@machine
> 
> would be nice.  Now I've finally gotten around to implementing it.  I
> discovered when reading the openssh source that it already accepts a ':'
> in the username, and extracts it into a variable called "style" in the
> authentication context.  After digging a bit more, apparently it's used
> only on BSD, for "BSD auth", which I guess is sort of like PAM.  Why you
> would want/need users to be able to specify styles, I don't know.
> 
> Anyways, this "style" variable, unused on Linux, was easy enough to turn
> into a SELinux "role" argument.  I just had to modify a few functions to
> pass it down into the SELinux setexeccon and tty relabeling.

This is certainly a useful enhancement.  Using the "style" in this
manner should likely be discussed with the openssh developers in order
to determine whether we might be able to do this in a way that is
acceptable upstream and avoids any conflict with other uses of the
"style", e.g. possibly using some prefix of the style to indicate that
it is being used for SELinux, a domain of interpretation (DOI)
indicator.  Otherwise, you'll likely have to carry it as a separate
patch forever, SE-BSD won't be able to use it, and there is the
potential for future conflict in Linux if someone else wants to use the
style for another purpose.

> Now, looking at the duplicative code in those two sections, I'm thinking
> that it would make sense to have a libselinux function for this.
> Probably something like:
> 
> int
> get_default_context_with_role (const char *user, security_context_t fromcon, 
>                                const char *role, security_context_t *newcon);

One question I have is whether the code should do a reachability check
for the specified role and fail immediately if it is not reachable;
get_default_context normally only returns contexts that are reachable
from the 'fromcon' (i.e. process transition permission is granted
between the 'fromcon' and the returned contexts).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
