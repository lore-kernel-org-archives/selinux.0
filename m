Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KK6wjp010459
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 16:06:58 -0400
Received: by qkgx75 with SMTP id x75so39582162qkg.1
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 13:06:57 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>, sds@tycho.nsa.gov,
 linux-audit@redhat.com
Subject: Re: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
Date: Wed, 20 May 2015 16:06:55 -0400
Message-ID: <3322194.9bHnmkPx3f@sifl>
In-Reply-To: <1428616171-14767-1-git-send-email-jeffv@google.com>
References: <1428616171-14767-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, April 09, 2015 02:49:31 PM Jeff Vander Stoep wrote:
> Add information about ioctl calls to the LSM audit data. Log the
> file path and command number.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  include/linux/lsm_audit.h |  7 +++++++
>  security/lsm_audit.c      | 15 +++++++++++++++
>  2 files changed, 22 insertions(+)

No real comment other than we should include the linux-audit list on this 
patch (added to the To/CC line).

>From an audit perspective the only new field would be the ioctl number which 
is represented by the "ioctlcmd" name.  Does anyone in the audit space have 
any strong feelings on this one way or another?

> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 1cc89e9..ffb9c9d 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -40,6 +40,11 @@ struct lsm_network_audit {
>  	} fam;
>  };
> 
> +struct lsm_ioctlop_audit {
> +	struct path path;
> +	u16 cmd;
> +};
> +
>  /* Auxiliary data to use in generating the audit record. */
>  struct common_audit_data {
>  	char type;
> @@ -53,6 +58,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_KMOD	8
>  #define LSM_AUDIT_DATA_INODE	9
>  #define LSM_AUDIT_DATA_DENTRY	10
> +#define LSM_AUDIT_DATA_IOCTL_OP	11
>  	union 	{
>  		struct path path;
>  		struct dentry *dentry;
> @@ -68,6 +74,7 @@ struct common_audit_data {
>  		} key_struct;
>  #endif
>  		char *kmod_name;
> +		struct lsm_ioctlop_audit *op;
>  	} u;
>  	/* this union contains LSM specific data */
>  	union {
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 69fdf3b..7147c17 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -245,6 +245,21 @@ static void dump_common_audit_data(struct audit_buffer
> *ab, }
>  		break;
>  	}
> +	case LSM_AUDIT_DATA_IOCTL_OP: {
> +		struct inode *inode;
> +
> +		audit_log_d_path(ab, " path=", &a->u.op->path);
> +
> +		inode = a->u.op->path.dentry->d_inode;
> +		if (inode) {
> +			audit_log_format(ab, " dev=");
> +			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> +			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +		}
> +
> +		audit_log_format(ab, " ioctlcmd=%hx", a->u.op->cmd);
> +		break;
> +	}
>  	case LSM_AUDIT_DATA_DENTRY: {
>  		struct inode *inode;

-- 
paul moore
www.paul-moore.com
