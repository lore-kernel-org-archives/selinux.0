Return-Path: <SRS0=45Fk=U4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66964C4321A
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 01:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1993B2083B
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 01:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnYas++G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF2BBP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jun 2019 21:01:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45461 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfF2BBP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jun 2019 21:01:15 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so16224706ioc.12;
        Fri, 28 Jun 2019 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jIYnXKb+EQS2Suhb5zeUtaC0B5zlTv2T7Ej1weHxMbE=;
        b=XnYas++GrpApkSoIPqg2bc4g0JuGkHxPJ/3d+/2SxiVqSRlAhg6ap4ZLBMMQ8XFCHr
         6KSFpNfiLH6Mimd6j5zR+LEFXWOOfzbadPMzerIUJWOLvtnw/unD8AgR9CkKhaH3ts3s
         DIckBSQ6w5idTZBmVm2Yl6PQIPaoH1P915EjP/UF8AC03yz4yoFIpMo6/bTvtImHZeRc
         txjD1VWc7FZrJWzYmEm31YX1jeTwzkXKNNcxOXZKw1hcOTSk6W3ij3F/3FabssjQRYpZ
         Kt2aUvAd4KOed+2Wup6ae41A+bRsrpzl3hakmhaPu/MEbI1YYHIq3a3fI47O+lSi1KzT
         GENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jIYnXKb+EQS2Suhb5zeUtaC0B5zlTv2T7Ej1weHxMbE=;
        b=qzU/U5ienrgeHmjWR5fajAFlL12BM7BouarUCFgUt/+NMTbYcbKzU7fYgw5/gkd/lR
         SwSegmNqoxAQ1my+S0MYwEO38yqSg2umYZIkTki21vW0vVj5ypUYuJ+j0Moe+3XLXqoy
         fs8Zn6pndDzGfXt9PqUXMQ1njlU27WgJRKN2ofrauxjn8/kTdL1LDzi51mkvntm0kImQ
         uhnT3kJjSC74ijoGMSxLHSPi3zwxRCvnjl4Ot9SX7AEssIkpm8tQamwvwtdlOyeHh8rZ
         dZJT2E3pmbA3Oh1D5i7WV/z+MNi3KAvHviGO6F53S2nuGHkdFhUq2tTB6L5oe01NsLYv
         RTOg==
X-Gm-Message-State: APjAAAXuk29bDLughHurZ1tYSzojrI7VqCLWHg+sE/SyQOxCZRj4hJ/N
        EGHy33IlqQFXfo+xuCQxkWZHqUYlxfg0jTHoTxc=
X-Google-Smtp-Source: APXvYqz6eL9raQrrwq0DWAnyAXTo2p+dCNuoeaGaySelipIdm7R6Nr8lVSvBbjiOntZJARIxwTYx+F9dCYiizw+rcBU=
X-Received: by 2002:a02:4484:: with SMTP id o126mr15108045jaa.34.1561770073624;
 Fri, 28 Jun 2019 18:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-16-casey@schaufler-ca.com> <89561452-86f9-fd9a-1390-0cd4bde1fd62@tycho.nsa.gov>
 <7944672e-a590-44a3-743a-48c1785a5464@schaufler-ca.com> <CAB9W1A1nwE7WBZqTe-GV8xNb83_B2ybV7cco++nfMjtDz9NJrg@mail.gmail.com>
In-Reply-To: <CAB9W1A1nwE7WBZqTe-GV8xNb83_B2ybV7cco++nfMjtDz9NJrg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Fri, 28 Jun 2019 21:01:01 -0400
Message-ID: <CAB9W1A29fCn=cH_Mx-g-P6M-5t+832ayhMmjy3PFZ-BOL3BuDQ@mail.gmail.com>
Subject: Fwd: [PATCH v4 15/23] LSM: Specify which LSM to display
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, keescook@chromium.org,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 28, 2019 at 12:15 PM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
>
> On 6/28/2019 7:45 AM, Stephen Smalley wrote:
> > On 6/26/19 3:22 PM, Casey Schaufler wrote:
> >> Create a new entry "display" in /proc/.../attr for controlling
> >> which LSM security information is displayed for a process.
> >> The name of an active LSM that supplies hooks for human readable
> >> data may be written to "display" to set the value. The name of
> >> the LSM currently in use can be read from "display".
> >> At this point there can only be one LSM capable of display
> >> active.
> >
> > IIUC, presently, at the end of the entire series,
> >
> > 1) Any process can change its display attribute to any enabled security=
 module, and no security module can veto that change.
