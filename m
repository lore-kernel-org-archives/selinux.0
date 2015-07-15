Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FKhfXI001387
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 16:43:41 -0400
Message-ID: <55A6C5FD.4090503@schaufler-ca.com>
Date: Wed, 15 Jul 2015 13:43:41 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 7/7] smack: Don't use security labels for user namespace
 mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-8-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1436989569-69582-8-git-send-email-seth.forshee@canonical.com>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/15/2015 12:46 PM, Seth Forshee wrote:
> Avoid use of untrusted security labels when s_user_ns !=
> init_user_ns:
>  - smk_fetch: refuse to read labels from disk
>  - smack_inode_init_security: return -ENOTSUPP
>  - smack_d_instantiate: don't use security xattrs from disk
>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

I do not like this at all at all. Pretending that Smack
doesn't exist in a user namespace can lead to all sorts
of blatant security violations, both while the filesystem
is mounted in the namespace and in the init namespace.

> ---
>  security/smack/smack_lsm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a143328f75eb..6a849da94f47 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -255,6 +255,9 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
>  	char *buffer;
>  	struct smack_known *skp = NULL;
>  
> +	if (ip->i_sb->s_user_ns != &init_user_ns)
> +		return NULL;
> +
>  	if (ip->i_op->getxattr == NULL)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> @@ -833,6 +836,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  	struct smack_known *dsp = smk_of_inode(dir);
>  	int may;
>  
> +	if (inode->i_sb->s_user_ns != &init_user_ns)
> +		return -ENOTSUPP;
> +
>  	if (name)
>  		*name = XATTR_SMACK_SUFFIX;
>  
> @@ -3176,11 +3182,13 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  		}
>  		/*
>  		 * No xattr support means, alas, no SMACK label.
> -		 * Use the aforeapplied default.
> +		 * Use the aforeapplied default. Also don't use
> +		 * xattrs from userns mounts.
>  		 * It would be curious if the label of the task
>  		 * does not match that assigned.
>  		 */
> -		if (inode->i_op->getxattr == NULL)
> +		if (inode->i_sb->s_user_ns != &init_user_ns ||
> +		    inode->i_op->getxattr == NULL)
>  			break;
>  		/*
>  		 * Get the dentry for xattr.
