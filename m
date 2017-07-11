Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6BL0miC006185
 for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2017 17:00:48 -0400
Received: by mail-lf0-f47.google.com with SMTP id b207so2475799lfg.2
 for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2017 14:00:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710202553.20668-1-sds@tycho.nsa.gov>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Jul 2017 17:00:41 -0400
Message-ID: <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As systemd ramps up enabling NoNewPrivileges (either explicitly in
> service unit files or as a side effect of other security-related
> settings in service unit files), we're increasingly running afoul of
> its interactions with SELinux...

We already talked about this in the other thread so I'll refrain from
repeating myself.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3a06afb..f0c11c2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2326,24 +2326,37 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
>                 return 0; /* No change in credentials */
>
>         /*
> -        * The only transitions we permit under NNP or nosuid
> -        * are transitions to bounded SIDs, i.e. SIDs that are
> -        * guaranteed to only be allowed a subset of the permissions
> -        * of the current SID.
> +        * If the policy enables the nnp_transition policy capability,
> +        * then we permit transitions under NNP or nosuid if the
> +        * policy explicitly allows nnp_transition permission between
> +        * the old and new contexts.
>          */
> -       rc = security_bounded_transition(old_tsec->sid, new_tsec->sid);
> -       if (rc) {
> +       if (selinux_policycap_nnptransition) {
> +               rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> +                                 SECCLASS_PROCESS,
> +                                 PROCESS__NNP_TRANSITION, NULL);
> +               if (!rc)
> +                       return 0;

This is interesting, we had been talking about domain transitions
under NNP, but we never really discussed transitions under nosuid
mounts, and the motivation for this patch appears to be entirely
around NNP alone.

I think the policycap/permission approach is reasonable, but I wonder
if we should separate this into two permissions, e.g. process {
nnp_transition nosuid_transition }, especially since such a change in
the future would likely require another policycap?

-- 
paul moore
www.paul-moore.com
