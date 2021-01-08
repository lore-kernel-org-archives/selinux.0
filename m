Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CCC433E0
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F6823AC1
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 20:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbhAHUSN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbhAHUSH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 15:18:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96312C0612FD
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 12:17:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id d17so16126443ejy.9
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwrOgDTg96KrzDvgtinwO514AtzHfwPfpJcfahxEYVI=;
        b=aGlRquYV7bBoqWOfhg/mBYEuzggSozf1JOKAipPHB6CHoFm9cW3lprBEnleXHV82pE
         r5stn0vhAinJiv33KPHJ5w2fLw5Icm3NYqX8LQ0wAt21tWNTl6vudMYutWVrDrufXsKL
         5FFs6hddoUdt10NDUrvs+56xFAfqToaAXTQent1IQQntDeUhmZ/QkLQcxbY/QmNj0Dca
         4weEE7eCLoFXkAgKjbAxDWd7Haie/lzKOV1kXZl5EnV7TrZ3SpiwDi9RMToSkT0It6C6
         HcFCJqGsfukio8J9XbsSYIhGB9QtbX2JDlLjWpn94zM1pIQkBdL0pEHk7skG8iTc9zyH
         kVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwrOgDTg96KrzDvgtinwO514AtzHfwPfpJcfahxEYVI=;
        b=glhba8pfK5fEXXTd1tZJdrNXOQGa8uHYo3B8Gy6ao5AIZWEd9loJE++5cIbGIQJRIU
         pYufS8hGmf4ttq/czdBXFMmFMjEV+zEPzYI86FJlK1WX17+2sdiEZGp8FB/MpS7bU+V+
         xty2572SBOmc2f1w3eWIX8b/Ly+I1qpS/LeG2WmwWnCzyh1MVrwqJI9UGfDzE1tIL3Y+
         HpzInDLl5vR4HIjyJpZyjL3/ldLWfnOTm+0xXXfwdZ36KWXi0V6zVyDAZfRHsmyqXcHP
         tyhEoLPyVC2Y5WkDx3vOTFJYEdMpwmQhf1F0mXONmftsVo8kmhjT6ylCmVmzaIvYwEIT
         J51g==
X-Gm-Message-State: AOAM530icsv3ouNtCD4mHFCECiF3rv9wCyu7dNMC6zNRPjMlL2+eO5ff
        gvz+q9F/DijZLDBSSZJmY7q+AvEuKD2QmqUU5otOtA==
X-Google-Smtp-Source: ABdhPJye2R3aseIB1YZzP7HfOO+3uXuVcvm7i9jO6SKjJISprsBWoeK3t3aCDNf/qzYvphit8xROqcEb2lZxYjcwLC4=
X-Received: by 2002:a17:907:101c:: with SMTP id ox28mr3462266ejb.201.1610137044856;
 Fri, 08 Jan 2021 12:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
In-Reply-To: <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 8 Jan 2021 12:17:13 -0800
Message-ID: <CA+EESO45ezOtg1-MHfwSk3YNYRS7cYnH+kMz-T_MdaSpyW=8Yw@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 8, 2021 at 11:35 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > From: Daniel Colascione <dancol@google.com>
> > >
> > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > the previous patches to give SELinux the ability to control
> > > anonymous-inode files that are created using the new
> > > anon_inode_getfd_secure() function.
> > >
> > > A SELinux policy author detects and controls these anonymous inodes by
> > > adding a name-based type_transition rule that assigns a new security
> > > type to anonymous-inode files created in some domain. The name used
> > > for the name-based transition is the name associated with the
> > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > "[perf_event]".
> > >
> > > Example:
> > >
> > > type uffd_t;
> > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > allow sysadm_t uffd_t:anon_inode { create };
> > >
> > > (The next patch in this series is necessary for making userfaultfd
> > > support this new interface.  The example above is just
> > > for exposition.)
> > >
> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> > >  security/selinux/include/classmap.h |  2 ++
> > >  2 files changed, 58 insertions(+)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 6b1826fc3658..d092aa512868 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > >         return 0;
> > >  }
> > >
> > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > +                                           const struct qstr *name,
> > > +                                           const struct inode *context_inode)
> > > +{
> > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > +       struct common_audit_data ad;
> > > +       struct inode_security_struct *isec;
> > > +       int rc;
> > > +
> > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > +               return 0;
> > > +
> > > +       isec = selinux_inode(inode);
> > > +
> > > +       /*
> > > +        * We only get here once per ephemeral inode.  The inode has
> > > +        * been initialized via inode_alloc_security but is otherwise
> > > +        * untouched.
> > > +        */
> > > +
> > > +       if (context_inode) {
> > > +               struct inode_security_struct *context_isec =
> > > +                       selinux_inode(context_inode);
> > > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > > +                       return -EACCES;
Stephen, as per your explanation below, is this check also
problematic? I mean is it possible that /dev/kvm context_inode may not
have its label initialized? If so, then v12 of the patch series can be
used as is. Otherwise, I will send the next version which rollbacks
v14 and v13, except for this check. Kindly confirm.

> > > +
> > > +               isec->sclass = context_isec->sclass;
> >
> > Taking the object class directly from the context_inode is
> > interesting, and I suspect problematic.  In the case below where no
> > context_inode is supplied the object class is set to
> > SECCLASS_ANON_INODE, which is correct, but when a context_inode is
> > supplied there is no guarantee that the object class will be set to
> > SECCLASS_ANON_INODE.  This could both pose a problem for policy
> > writers (how do you distinguish the anon inode from other normal file
> > inodes in this case?) as well as an outright fault later in this
> > function when we try to check the ANON_INODE__CREATE on an object
> > other than a SECCLASS_ANON_INODE object.
> >
> > It works in the userfaultfd case because the context_inode is
> > originally created with this function so the object class is correctly
> > set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
> > case?  Do we ever need or want to support using a context_inode that
> > is not SECCLASS_ANON_INODE?
>
> Sorry, I haven't been following this.  IIRC, the original reason for
> passing a context_inode was to support the /dev/kvm or similar use
> cases where the driver is creating anonymous inodes to represent
> specific objects/interfaces derived from the device node and we want
> to be able to control subsequent ioctl operations on those anonymous
> inodes in the same manner as for the device node.  For example, ioctl
> operations on /dev/kvm can end up returning file descriptors for
> anonymous inodes representing a specific VM or VCPU or similar.  If we
> propagate the security class and SID from the /dev/kvm inode (the
> context inode) to the new anonymous inode, we can write a single
> policy rule over all ioctl operations related to /dev/kvm.  That's
> also why we used the FILE__CREATE permission here originally; that was
> also intentional.  All the file-related classes including anon_inode
> inherit a common set of file permissions including create and thus we
> often use the FILE__<permission> in common code when checking
> permission against any potentially derived class.

Thanks a lot for the explanation.
