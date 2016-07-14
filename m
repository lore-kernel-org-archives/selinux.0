Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6EMHrrU026230
 for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2016 18:17:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id c199so7811314oig.1
 for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2016 15:17:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
References: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Jul 2016 18:17:32 -0400
Message-ID: <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
Subject: Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
To: william.c.roberts@intel.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>, sgrubb@redhat.com,
 linux-audit@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Thu, Jul 14, 2016 at 3:29 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> ioctlcmd is currently printing hex numbers, but their is no leading
> 0x. Thus things like ioctlcmd=1234 are misleading, as the base is
> not evident.
>
> Correct this by adding 0x as a prefix, so ioctlcmd=1234 becomes ioctlcmd=0x1234.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  security/lsm_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NOTE: adding Steve Grubb and the audit mailing list to the CC line

Like it or not, I believe the general standard/convention when it
comes to things like this is to leave off the "0x" prefix; the idea
being that is saves precious space in the audit logs and the value is
only ever going to be in hex anyway.

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index cccbf30..82e4dbb 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -257,7 +257,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>                         audit_log_format(ab, " ino=%lu", inode->i_ino);
>                 }
>
> -               audit_log_format(ab, " ioctlcmd=%hx", a->u.op->cmd);
> +               audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
>                 break;
>         }
>         case LSM_AUDIT_DATA_DENTRY: {
> --
> 1.9.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

-- 
paul moore
www.paul-moore.com
