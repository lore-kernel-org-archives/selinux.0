Message-ID: <5527C32E.5080605@tycho.nsa.gov>
Date: Fri, 10 Apr 2015 08:33:50 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
References: <1428616171-14767-1-git-send-email-jeffv@google.com>
In-Reply-To: <1428616171-14767-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/09/2015 05:49 PM, Jeff Vander Stoep wrote:
> Add information about ioctl calls to the LSM audit data. Log the
> file path and command number.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  include/linux/lsm_audit.h |  7 +++++++
>  security/lsm_audit.c      | 15 +++++++++++++++
>  2 files changed, 22 insertions(+)
> 
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
> @@ -245,6 +245,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>  		}
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
>  
> 
