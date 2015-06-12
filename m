Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CGNNMJ003233
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 12:23:23 -0400
Received: by vnbf190 with SMTP id f190so6809604vnb.0
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 09:23:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434124902-12427-1-git-send-email-jeffv@google.com>
References: <1434124902-12427-1-git-send-email-jeffv@google.com>
Date: Fri, 12 Jun 2015 09:23:12 -0700
Message-ID: <CAFJ0LnGRgXm1-zfp4=hd-GCPrFx=Lb2X95Gejp7a8NSGiSjQPA@mail.gmail.com>
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

On Fri, Jun 12, 2015 at 9:01 AM, Jeff Vander Stoep <jeffv@google.com> wrote:
> Add information about ioctl calls to the LSM audit data. Log the
> file path and command number.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Acked-by: Nick Kralevich <nnk@google.com>

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
> index 1d34277..9f6c649 100644
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
