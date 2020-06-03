Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A619DC433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5DB2067B
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 21:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMixMAF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCVCG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVCG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 17:02:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB013C08C5C0;
        Wed,  3 Jun 2020 14:02:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so1449957pfw.10;
        Wed, 03 Jun 2020 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnxEgjK/PV4ZnaRKFpZ2bvcIOP6HQdu5sBUnSuJLZDU=;
        b=lMixMAF1BMXbMxEb6gFCBo51lmH8HevCoVx2GfvU6kiCICdZH8d/Iuy0c3MkTwshaR
         vFCmSWWkk3s0gboPZdywPfve/MCvvTJ6ofkmx7mOB6krwh4wQdBb9cXW3nkXzp99lDIC
         32zTbPDnd6wz2H0g7ReMz0l1/QLguXq55pUrup4if10ed5+yIYt6wLMHOOYqONlp3aLm
         UwYz0iDOIziF8dDc5bz+W5Hcpl1OrTTkon3p98x2fUkp6xXEAhw1oHuUWmhDR9O0yUtK
         F2KgfAUTDgSUBbE57eMg0y8yvCp8VFJnqo2f+xTKQ5Zj1W6JSMZurCLGAOWFixBkbdY2
         gvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnxEgjK/PV4ZnaRKFpZ2bvcIOP6HQdu5sBUnSuJLZDU=;
        b=CmpxuWB3dCfh2UUyQFzEyLLVGyirubBOk9IR0yJ7HqgPkS9RQoshb+phxWf9l+43Fe
         AzVBpCz9zIXvo2G6C7MQg3ENAxS0TJr/EUhcA31iBTz9wt7vX4ZRUhnJExSeSokH5n55
         HYVq7tlNHpGHl5juLP0oqAQjb91d2fC5PWsR4CH6NT4Z5OqBsRgtuDhPDC3m+wUVkgHx
         LqP1HpaTvTRE1kGjdy2yyVNzYBL2wZDfUJroT4+Lo/P0QMPk1qM4aUUiMLQa/wJU90mT
         UCOj2bmVpbagwotLVISbcOGETcQcmeSCzMLj51aIAXfGS6ZDZOPj0RyGRqfrnWFL7lsu
         X5hQ==
X-Gm-Message-State: AOAM533IMBW6tV0tiGDc1i25xxphEb4l+HSv9SNSnTumyM6kqylgOV+y
        RCfGLNobO3L/OUoGtxqPlpc=
X-Google-Smtp-Source: ABdhPJxVqX2biTfT3atykh+rQZ1RpXedEdssXzXNV7Qg1BS0eki5GTQ+2L62sn9xQIqQ0zRi69FEIg==
X-Received: by 2002:a63:305:: with SMTP id 5mr1196732pgd.74.1591218125200;
        Wed, 03 Jun 2020 14:02:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:514a])
        by smtp.gmail.com with ESMTPSA id v3sm3582017pja.8.2020.06.03.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 14:02:04 -0700 (PDT)
Date:   Wed, 3 Jun 2020 14:02:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SELinux patches for v5.8
Message-ID: <20200603210202.thwuv2ye672ifwim@ast-mbp.dhcp.thefacebook.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
 <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 03, 2020 at 10:37:47AM -0700, Linus Torvalds wrote:
> On Wed, Jun 3, 2020 at 10:20 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > We could have inode->i_security be the blob, rather than a pointer to it.
> > That will have its own performance issues.
> 
> It wouldn't actually really fix anything, because the inode is so big
> and sparsely accessed that it doesn't even really help the cache
> density issue. Yeah, it gets rid of the pointer access, but that's
> pretty much it. The fact that we randomize the order means that we
> can't even really try to aim for any cache density.
> 
> And it would actually not be possible with the current layered
> security model anyway, since those blob sizes are dynamic at runtime.
> 
> If we had _only_ SELinux, we could perhaps have hidden the
> sid/sclass/task_sid directly in the inode (it would be only slightly
> larger than the pointer is, anyway), but even that ship sailed long
> long ago due to the whole "no security person can ever agree with
> another one on fundamentals".

Also there is bpf_lsm now that we're going to run it in production, 
so performance is as important as ever.
Traditional lsm-s have per-lsm per-inode blob.
For bpf that doesn't work, since progs come and go at run-time and
independent from each other.
So we need per-program per-inode blob.
To maintain good performance we've proposed:
@@ -740,6 +741,10 @@  struct inode {
 	struct fsverity_info	*i_verity_info;
 #endif
 
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_local_storage __rcu	*inode_bpf_storage;
+#endif

https://patchwork.ozlabs.org/project/netdev/patch/20200526163336.63653-3-kpsingh@chromium.org/

but got pushback, so we're going to use lsm style for now:
+static inline struct bpf_lsm_storage *bpf_inode(const struct inode *inode)
+{
+       if (unlikely(!inode->i_security))
+               return NULL;
+
+       return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
+}

which means extra kmalloc for every inode, extra pointer deref, global var
access, and additional math just to get to 'inode_bpf_storage' pointer.

We have similar pointer in 'struct sock' already:
#ifdef CONFIG_BPF_SYSCALL
        struct bpf_sk_storage __rcu     *sk_bpf_storage;
#endif
that is used by variety of networking bpf programs.
The commit 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
has benchmarking data for it:
  hash table with 8-byte key -> 152ns per bpf run 
  sk_bpf_storage -> 66ns per bpf run
Hashtable suppose to be O(1) with L1$ hit, but it turned out
to be noticeably slower than sk_bpf_storage.
We expect to see similar performance gains for inode_bpf_storage
vs hashtable approach that people use now.
Eventually we'll add task_bpf_storage as well.
Right now every other bpf tracing script is using pid as a key
in a separate hash table to store per-task data. For high frequency
events that adds up. task_bpf_storage will accelerate that.

Another way to look at it is shared inode->i_security across
different inodes won't work for us. We need something really
cheap like single 'inode_bpf_storage' pointer that is zero
most of the time and for few inodes bpf progs will keep their
scratch data in there.
For now lsm style bpf_inode() approach is ok-ish.
But we will come back when we collect perf numbers to justify
why direct pointer in the 'struct inode' is a win.
