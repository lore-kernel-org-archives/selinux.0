MIME-Version: 1.0
In-Reply-To: <20100427200004.3871.27488.stgit@paris.rdu.redhat.com>
References: <20100427200004.3871.27488.stgit@paris.rdu.redhat.com>
Date: Tue, 27 Apr 2010 17:15:53 -0400
Message-ID: <g2k7e0fb38c1004271415v9231a321q34c89e00cabf87d6@mail.gmail.com>
Subject: Re: [PATCH] LSM Audit: rename LSM_AUDIT_NO_AUDIT to
	LSM_AUDIT_DATA_NONE
From: Eric Paris <eparis@parisplace.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

self NACK   old wrong patch!  Sorry!

On Tue, Apr 27, 2010 at 4:00 PM, Eric Paris <eparis@redhat.com> wrote:
> Most of the LSM common audit work uses LSM_AUDIT_DATA_* for the naming.
> This was no so for LSM_AUDIT_NO_AUDIT which means the generic initializer
> cannot be used.  This patch just renames the flag so the generic
> initializer can be used.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>
>  include/linux/lsm_audit.h |    2 +-
>  security/lsm_audit.c      |    2 +-
>  security/selinux/avc.c    |    3 +--
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index ce62294..c523eef 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -33,7 +33,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_IPC     4
>  #define LSM_AUDIT_DATA_TASK    5
>  #define LSM_AUDIT_DATA_KEY     6
> -#define LSM_AUDIT_NO_AUDIT     7
> +#define LSM_AUDIT_DATA_NONE    7
>  #define LSM_AUDIT_DATA_KMOD    8
>        struct task_struct *tsk;
>        union   {
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 893365b..908aa71 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -221,7 +221,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>        }
>
>        switch (a->type) {
> -       case LSM_AUDIT_NO_AUDIT:
> +       case LSM_AUDIT_DATA_NONE:
>                return;
>        case LSM_AUDIT_DATA_IPC:
>                audit_log_format(ab, " key=%d ", a->u.ipc_id);
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 48b5fa4..466295b 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -510,8 +510,7 @@ void avc_audit(u32 ssid, u32 tsid,
>                return;
>        if (!a) {
>                a = &stack_data;
> -               memset(a, 0, sizeof(*a));
> -               a->type = LSM_AUDIT_NO_AUDIT;
> +               LSM_AUDIT_DATA_INIT(a, NONE);
>        }
>        a->selinux_audit_data.tclass = tclass;
>        a->selinux_audit_data.requested = requested;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
