MIME-Version: 1.0
In-Reply-To: <20100422173645.23830.42971.stgit@paris.rdu.redhat.com>
References: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
	 <20100422173645.23830.42971.stgit@paris.rdu.redhat.com>
Date: Thu, 22 Apr 2010 14:25:18 -0400
Message-ID: <z2s7e0fb38c1004221125o7a22e446wb12377e51bf75902@mail.gmail.com>
Subject: Re: [PATCH 3/3] SELinux: standardize return code handling in
	selinuxfs.c
From: Eric Paris <eparis@parisplace.org>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I screwed up the subject and the changelog and said selinuxfs instead
of services.c.  James do you want to just fix those if you take these
patches?   If I have to redo them I will fix them.

-eric

On Thu, Apr 22, 2010 at 1:36 PM, Eric Paris <eparis@redhat.com> wrote:
> selinuxfs.c has lots of different standards on how to handle return paths on
> error.  For the most part transition to
>
>        rc=errno
>        if (failure)
>                goto out;
> [...]
> out:
>        cleanup()
>        return rc;
>
> Instead of doing cleanup mid function, or having multiple returns or other
> options.  This doesn't do that for every function, but most of the complex
> functions which have cleanup routines on error.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>
>  security/selinux/ss/services.c |   57 ++++++++++++++++------------------------
>  1 files changed, 23 insertions(+), 34 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1de60ce..5bb58e6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1558,22 +1558,17 @@ static int clone_sid(u32 sid,
>
>  static inline int convert_context_handle_invalid_context(struct context *context)
>  {
> -       int rc = 0;
> +       char *s;
> +       u32 len;
>
> -       if (selinux_enforcing) {
> -               rc = -EINVAL;
> -       } else {
> -               char *s;
> -               u32 len;
> -
> -               if (!context_struct_to_string(context, &s, &len)) {
> -                       printk(KERN_WARNING
> -                      "SELinux:  Context %s would be invalid if enforcing\n",
> -                              s);
> -                       kfree(s);
> -               }
> +       if (selinux_enforcing)
> +               return -EINVAL;
> +
> +       if (!context_struct_to_string(context, &s, &len)) {
> +               printk(KERN_WARNING "SELinux:  Context %s would be invalid if enforcing\n", s);
> +               kfree(s);
>        }
> -       return rc;
> +       return 0;
>  }
>
>  struct convert_context_args {
> @@ -1619,8 +1614,7 @@ static int convert_context(u32 key,
>                                              c->len, &ctx, SECSID_NULL);
>                kfree(s);
>                if (!rc) {
> -                       printk(KERN_INFO
> -                      "SELinux:  Context %s became valid (mapped).\n",
> +                       printk(KERN_INFO "SELinux:  Context %s became valid (mapped).\n",
>                               c->str);
>                        /* Replace string with mapped representation. */
>                        kfree(c->str);
> @@ -1632,8 +1626,7 @@ static int convert_context(u32 key,
>                        goto out;
>                } else {
>                        /* Other error condition, e.g. ENOMEM. */
> -                       printk(KERN_ERR
> -                      "SELinux:   Unable to map context %s, rc = %d.\n",
> +                       printk(KERN_ERR "SELinux:   Unable to map context %s, rc = %d.\n",
>                               c->str, -rc);
>                        goto out;
>                }
> @@ -1719,8 +1712,7 @@ bad:
>        context_destroy(c);
>        c->str = s;
>        c->len = len;
> -       printk(KERN_INFO
> -              "SELinux:  Context %s became invalid (unmapped).\n",
> +       printk(KERN_INFO "SELinux:  Context %s became invalid (unmapped).\n",
>               c->str);
>        rc = 0;
>        goto out;
> @@ -2087,24 +2079,22 @@ int security_get_user_sids(u32 fromsid,
>
>        context_init(&usercon);
>
> +       rc = -EINVAL;
>        fromcon = sidtab_search(&sidtab, fromsid);
> -       if (!fromcon) {
> -               rc = -EINVAL;
> +       if (!fromcon)
>                goto out_unlock;
> -       }
>
> +       rc = -EINVAL;
>        user = hashtab_search(policydb.p_users.table, username);
> -       if (!user) {
> -               rc = -EINVAL;
> +       if (!user)
>                goto out_unlock;
> -       }
> +
>        usercon.user = user->value;
>
> +       rc = -ENOMEM;
>        mysids = kcalloc(maxnel, sizeof(*mysids), GFP_ATOMIC);
> -       if (!mysids) {
> -               rc = -ENOMEM;
> +       if (!mysids)
>                goto out_unlock;
> -       }
>
>        ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
>                role = policydb.role_val_to_struct[i];
> @@ -2121,12 +2111,11 @@ int security_get_user_sids(u32 fromsid,
>                        if (mynel < maxnel) {
>                                mysids[mynel++] = sid;
>                        } else {
> +                               rc = -ENOMEM;
>                                maxnel += SIDS_NEL;
>                                mysids2 = kcalloc(maxnel, sizeof(*mysids2), GFP_ATOMIC);
> -                               if (!mysids2) {
> -                                       rc = -ENOMEM;
> +                               if (!mysids2)
>                                        goto out_unlock;
> -                               }
>                                memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
>                                kfree(mysids);
>                                mysids = mysids2;
> @@ -2134,7 +2123,7 @@ int security_get_user_sids(u32 fromsid,
>                        }
>                }
>        }
> -
> +       rc = 0;
>  out_unlock:
>        read_unlock(&policy_rwlock);
>        if (rc || !mynel) {
> @@ -2142,9 +2131,9 @@ out_unlock:
>                goto out;
>        }
>
> +       rc = -ENOMEM;
>        mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
>        if (!mysids2) {
> -               rc = -ENOMEM;
>                kfree(mysids);
>                goto out;
>        }
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
