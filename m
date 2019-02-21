Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB377C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 09:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB06420842
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 09:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBUJNS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:13:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44964 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJNR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 04:13:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so44216433otj.11
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 01:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3ygXgusGprlOje1eIZw+/zSDZwG6MCNNmPXhh5Pcv8=;
        b=aaeWuHoZSdODs8N6ubCIPbFVAS/WXn+5wHz7uzQ5fFoY1LOKF8dVltsRPhF/EWl6s5
         4rW+WikCsj4AZydf/qICnUuLBEmWbb23IU85Nnn3sZ+ahi5RAMGBg45XToN2xc7gfdv6
         NaeDtB20XgUJNOsi1S4QBkpofDwLDA+Qo30gbYsS8SW2nrk0BZ2c+D51mispxx4fI7+9
         Mast7eYsZY8CsApiPqf4YSw2NK0mK6AIkBIPAC4qQVUztAssEgTemS9Eu4R7kmbXazv+
         7EZ/d1P+LRMFs2iPwvbLbAL85aLSUqIyAK0942ddtN5wv7pEOXX/QxG7GeI36wwyWcJJ
         Tvzw==
X-Gm-Message-State: AHQUAuZkBe1PA216vtbtzfyby2TYCMaLE9Mil0d/u+75Ww5YD4LeVNiZ
        VTzKELc2qV+3uQyyAsLnIlSaKjYjqi71wTlTL/7xzDwa
X-Google-Smtp-Source: AHgI3Ib8OF41OM583C0JPLbrWBJ8mV4x/lZEFAGVWkrQwRXQlauX1gSGWkdv1lXsrtUtjxac54jfPF4WyU5nGqpwDRY=
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr23110603otb.21.1550740396630;
 Thu, 21 Feb 2019 01:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20190214095015.16032-1-omosnace@redhat.com> <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com> <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com> <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
 <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com> <CAFqZXNtJFrtAqnu=CmoSPnPM312DKF73ALkLeekMk8Me5ojntw@mail.gmail.com>
 <0942b8c9-79a3-47a9-a28d-276d322fd9e1@schaufler-ca.com>
