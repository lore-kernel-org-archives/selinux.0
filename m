Subject: Re: [patch][stable] policycoreutils user_u seuser vs. genhomedircon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1212028257.5316.7.camel@defiant.pebenito.net>
References: <1212028257.5316.7.camel@defiant.pebenito.net>
Content-Type: text/plain
Date: Thu, 05 Jun 2008 15:08:39 -0400
Message-Id: <1212692919.2763.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-28 at 22:30 -0400, Chris PeBenito wrote:
> In the stable branch, genhomedircon will ignore making home dir contexts
> for linux users mapped to user_u.  For a long time, this was fine since
> user_u was the default for strict and targeted.  With a merged
> strict-targeted policy, a more targeted-like system will have
> unconfined_u as the default.  If you then try to make a confined user_u
> user, a set of home directory contexts will not be created.  This patch
> fixes the behavior.  I made a cursory look through the trunk C
> genhomedircon, and did not see this behavior, but someone should
> probably doublecheck.
> 
> Index: policycoreutils/scripts/genhomedircon
> ===================================================================
> --- policycoreutils/scripts/genhomedircon	(revision 2890)
> +++ policycoreutils/scripts/genhomedircon	(working copy)
> @@ -193,7 +193,7 @@
>  		return prefix
>  		
>  	def adduser(self, udict, user, seuser, prefix):
> -		if seuser == "user_u" or user == "__default__" or user == "system_u":
> +		if user == "__default__" or user == "system_u":
>  			return
>  		# !!! chooses first prefix in the list to use in the file context !!!
>  		try:
> 

This appears to be the fallback_user in libsemanage genhomedircon.c,
which is initialized to "user_u" and then set to whatever seuser is set
in the __default__ entry of the seusers file (setup_fallback_user).
get_users() then skips users that map to this fallback user with the
exception of "root".  Plus the usual skipping of __default__ and
system_u.  BTW, putting system_u into seusers was never a good idea;
crond should have just been changed in the first place to not perform
getseuserbyname() call for system crontabs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
