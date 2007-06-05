Subject: Re: policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <method@manicmethod.com>,
        Mark Goldman <mgoldman@tresys.com>
In-Reply-To: <46602E03.8080200@redhat.com>
References: <46602E03.8080200@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 10:05:05 -0400
Message-Id: <1181052305.25769.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-01 at 10:32 -0400, Daniel J Walsh wrote:
> policycoreutils should be checking if the user is the default_type not 
> hard coded to user_u.
> 
> Also if selinux is not enabled, the verification step should not 
> happen.  This is causing problems in chroot environments for the install.
> 
> Both these fixes should go into the new genhomedircon that is being 
> added to semanage.

Thanks, merged into the current genhomedircon script on trunk.

> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-2.0.19/scripts/genhomedircon
> --- nsapolicycoreutils/scripts/genhomedircon	2007-05-18 09:58:33.000000000 -0400
> +++ policycoreutils-2.0.19/scripts/genhomedircon	2007-06-01 10:29:32.000000000 -0400
> @@ -193,7 +193,7 @@
>  		return prefix
>  		
>  	def adduser(self, udict, user, seuser, prefix):
> -		if seuser == "user_u" or user == "__default__" or user == "system_u":
> +		if seuser == self.default_user or user == "__default__" or user == "system_u":
>  			return
>  		# !!! chooses first prefix in the list to use in the file context !!!
>  		try:
> @@ -263,7 +263,7 @@
>  				i = i.replace("system_u", seuser)
>  				# Validate if the generated context exists.  Some user types may not exist
>  				scon = i.split()[-1]
> -				if selinux.security_check_context(scon) == 0:
> +				if selinux.is_selinux_enabled() < 1 or selinux.security_check_context(scon) == 0:
>  					ret = ret+i
>  		fd.close()
>  		return ret
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
