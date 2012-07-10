Message-ID: <1341926278.16964.7.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 2/2] SELinux: do not check open perms if they are not
 known to policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Date: Tue, 10 Jul 2012 09:17:58 -0400
In-Reply-To: <1341598410-29965-2-git-send-email-eparis@redhat.com>
References: <1341598410-29965-1-git-send-email-eparis@redhat.com>
	 <1341598410-29965-2-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-06 at 14:13 -0400, Eric Paris wrote:
> When I introduced open perms policy didn't understand them and I
> implemented them as a policycap.  When I added the checking of open perm
> to truncate I forgot to conditionalize it on the userspace defined
> policy capability.  Running an old policy with a new kernel will not
> check open on open(2) but will check it on truncate.  Conditionalize the
> truncate check the same as the open check.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> Cc: stable@vger.kernel.org # 3.4.x
> ---
>  security/selinux/hooks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e94349b..ac9e7099 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2709,7 +2709,7 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
>  		return dentry_has_perm(cred, dentry, FILE__SETATTR);
>  
> -	if (ia_valid & ATTR_SIZE)
> +	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE))
>  		av |= FILE__OPEN;
>  
>  	return dentry_has_perm(cred, dentry, av);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
