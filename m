Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6OKMqPa004548
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2013 16:22:52 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so860175lbi.20
        for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2013 13:22:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130416225619.GA30164@sh-el5.eng.rdu2.redhat.com>
References: <20130416225619.GA30164@sh-el5.eng.rdu2.redhat.com>
Date: Wed, 24 Jul 2013 16:22:47 -0400
Message-ID: <CACLa4pu=DEBO_Wfvh1PZEj3D2yQuxgz_dvQCLh677P7O6hKEPA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: consider filesystem subtype in policies
From: Eric Paris <eparis@parisplace.org>
To: Anand Avati <avati@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, kraman@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 16, 2013 at 6:56 PM, Anand Avati <avati@redhat.com> wrote:
> Not considering sub filesystem has the following limitation. Support
> for SELinux in FUSE is dependent on the particular userspace
> filesystem, which is identified by the subtype. For e.g, GlusterFS,
> a FUSE based filesystem supports SELinux (by mounting and processing
> FUSE requests in different threads, avoiding the mount time
> deadlock), whereas other FUSE based filesystems (identified by a
> different subtype) have the mount time deadlock.
>
> By considering the subtype of the filesytem in the SELinux policies,
> allows us to specify a filesystem subtype, in the following way:
>
> fs_use_xattr fuse.glusterfs gen_context(system_u:object_r:fs_t,s0);
>
> This way not all FUSE filesystems are put in the same bucket and
> subjected to the limitations of the other subtypes.
>
> Signed-off-by: Anand Avati <avati@redhat.com>

[snip]

>  int security_genfs_sid(const char *fstype, char *name, u16 sclass,
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b4feecc..f4e6b0b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2324,25 +2324,51 @@ out:
>  /**
>   * security_fs_use - Determine how to handle labeling for a filesystem.
>   * @fstype: filesystem type
> + * @subtype: filesystem subtype (e.g userspace FUSE filesystem)
>   * @behavior: labeling behavior
>   * @sid: SID for filesystem (superblock)
>   */
>  int security_fs_use(
>         const char *fstype,
> +       const char *subtype,
>         unsigned int *behavior,
>         u32 *sid)
>  {
>         int rc = 0;
>         struct ocontext *c;
> +       struct ocontext *base = NULL;
> +       int baselen;
> +       char *sub;
>
>         read_lock(&policy_rwlock);
>
> -       c = policydb.ocontexts[OCON_FSUSE];
> -       while (c) {
> -               if (strcmp(fstype, c->u.name) == 0)
> +       for (c = policydb.ocontexts[OCON_FSUSE]; c; c = c->next) {
> +               if (strcmp(fstype, c->u.name) == 0) {
> +                       if (!subtype)
> +                               /* exact match, no subtype requested */
> +                               break;
> +                       /* save this for now, in case we do not find
> +                          a subtype match */
> +                       base = c;
> +               }
> +               if (!subtype)
> +                       continue;
> +               sub = strchr(c->u.name, '.');
> +               if (!sub)
> +                       /* not an entry with subtype */
> +                       continue;
> +               baselen = (sub - c->u.name);
> +               if (strncmp(fstype, c->u.name, baselen) || fstype[baselen])

we have no idea how long fstype is.  baselen could be HUGE.  I'm
trying to redo this patch right now.  No need for you to comment.
Just putting it out there.

> +                       /* fstype does not match */
> +                       continue;
> +               sub++; /* move past '.' */
> +               if (strcmp(subtype, sub) == 0)
> +                       /* exact match of fstype AND subtype */
>                         break;
> -               c = c->next;
>         }
> +       if (!c)
> +               /* in case we had found an fstype match but no subtype match */
> +               c = base;
>
>         if (c) {
>                 *behavior = c->v.behavior;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
