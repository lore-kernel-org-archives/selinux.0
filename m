Subject: Re: Policy compiler issues.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Bush, Daniel" <Daniel.Bush@boeing.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
References: 
	 <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
Content-Type: text/plain
Message-Id: <1085055603.521.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 08:20:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-05-19 at 18:10, Bush, Daniel wrote:
>   I'm trying to deploy SELInux in an embedded environment. Footprint
> space is tight, every kilobyte counts. The environment is also fairly
> dynamic, the users list and assigned roles can change fairly rapidly.

That seems like an odd combination - embedded but highly dynamic users
and roles?  How do you plan on distributing updates to the users list
and user-role authorizations?

>   It's my understanding that whenever the users' list changes (aside
> from default users)in a SELinux system, that the policy files and
> security labels need to be re-compiled. Is there any way around that?
> Can a user be assigned a set of (non-default user) roles without
> re-compiling the security system?

If you want the user to be recognized by SELinux as an individual user,
then you need to modify the policy (either directly patching the binary
policy or modifying the source and recompiling) and reload it.  There is
already a user_u user that is a fallback for ordinary users who do not
have a specific entry in the SELinux policy, so if you don't add the
user to the SELinux policy, he will be mapped to user_u and limited to
the roles authorized for user_u.  Direct manipulation of the binary
policy is possible, and I expect that libraries and tools for doing so
will become available; note the earlier work by Tresys on binary policy
patching that was posted to this list, plus the posting re future work
on loadable binary policy modules. 

>   Another question: Can SELinux be compiled under uClibc? I'm not
> having much luck at that, and I was wondering if something special
> needed to be done, or if anybody had any tips.

I haven't tried.  What kind of problem are you encountering?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