In-Reply-To: <0942b8c9-79a3-47a9-a28d-276d322fd9e1@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Feb 2019 10:13:05 +0100
Message-ID: <CAFqZXNvWyBQ5g6nwD4AiePxEDXGP2DY31S0RWttqcRSa90SakA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tejun Heo <tj@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 19, 2019 at 5:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/19/2019 6:10 AM, Ondrej Mosnacek wrote:
> > On Tue, Feb 19, 2019 at 1:28 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/18/2019 2:03 AM, Ondrej Mosnacek wrote:
> >>> On Fri, Feb 15, 2019 at 4:50 PM Tejun Heo <tj@kernel.org> wrote:
> >>>> On Fri, Feb 15, 2019 at 04:45:44PM +0100, Ondrej Mosnacek wrote:
> >>>>> On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
> >>>>>> On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> >>>>>>> +static int kernfs_node_init_security(struct kernfs_node *parent,
> >>>>>>> +                                  struct kernfs_node *kn)
> >>>>>> Can we skip the whole thing if security is not enabled?
> >>>>> Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
> >>>>> is easy to do and I can add it in the next respin (although the
> >>>>> compiler should be able to optimize most of it out in that case).
> >>>> So the goal is allowing folks who don't use this to not pay.  It'd be
> >>>> better the evaulation can be as late as possible but obviously there's
> >>>> a point where that'd be too complicated.  Maybe "ever enabled in this
> >>>> boot" is a good and simple enough at the same time?
> >>> I don't think there is a way currently to check whether some LSM has
> >>> been enabled at boot or not. I suppose we could add such function for
> >>> this kind of heuristics, but I'm not sure how it would interplay with
> >>> the plans to allow multiple LSM to be enabled simultaneously...
> >>> Perhaps it would be better/easier to just add a
> >>> security_kernfs_needs_init() function, which would simply check if the
> >>> list of registered kernfs_init_security hooks is empty.
> >>>
> >>> I propose something like the patch below (the whitespace is mangled -
> >>> intended just for visual review). I plan to fold it into the next
> >>> respin if there are no objections to this approach.
> >>>
> >>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> >>> index 735a6d382d9d..5b99205da919 100644
> >>> --- a/fs/kernfs/dir.c
> >>> +++ b/fs/kernfs/dir.c
> >>> @@ -625,6 +625,9 @@ static int kernfs_node_init_security(struct
> >>> kernfs_node *parent,
> >>>           struct qstr q;
> >>>           int ret;
> >>>
> >>> +       if (!security_kernfs_needs_init() || !parent)
> >>> +               return 0;
> >>> +
> >>>           if (!parent->iattr) {
> >>>                   kernfs_iattr_init(&iattr_parent, parent);
> >>>                   simple_xattrs_init(&xattr_parent);
> >>> @@ -720,11 +723,9 @@ static struct kernfs_node
> >>> *__kernfs_new_node(struct kernfs_root *root,
> >>>                           goto err_out3;
> >>>           }
> >>>
> >>> -       if (parent) {
> >>> -               ret = kernfs_node_init_security(parent, kn);
> >>> -               if (ret)
> >>> -                       goto err_out3;
> >>> -       }
> >>> +       ret = kernfs_node_init_security(parent, kn);
> >>> +       if (ret)
> >>> +               goto err_out3;
> >>>
> >>>           return kn;
> >>>
> >>> diff --git a/include/linux/security.h b/include/linux/security.h
> >>> index 581944d1e61e..49a083dbc464 100644
> >>> --- a/include/linux/security.h
> >>> +++ b/include/linux/security.h
> >>> @@ -292,6 +292,7 @@ int security_inode_listsecurity(struct inode
> >>> *inode, char *buffer, size_t buffer
> >>>    void security_inode_getsecid(struct inode *inode, u32 *secid);
> >>>    int security_inode_copy_up(struct dentry *src, struct cred **new);
> >>>    int security_inode_copy_up_xattr(const char *name);
> >>> +int security_kernfs_needs_init(void);
> >>>    int security_kernfs_init_security(const struct qstr *qstr,
> >>>                                     const struct iattr *dir_iattr,
> >>>                                     struct simple_xattrs *dir_secattr,
> >>> @@ -789,6 +790,11 @@ static inline int security_inode_copy_up(struct
> >>> dentry *src, struct cred **new)
> >>>           return 0;
> >>>    }
> >>>
> >>> +static inline int security_kernfs_needs_init(void)
> >>> +{
> >>> +       return 0;
> >>> +}
> >>> +
> >>>    static inline int security_kernfs_init_security(
> >>>                   const struct qstr *qstr, const struct iattr *dir_iattr,
> >>>                   struct simple_xattrs *dir_secattr, const struct iattr *iattr,
> >>> diff --git a/security/security.c b/security/security.c
> >>> index 836e0822874a..3c8b9b5baabc 100644
> >>> --- a/security/security.c
> >>> +++ b/security/security.c
> >>> @@ -892,6 +892,11 @@ int security_inode_copy_up_xattr(const char *name)
> >>>    }
> >>>    EXPORT_SYMBOL(security_inode_copy_up_xattr);
> >>>
> >>> +int security_kernfs_needs_init(void)
> >>> +{
> >>> +       return !hlist_empty(&security_hook_heads.kernfs_init_security);
> >>> +}
> >>> +
> >> Yuck. That's an awful lot of infrastructure just to track
> >> that state. May I suggest that instead you have the
> >> security_kernfs_init_security() hook return -EOPNOTSUPP
> >> in the no-LSM case (2nd argument to call_in_hook). You could
> >> then have a state flag in kernfs that you can set to indicate
> >> you don't need to call security_kernfs_init_security() again.
> > Well, maintaining a global variable sounds even more yucky to me...
>
> The state you're maintaining is kernfs state, not LSM
> infrastructure state. The state should be maintained in
> kernfs, not in the LSM infrastructure.

But I'm not maintaining any state. I'm merely trying to answer the
query "Is there anything that will handle this hook? Do I need to
prepare stuff for it?", which is obviously a query about the LSM
state. Granted, ideally we wouldn't need to do any preparatory work at
all, but that would require exposing more of the kernfs internals
(which brings its own issues, but maybe I'll need to look into that
approach more...).

>
> > And I don't understand why you'd consider a simple one-line function
> > to be "an awful lot of infrastructure" :)
>
> That is because you haven't been working with the LSM
> infrastructure very long. If you'll recall, I have already
> objected to kernfs specific LSM hooks. Now, when you find
> that your approach for using a hook has issues, you want
> to add another function that does nothing but tell you
> that there's nothing to do. You can get that by calling
> the security_kernfs_init_security() hook. The LSM infrastructure
> is set up to be as painless as possible when you don't
> want to use it.
>
> >   But at the end of the day it
> > is up to the maintainers - Greg/Tejun and James/Serge (who I forgot to
> > Cc on these patches, sorry)
>
> Yes, James and Serge are the maintainers for the
> security sub-system, but I have done the transition
> from hook vector to hook lists and am currently doing
> the transition from module to infrastructure blob management.
> I know it better, and have more invested in it, than anyone
> else just now.

Fair enough.

>
> >   - what works better for them.
>
> Kernfs is an important component of the kernel. So is
> the security infrastructure. I would hope you don't want
> to turn this into a contest to see which maintainer has
> the biggest clout.

Oh, no, you misunderstood my intention. I just got a feeling that this
thread was turning into a discussion about perceived code ugliness
(and about which subsystem that ugliness ends up in), which is
naturally a very subjective topic, so I wanted to know what is the
opinion of the people that have the final decision about whether the
code should get in or not. Anyway, I'll try to find a more elegant
variant of the solution once again, hopefully I manage to get to
something less controversial.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