>
> That is correct. If a security module could hoard the display it
> could prevent user space from functioning in a multiple module
> environment.
>
> > 2) The display attribute is inherited across fork and exec, even execs =
that change credentials, and again no security module has control over the =
inheritance of this attribute.
>
> Also correct. Scripts don't work otherwise.

It's a security hole waiting to happen. Unprivileged caller sets its
display value to Smack on a mostly SELinux system that happens to
enable Smack too, then exec's a credential-changing SELinux-aware
program that uses one of the libselinux APIs to set one of the
/proc/self/attr attributes to a different SELinux context. Due to the
change in display, the SELinux-aware program instead ends up setting
one of the Smack attributes and therefore the desired SELinux context
is never applied to the process or file or socket or whatever.

>
> >
> > 3) Setting the display attribute affects more than just the contexts re=
ad or written by the process itself:
> > - Contexts reported in audit logs,
> > - Contexts passed across binder (generated in sender context, delivered=
 to receiver),
> > - Contexts passed to NFS servers for new files,
> > - Contexts returned by NFS servers for existing files,
> > - Netlink-related contexts (?possibly generated in sender context rathe=
r than receiver context?),
> > - This list may not be complete.
>
> Any of which can be changed should a more rational behavior be proposed.
> One possibility is to use lsm=3D'value',lsm=3D'value' encoding for intern=
al
> communications, but there's been considerable resistance to anything
> like that.

These are also security holes waiting to happen.  Processes can use it
to hide their SELinux contexts from the audit logs, forge different
SELinux contexts on binder IPC, forge file contexts to which they have
no SELinux permissions on new files, ... All they need is stacking to
be enabled and one other module that helpfully lets them set attribute
values that look like SELinux contexts, and then they can set those
and switch their display at the right time.

>
> > 4) A security_secid_to_secctx() in one process' context (e.g. sender) o=
r with one display value followed later by a security_secctx_to_secid() cal=
l in a different process' context (e.g. receiver) or with a different displ=
ay value may ask a different security module to perform the reverse transla=
tion of the context than the forward translation.
>
> Do you have an example of where this might happen?
> Contexts are rarely used within the kernel. The usual
> behavior is to generate them, send them out to user space,
> and delete them. They get cached in some networking code,
> but not in cases where more than one (existing) security
> module will ever use them. Binder may be an exception, but
> only SELinux (currently) supports binder.

Haven't looked but I don't like the asymmetry of the interface.
Doesn't matter that only SELinux supports binder if  you ever want any
other security module other than SELinux enabled at the same time as
SELinux.

>
>
> > Is that correct?  If so, it seems problematic.
>
> Balancing backward compatibility with new behavior is hard!
> What would you suggest for audit logs? Should we put all LSM
> data in every record? Is NFS a concern for anyone not using
> SELinux?

Yes to all on audit if stacking is going to be real.  And yes, I think
other security modules will care about NFS if they are serious.

>
> There is no user space that uses display, and it's going
> to take some time to work out all the kinks before we even
> think about teaching systemd about it.

That doesn't make it acceptable to introduce a mechanism that weakens
security now.

