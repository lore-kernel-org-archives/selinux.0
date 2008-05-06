Subject: Re: [PATCH v4] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
	 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 06 May 2008 16:17:28 -0400
Message-Id: <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-06 at 11:40 -0400, Stephen Smalley wrote:
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1c864c0..1fe4550 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5153,6 +5159,12 @@ static int selinux_setprocattr(struct task_struct *p,
>  			size--;
>  		}
>  		error = security_context_to_sid(value, size, &sid);
> +		if (error == -EINVAL && !strcmp(name, "fscreate")) {
> +			if (!capable(CAP_MAC_ADMIN))
> +				return error;
> +			error = security_context_to_sid_force(value, size,
> +							      &sid);
> +		}
>  		if (error)
>  			return error;
>  	}

I realized that this part of the patch won't work as advertised, at
least not presently.

The corresponding logic in the setxattr hooks will work, and is what I
exercised in my example sequence.  And I believe that rpm does
setfilecon() the files after creation rather than using setfscreatecon()
followed by creat, so it should work for rpm's purposes.

The problem with this support in the fscreate case is that we later turn
the SID back into a context in selinux_inode_init_security() for setting
the xattr for the new file in the same transaction as the create, and as
the context will still be undefined by policy, we will get back the
unlabeled context instead and that will be stored on disk.

So, the question is should we just drop this hunk of the patch and only
support this functionality for setxattr, or do we need
selinux_inode_init_security() to recover the original context string
(which is available in the SID table, just not returned by
security_sid_to_context when it isn't defined by policy) and use that
for the on-disk xattr value?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
