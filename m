Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHDPwK006453
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:13:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 419F0h0rkGz25sSH
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:13:24 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 419F0g0yncz25sSW
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:13:23 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id x13-v6so609630lff.10
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-7-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-7-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:13:10 -0400
Message-ID: <CAHC9VhQ6yvALQ=PZC4Wmt4eLw_t_QeHxUsd_GeFP2cJ03P5W6w@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 06/13] selinux: Cleanup printk logging in
 services
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/services.c | 71 +++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8057e19dc15f..9ad9b6c2f0a7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -136,8 +136,7 @@ static int selinux_set_mapping(struct policydb *pol,
>
>                 p_out->value = string_to_security_class(pol, p_in->name);
>                 if (!p_out->value) {
> -                       printk(KERN_INFO
> -                              "SELinux:  Class %s not defined in policy.\n",
> +                       pr_info("SELinux:  Class %s not defined in policy.\n",
>                                p_in->name);
>                         if (pol->reject_unknown)
>                                 goto err;
> @@ -156,8 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
>                         p_out->perms[k] = string_to_av_perm(pol, p_out->value,
>                                                             p_in->perms[k]);
>                         if (!p_out->perms[k]) {
> -                               printk(KERN_INFO
> -                                      "SELinux:  Permission %s in class %s not defined in policy.\n",
> +                               pr_info("SELinux:  Permission %s in class %s not defined in policy.\n",
>                                        p_in->perms[k], p_in->name);
>                                 if (pol->reject_unknown)
>                                         goto err;
> @@ -170,7 +168,7 @@ static int selinux_set_mapping(struct policydb *pol,
>         }
>
>         if (print_unknown_handle)
> -               printk(KERN_INFO "SELinux: the above unknown classes and permissions will be %s\n",
> +               pr_info("SELinux: the above unknown classes and permissions will be %s\n",
>                        pol->allow_unknown ? "allowed" : "denied");
>
>         out_map->size = i;
> @@ -644,7 +642,7 @@ static void context_struct_compute_av(struct policydb *policydb,
>
>         if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
>                 if (printk_ratelimit())
> -                       printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
> +                       pr_warn("SELinux:  Invalid class %hu\n", tclass);
>                 return;
>         }
>
> @@ -793,7 +791,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>
>         ocontext = sidtab_search(sidtab, oldsid);
>         if (!ocontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                         __func__, oldsid);
>                 rc = -EINVAL;
>                 goto out;
> @@ -801,7 +799,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>
>         ncontext = sidtab_search(sidtab, newsid);
>         if (!ncontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                         __func__, newsid);
>                 rc = -EINVAL;
>                 goto out;
> @@ -809,7 +807,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>
>         tcontext = sidtab_search(sidtab, tasksid);
>         if (!tcontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                         __func__, tasksid);
>                 rc = -EINVAL;
>                 goto out;
> @@ -883,7 +881,7 @@ int security_bounded_transition(struct selinux_state *state,
>         rc = -EINVAL;
>         old_context = sidtab_search(sidtab, old_sid);
>         if (!old_context) {
> -               printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
> +               pr_err("SELinux: %s: unrecognized SID %u\n",
>                        __func__, old_sid);
>                 goto out;
>         }
> @@ -891,7 +889,7 @@ int security_bounded_transition(struct selinux_state *state,
>         rc = -EINVAL;
>         new_context = sidtab_search(sidtab, new_sid);
>         if (!new_context) {
> -               printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
> +               pr_err("SELinux: %s: unrecognized SID %u\n",
>                        __func__, new_sid);
>                 goto out;
>         }
> @@ -1040,14 +1038,14 @@ void security_compute_xperms_decision(struct selinux_state *state,
>
>         scontext = sidtab_search(sidtab, ssid);
>         if (!scontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, ssid);
>                 goto out;
>         }
>
>         tcontext = sidtab_search(sidtab, tsid);
>         if (!tcontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, tsid);
>                 goto out;
>         }
> @@ -1129,7 +1127,7 @@ void security_compute_av(struct selinux_state *state,
>
>         scontext = sidtab_search(sidtab, ssid);
>         if (!scontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, ssid);
>                 goto out;
>         }
> @@ -1140,7 +1138,7 @@ void security_compute_av(struct selinux_state *state,
>
>         tcontext = sidtab_search(sidtab, tsid);
>         if (!tcontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, tsid);
>                 goto out;
>         }
> @@ -1183,7 +1181,7 @@ void security_compute_av_user(struct selinux_state *state,
>
>         scontext = sidtab_search(sidtab, ssid);
>         if (!scontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, ssid);
>                 goto out;
>         }
> @@ -1194,7 +1192,7 @@ void security_compute_av_user(struct selinux_state *state,
>
>         tcontext = sidtab_search(sidtab, tsid);
>         if (!tcontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, tsid);
>                 goto out;
>         }
> @@ -1310,7 +1308,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>                         *scontext = scontextp;
>                         goto out;
>                 }
> -               printk(KERN_ERR "SELinux: %s:  called before initial "
> +               pr_err("SELinux: %s:  called before initial "
>                        "load_policy on unknown SID %d\n", __func__, sid);
>                 rc = -EINVAL;
>                 goto out;
> @@ -1323,7 +1321,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>         else
>                 context = sidtab_search(sidtab, sid);
>         if (!context) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                         __func__, sid);
>                 rc = -EINVAL;
>                 goto out_unlock;
> @@ -1678,14 +1676,14 @@ static int security_compute_sid(struct selinux_state *state,
>
>         scontext = sidtab_search(sidtab, ssid);
>         if (!scontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, ssid);
>                 rc = -EINVAL;
>                 goto out_unlock;
>         }
>         tcontext = sidtab_search(sidtab, tsid);
>         if (!tcontext) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, tsid);
>                 rc = -EINVAL;
>                 goto out_unlock;
> @@ -1911,7 +1909,8 @@ static inline int convert_context_handle_invalid_context(
>                 return -EINVAL;
>
>         if (!context_struct_to_string(policydb, context, &s, &len)) {
> -               printk(KERN_WARNING "SELinux:  Context %s would be invalid if enforcing\n", s);
> +               pr_warn("SELinux:  Context %s would be invalid if enforcing\n",
> +                       s);
>                 kfree(s);
>         }
>         return 0;
> @@ -1962,7 +1961,7 @@ static int convert_context(u32 key,
>                                               c->len, &ctx, SECSID_NULL);
>                 kfree(s);
>                 if (!rc) {
> -                       printk(KERN_INFO "SELinux:  Context %s became valid (mapped).\n",
> +                       pr_info("SELinux:  Context %s became valid (mapped).\n",
>                                c->str);
>                         /* Replace string with mapped representation. */
>                         kfree(c->str);
> @@ -1974,7 +1973,7 @@ static int convert_context(u32 key,
>                         goto out;
>                 } else {
>                         /* Other error condition, e.g. ENOMEM. */
> -                       printk(KERN_ERR "SELinux:   Unable to map context %s, rc = %d.\n",
> +                       pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
>                                c->str, -rc);
>                         goto out;
>                 }
> @@ -2033,7 +2032,7 @@ static int convert_context(u32 key,
>                         oc = oc->next;
>                 rc = -EINVAL;
>                 if (!oc) {
> -                       printk(KERN_ERR "SELinux:  unable to look up"
> +                       pr_err("SELinux:  unable to look up"
>                                 " the initial SIDs list\n");
>                         goto bad;
>                 }
> @@ -2065,7 +2064,7 @@ static int convert_context(u32 key,
>         context_destroy(c);
>         c->str = s;
>         c->len = len;
> -       printk(KERN_INFO "SELinux:  Context %s became invalid (unmapped).\n",
> +       pr_info("SELinux:  Context %s became invalid (unmapped).\n",
>                c->str);
>         rc = 0;
>         goto out;
> @@ -2170,13 +2169,13 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>         newpolicydb->len = len;
>         /* If switching between different policy types, log MLS status */
>         if (policydb->mls_enabled && !newpolicydb->mls_enabled)
> -               printk(KERN_INFO "SELinux: Disabling MLS support...\n");
> +               pr_info("SELinux: Disabling MLS support...\n");
>         else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
> -               printk(KERN_INFO "SELinux: Enabling MLS support...\n");
> +               pr_info("SELinux: Enabling MLS support...\n");
>
>         rc = policydb_load_isids(newpolicydb, &newsidtab);
>         if (rc) {
> -               printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
> +               pr_err("SELinux:  unable to load the initial SIDs\n");
>                 policydb_destroy(newpolicydb);
>                 goto out;
>         }
> @@ -2187,7 +2186,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>
>         rc = security_preserve_bools(state, newpolicydb);
>         if (rc) {
> -               printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
> +               pr_err("SELinux:  unable to preserve booleans\n");
>                 goto err;
>         }
>
> @@ -2207,7 +2206,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>         args.newp = newpolicydb;
>         rc = sidtab_map(&newsidtab, convert_context, &args);
>         if (rc) {
> -               printk(KERN_ERR "SELinux:  unable to convert the internal"
> +               pr_err("SELinux:  unable to convert the internal"
>                         " representation of contexts in the new SID"
>                         " table\n");
>                 goto err;
> @@ -2999,7 +2998,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>         rc = -EINVAL;
>         context1 = sidtab_search(sidtab, sid);
>         if (!context1) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                         __func__, sid);
>                 goto out_unlock;
>         }
> @@ -3007,7 +3006,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>         rc = -EINVAL;
>         context2 = sidtab_search(sidtab, mls_sid);
>         if (!context2) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                         __func__, mls_sid);
>                 goto out_unlock;
>         }
> @@ -3104,14 +3103,14 @@ int security_net_peersid_resolve(struct selinux_state *state,
>         rc = -EINVAL;
>         nlbl_ctx = sidtab_search(sidtab, nlbl_sid);
>         if (!nlbl_ctx) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, nlbl_sid);
>                 goto out;
>         }
>         rc = -EINVAL;
>         xfrm_ctx = sidtab_search(sidtab, xfrm_sid);
>         if (!xfrm_ctx) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
> +               pr_err("SELinux: %s:  unrecognized SID %d\n",
>                        __func__, xfrm_sid);
>                 goto out;
>         }
> @@ -3202,7 +3201,7 @@ int security_get_permissions(struct selinux_state *state,
>         rc = -EINVAL;
>         match = hashtab_search(policydb->p_classes.table, class);
>         if (!match) {
> -               printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
> +               pr_err("SELinux: %s:  unrecognized class %s\n",
>                         __func__, class);
>                 goto out;
>         }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
