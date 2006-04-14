Subject: Re: semanage patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200604142108.28814.russell@coker.com.au>
References: <200604142108.28814.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 13:08:56 -0400
Message-Id: <1145034536.18244.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-04-14 at 21:08 +1000, Russell Coker wrote:
> The attached patch against the semanage utility in rawhide allows it to create 
> and modify prefixes.

Thanks, merged as of policycoreutils 1.30.6.  Note that adding further
examples in the man page to the EXAMPLES section introduced by Thomas
Bleher would be helpful.

> Also when testing semanage I noticed that it let me remove a SE Linux user 
> when a login still referred to it.  After doing so it then wouldn't let me 
> recreate the user (with a confusing error message).  But as that bug didn't 
> stop me from doing my work I haven't taken the time to fix it.
> 
> As the complexity of the semanage utility continues to increase I think that 
> we need to split it into separate programs selogin, seuser, seport, 
> seinterface, sefcontext, and setranslation.  This will make the man page 
> easier to understand and generally increase ease of use.  It will also allow 
> shell command-completion to do more of the work for the sysadmin.  What do 
> you think?

Not clear to me whether this will ultimately be helpful to users or more
confusing.  iptables, auditctl, etc. don't split up the interface like
this.  More useful to users would likely just be a more extensive
description in the man page and more examples there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
