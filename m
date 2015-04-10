Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3ALIDbk007321
 for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2015 17:18:13 -0400
Received: by vnbg7 with SMTP id g7so8606007vnb.11
 for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2015 14:18:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1428616171-14767-1-git-send-email-jeffv@google.com>
References: <1428616171-14767-1-git-send-email-jeffv@google.com>
Date: Fri, 10 Apr 2015 14:18:10 -0700
Message-ID: <CAFJ0LnGPtnNpUfV+qYe8jBd_ZXGfJKBTRr3ZWQJ0d3_Ki1A4RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
From: Nick Kralevich <nnk@google.com>
To: Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 9, 2015 at 2:49 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
> Add information about ioctl calls to the LSM audit data. Log the
> file path and command number.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Acked-by:  Nick Kralevich <nnk@google.com>

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
>         } fam;
>  };
>
> +struct lsm_ioctlop_audit {
> +       struct path path;
> +       u16 cmd;
> +};
> +
>  /* Auxiliary data to use in generating the audit record. */
>  struct common_audit_data {
>         char type;
> @@ -53,6 +58,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_KMOD    8
>  #define LSM_AUDIT_DATA_INODE   9
>  #define LSM_AUDIT_DATA_DENTRY  10
> +#define LSM_AUDIT_DATA_IOCTL_OP        11
>         union   {
>                 struct path path;
>                 struct dentry *dentry;
> @@ -68,6 +74,7 @@ struct common_audit_data {
>                 } key_struct;
>  #endif
>                 char *kmod_name;
> +               struct lsm_ioctlop_audit *op;
>         } u;
>         /* this union contains LSM specific data */
>         union {
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 69fdf3b..7147c17 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -245,6 +245,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>                 }
>                 break;
>         }
> +       case LSM_AUDIT_DATA_IOCTL_OP: {
> +               struct inode *inode;
> +
> +               audit_log_d_path(ab, " path=", &a->u.op->path);
> +
> +               inode = a->u.op->path.dentry->d_inode;
> +               if (inode) {
> +                       audit_log_format(ab, " dev=");
> +                       audit_log_untrustedstring(ab, inode->i_sb->s_id);
> +                       audit_log_format(ab, " ino=%lu", inode->i_ino);
> +               }
> +
> +               audit_log_format(ab, " ioctlcmd=%hx", a->u.op->cmd);
> +               break;
> +       }
>         case LSM_AUDIT_DATA_DENTRY: {
>                 struct inode *inode;
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
