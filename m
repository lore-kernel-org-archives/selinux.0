Subject: Re: [PATCH 09/18] selinux: remove secondary ops call to
 inode_follow_link
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <1233201347-17568-10-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
	 <1233201347-17568-2-git-send-email-jmorris@namei.org>
	 <1233201347-17568-3-git-send-email-jmorris@namei.org>
	 <1233201347-17568-4-git-send-email-jmorris@namei.org>
	 <1233201347-17568-5-git-send-email-jmorris@namei.org>
	 <1233201347-17568-6-git-send-email-jmorris@namei.org>
	 <1233201347-17568-7-git-send-email-jmorris@namei.org>
	 <1233201347-17568-8-git-send-email-jmorris@namei.org>
	 <1233201347-17568-9-git-send-email-jmorris@namei.org>
	 <1233201347-17568-10-git-send-email-jmorris@namei.org>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 08:07:44 -0500
Message-Id: <1233234464.3264.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-01-28 at 19:55 -0800, James Morris wrote:
> Remove secondary ops call to inode_follow_link, which is
> a noop in capabilities.
> 
> Signed-off-by: James Morris <jmorris@namei.org>
> ---
>  security/selinux/hooks.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)

NAK looks like white space damage.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0362192..e96cce3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2674,11 +2674,7 @@ static int selinux_inode_readlink(struct dentry *dentry)
>  static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *nameidata)
>  {
>  	const struct cred *cred = current_cred();
> -	int rc;
> -
> -	rc = secondary_ops->inode_follow_link(dentry, nameidata);
> -	if (rc)
> -		return rc;
> +	
>  	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
>  }
>  



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