>
> >
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   fs/proc/base.c      |   1 +
> >>   security/security.c | 129 ++++++++++++++++++++++++++++++++++++++----=
--
> >>   2 files changed, 113 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> index ddef482f1334..7bf70e041315 100644
> >> --- a/fs/proc/base.c
> >> +++ b/fs/proc/base.c
> >> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] =
=3D {
> >>       ATTR(NULL, "fscreate",        0666),
> >>       ATTR(NULL, "keycreate",        0666),
> >>       ATTR(NULL, "sockcreate",    0666),
> >> +    ATTR(NULL, "display",        0666),
> >>   #ifdef CONFIG_SECURITY_SMACK
> >>       DIR("smack",            0555,
> >>           proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> >> diff --git a/security/security.c b/security/security.c
> >> index 3180a6f30625..82e29c477fa4 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
> >>   static struct kmem_cache *lsm_inode_cache;
> >>     char *lsm_names;
> >> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> >> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init =3D {
> >> +    .lbs_task =3D sizeof(int),    /* slot number for the "display" LS=
M */
> >> +};
> >>     /* Boot-time LSM user choice */
> >>   static __initdata const char *chosen_lsm_order;
> >> @@ -423,8 +425,10 @@ static int lsm_append(const char *new, char **res=
ult)
> >>     /*
> >>    * Current index to use while initializing the lsmblob secid list.
> >> + * Pointers to the LSM id structures for local use.
> >>    */
> >>   static int lsm_slot;
> >> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
> >>     /**
> >>    * security_add_hooks - Add a modules hooks to the hook lists.
> >> @@ -444,6 +448,7 @@ void __init security_add_hooks(struct security_hoo=
k_list *hooks, int count,
> >>       if (lsmid->slot =3D=3D LSMBLOB_NEEDED) {
> >>           if (lsm_slot >=3D LSMBLOB_ENTRIES)
> >>               panic("%s Too many LSMs registered.\n", __func__);
> >> +        lsm_slotlist[lsm_slot] =3D lsmid;
> >>           lsmid->slot =3D lsm_slot++;
> >>           init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
> >>                  lsmid->slot);
> >> @@ -564,6 +569,8 @@ int lsm_inode_alloc(struct inode *inode)
> >>    */
> >>   static int lsm_task_alloc(struct task_struct *task)
> >>   {
> >> +    int *display;
> >> +
> >>       if (blob_sizes.lbs_task =3D=3D 0) {
> >>           task->security =3D NULL;
> >>           return 0;
> >> @@ -572,6 +579,15 @@ static int lsm_task_alloc(struct task_struct *tas=
k)
> >>       task->security =3D kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
> >>       if (task->security =3D=3D NULL)
> >>           return -ENOMEM;
> >> +
> >> +    /*
> >> +     * The start of the task blob contains the "display" LSM slot num=
ber.
> >> +     * Start with it set to the invalid slot number, indicating that =
the
> >> +     * default first registered LSM be displayed.
> >> +     */
> >> +    display =3D task->security;
> >> +    *display =3D LSMBLOB_INVALID;
> >> +
> >>       return 0;
> >>   }
> >>   @@ -1563,14 +1579,24 @@ int security_file_open(struct file *file)
> >>     int security_task_alloc(struct task_struct *task, unsigned long cl=
one_flags)
> >>   {
> >> +    int *odisplay =3D current->security;
> >> +    int *ndisplay;
> >>       int rc =3D lsm_task_alloc(task);
> >>   -    if (rc)
> >> +    if (unlikely(rc))
> >>           return rc;
> >> +
> >>       rc =3D call_int_hook(task_alloc, 0, task, clone_flags);
> >> -    if (unlikely(rc))
> >> +    if (unlikely(rc)) {
> >>           security_task_free(task);
> >> -    return rc;
> >> +        return rc;
> >> +    }
> >> +
> >> +    ndisplay =3D task->security;
> >> +    if (ndisplay && odisplay)
> >> +        *ndisplay =3D *odisplay;
> >> +
> >> +    return 0;
> >>   }
> >>     void security_task_free(struct task_struct *task)
> >> @@ -1967,10 +1993,29 @@ int security_getprocattr(struct task_struct *p=
, const char *lsm, char *name,
> >>                   char **value)
> >>   {
> >>       struct security_hook_list *hp;
> >> +    int *display =3D current->security;
> >> +    int slot =3D 0;
> >> +
> >> +    if (!strcmp(name, "display")) {
> >> +        /*
> >> +         * lsm_slot will be 0 if there are no displaying modules.
> >> +         */
> >> +        if (lsm_slot =3D=3D 0)
> >> +            return -EINVAL;
> >> +        if (*display !=3D LSMBLOB_INVALID)
> >> +            slot =3D *display;
> >> +        *value =3D kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> >> +        if (*value)
> >> +            return strlen(*value);
> >> +        return -ENOMEM;
> >> +    }
> >>         hlist_for_each_entry(hp, &security_hook_heads.getprocattr, lis=
t) {
> >>           if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
> >>               continue;
> >> +        if (lsm =3D=3D NULL && *display !=3D LSMBLOB_INVALID &&
> >> +            *display !=3D hp->lsmid->slot)
> >> +            continue;
> >>           return hp->hook.getprocattr(p, name, value);
> >>       }
> >>       return -EINVAL;
> >> @@ -1980,10 +2025,46 @@ int security_setprocattr(const char *lsm, cons=
t char *name, void *value,
> >>                size_t size)
> >>   {
> >>       struct security_hook_list *hp;
> >> +    char *term;
> >> +    char *cp;
> >> +    int *display =3D current->security;
> >> +    int rc =3D -EINVAL;
> >> +    int slot =3D 0;
> >> +
> >> +    if (!strcmp(name, "display")) {
> >> +        /*
> >> +         * lsm_slot will be 0 if there are no displaying modules.
> >> +         */
> >> +        if (lsm_slot =3D=3D 0 || size =3D=3D 0)
> >> +            return -EINVAL;
> >> +        cp =3D kzalloc(size + 1, GFP_KERNEL);
> >> +        if (cp =3D=3D NULL)
> >> +            return -ENOMEM;
> >> +        memcpy(cp, value, size);
> >> +
> >> +        term =3D strchr(cp, ' ');
> >> +        if (term =3D=3D NULL)
> >> +            term =3D strchr(cp, '\n');
> >> +        if (term !=3D NULL)
> >> +            *term =3D '\0';
> >> +
> >> +        for (slot =3D 0; slot < lsm_slot; slot++)
> >> +            if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
> >> +                *display =3D lsm_slotlist[slot]->slot;
> >> +                rc =3D size;
> >> +                break;
> >> +            }
> >> +
> >> +        kfree(cp);
> >> +        return rc;
> >> +    }
> >>         hlist_for_each_entry(hp, &security_hook_heads.setprocattr, lis=
t) {
> >>           if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
> >>               continue;
> >> +        if (lsm =3D=3D NULL && *display !=3D LSMBLOB_INVALID &&
> >> +            *display !=3D hp->lsmid->slot)
> >> +            continue;
> >>           return hp->hook.setprocattr(name, value, size);
> >>       }
> >>       return -EINVAL;
> >> @@ -2003,15 +2084,15 @@ EXPORT_SYMBOL(security_ismaclabel);
> >>   int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u=
32 *seclen)
> >>   {
> >>       struct security_hook_list *hp;
> >> -    int rc;
> >> +    int *display =3D current->security;
> >>         hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,=
 list) {
> >>           if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D lsm_=
slot))
> >>               continue;
> >> -        rc =3D hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> >> -                          secdata, seclen);
> >> -        if (rc !=3D 0)
> >> -            return rc;
> >> +        if (*display =3D=3D LSMBLOB_INVALID || *display =3D=3D hp->ls=
mid->slot)
> >> +            return hp->hook.secid_to_secctx(
> >> +                    blob->secid[hp->lsmid->slot],
> >> +                    secdata, seclen);
> >>       }
> >>       return 0;
> >>   }
> >> @@ -2021,16 +2102,15 @@ int security_secctx_to_secid(const char *secda=
ta, u32 seclen,
> >>                    struct lsmblob *blob)
> >>   {
> >>       struct security_hook_list *hp;
> >> -    int rc;
> >> +    int *display =3D current->security;
> >>         lsmblob_init(blob, 0);
> >>       hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, l=
ist) {
> >>           if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D lsm_=
slot))
> >>               continue;
> >> -        rc =3D hp->hook.secctx_to_secid(secdata, seclen,
> >> -                          &blob->secid[hp->lsmid->slot]);
> >> -        if (rc !=3D 0)
> >> -            return rc;
> >> +        if (*display =3D=3D LSMBLOB_INVALID || *display =3D=3D hp->ls=
mid->slot)
> >> +            return hp->hook.secctx_to_secid(secdata, seclen,
> >> +                        &blob->secid[hp->lsmid->slot]);
> >>       }
> >>       return 0;
> >>   }
> >> @@ -2038,7 +2118,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
> >>     void security_release_secctx(char *secdata, u32 seclen)
> >>   {
> >> -    call_void_hook(release_secctx, secdata, seclen);
> >> +    struct security_hook_list *hp;
> >> +    int *display =3D current->security;
> >> +
> >> +    hlist_for_each_entry(hp, &security_hook_heads.release_secctx, lis=
t)
> >> +        if (*display =3D=3D LSMBLOB_INVALID ||
> >> +            *display =3D=3D hp->lsmid->slot) {
> >> +            hp->hook.release_secctx(secdata, seclen);
> >> +            return;
> >> +        }
> >>   }
> >>   EXPORT_SYMBOL(security_release_secctx);
> >>   @@ -2163,8 +2251,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
> >>   int security_socket_getpeersec_stream(struct socket *sock, char __us=
er *optval,
> >>                         int __user *optlen, unsigned len)
> >>   {
> >> -    return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock=
,
> >> -                optval, optlen, len);
> >> +    int *display =3D current->security;
> >> +    struct security_hook_list *hp;
> >> +
> >> +    hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_s=
tream,
> >> +                 list)
> >> +        if (*display =3D=3D LSMBLOB_INVALID || *display =3D=3D hp->ls=
mid->slot)
> >> +            return hp->hook.socket_getpeersec_stream(sock, optval,
> >> +                                 optlen, len);
> >> +    return -ENOPROTOOPT;
> >>   }
> >>     int security_socket_getpeersec_dgram(struct socket *sock, struct s=
k_buff *skb,
> >>
> >
