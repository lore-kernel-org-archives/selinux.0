Subject: Re: [PATCH 1/5] selinux: introduce security_context_str_to_sid
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-2-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AD24F.9040002@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 14:02:55 -0400
MIME-Version: 1.0
In-Reply-To: <1443220459-11042-2-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
> There seems to be a little confusion as to whether the scontext_len
> parameter of security_context_to_sid() includes the nul-byte or
> not. Reading security_context_to_sid_core(), it seems that the
> expectation is that it does not (both the string copying and the test
> for scontext_len being zero hint at that).
>
> Introduce the helper security_context_str_to_sid() to do the strlen()
> call and fix all callers.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c            | 12 ++++--------
>   security/selinux/include/security.h |  2 ++
>   security/selinux/selinuxfs.c        | 26 +++++++++-----------------
>   security/selinux/ss/services.c      |  5 +++++
>   4 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4369d86e588..fd50cd5ac2ec 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -674,10 +674,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>
>   		if (flags[i] == SBLABEL_MNT)
>   			continue;
> -		rc = security_context_to_sid(mount_options[i],
> -					     strlen(mount_options[i]), &sid, GFP_KERNEL);
> +		rc = security_context_str_to_sid(mount_options[i], &sid, GFP_KERNEL);
>   		if (rc) {
> -			printk(KERN_WARNING "SELinux: security_context_to_sid"
> +			printk(KERN_WARNING "SELinux: security_context_str_to_sid"
>   			       "(%s) failed for (dev %s, type %s) errno=%d\n",
>   			       mount_options[i], sb->s_id, name, rc);
>   			goto out;
> @@ -2617,15 +2616,12 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
>
>   	for (i = 0; i < opts.num_mnt_opts; i++) {
>   		u32 sid;
> -		size_t len;
>
>   		if (flags[i] == SBLABEL_MNT)
>   			continue;
> -		len = strlen(mount_options[i]);
> -		rc = security_context_to_sid(mount_options[i], len, &sid,
> -					     GFP_KERNEL);
> +		rc = security_context_str_to_sid(mount_options[i], &sid, GFP_KERNEL);
>   		if (rc) {
> -			printk(KERN_WARNING "SELinux: security_context_to_sid"
> +			printk(KERN_WARNING "SELinux: security_context_str_to_sid"
>   			       "(%s) failed for (dev %s, type %s) errno=%d\n",
>   			       mount_options[i], sb->s_id, sb->s_type->name, rc);
>   			goto out_free_opts;
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 6a681d26bf20..223e9fd15d66 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -166,6 +166,8 @@ int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
>   int security_context_to_sid(const char *scontext, u32 scontext_len,
>   			    u32 *out_sid, gfp_t gfp);
>
> +int security_context_str_to_sid(const char *scontext, u32 *out_sid, gfp_t gfp);
> +
>   int security_context_to_sid_default(const char *scontext, u32 scontext_len,
>   				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 5bed7716f8ab..c02da25d7b63 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -731,13 +731,11 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>   	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>   		goto out;
>
> -	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(scon, &ssid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> -	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(tcon, &tsid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> @@ -819,13 +817,11 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>   		objname = namebuf;
>   	}
>
> -	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(scon, &ssid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> -	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(tcon, &tsid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> @@ -882,13 +878,11 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
>   	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>   		goto out;
>
> -	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(scon, &ssid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> -	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(tcon, &tsid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> @@ -940,7 +934,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
>   	if (sscanf(buf, "%s %s", con, user) != 2)
>   		goto out;
>
> -	length = security_context_to_sid(con, strlen(con) + 1, &sid, GFP_KERNEL);
> +	length = security_context_str_to_sid(con, &sid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> @@ -1000,13 +994,11 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>   	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>   		goto out;
>
> -	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(scon, &ssid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> -	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid,
> -					 GFP_KERNEL);
> +	length = security_context_str_to_sid(tcon, &tsid, GFP_KERNEL);
>   	if (length)
>   		goto out;
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b7df12ba61d8..c550df0e0ff1 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1476,6 +1476,11 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid,
>   					    sid, SECSID_NULL, gfp, 0);
>   }
>
> +int security_context_str_to_sid(const char *scontext, u32 *sid, gfp_t gfp)
> +{
> +	return security_context_to_sid(scontext, strlen(scontext), sid, gfp);
> +}
> +
>   /**
>    * security_context_to_sid_default - Obtain a SID for a given security context,
>    * falling back to specified default if needed.
>
