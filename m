Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D210BC43444
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A218B2087E
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfANJBq convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:01:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43089 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANJBq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jan 2019 04:01:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so17247178oie.10
        for <selinux@vger.kernel.org>; Mon, 14 Jan 2019 01:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=niLVcrU++r4b+oA6o5XTM+1uHJLXTA/wwgUHPBKB4ew=;
        b=HNm0bXaUa8WP5sa00IFSegdNHyFnzlxHRbSDAa1bOuh0NQJ9yBqdkPWcUfIChqO4Of
         lOuEnGWm8dYUH3w37A27Oas2XiYqFzpEQAmo29rZEnf1YQKDWUAHBlzSDYnTYuffYezj
         FzEdg8k+xv+WI7iEL/r/C0EAhDAa4jkUNswbzyQAlItXEStegVkXHRFUqxJ85/wJzXtU
         kM7uxPtrD7l4hEMCRq+oXs+bnWLhOw3ZF7On56IOJ6k9GtPIDpqFYaixzj6ajXGBXJof
         LBinErUmEShfua0izGtCsXt+L92/PJ/O9N5RsIMNQJVjhpRyNhkPdhIGFWS9CnS6ZDeE
         Rkrg==
X-Gm-Message-State: AJcUukddd5bBnThbgryJu3dRSkgxXoxf0OFllXMBzpR6/reaoCVewgb8
        gr2x4MGCTFhUNdjNPCKAMGSACsBRjGzO8tATblg4Nw==
X-Google-Smtp-Source: ALg8bN4o/+E82LRLAQVgsp9/ZEHiYAIF8Qi1kRUj6fc3TUuDqd8woIpdiMwuGXeQRjdJ1KrB1UL8OyLhfCa36r50Ylo=
X-Received: by 2002:aca:293:: with SMTP id 141mr15869155oic.28.1547456505265;
 Mon, 14 Jan 2019 01:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov> <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov> <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
In-Reply-To: <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 14 Jan 2019 10:01:33 +0100
Message-ID: <CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 10, 2019 at 6:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Resending after email configuration repair.
>
> On 1/10/2019 6:15 AM, Stephen Smalley wrote:
> > On 1/9/19 5:03 PM, Casey Schaufler wrote:
> >> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
> >>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
> >>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> >>>>> Changes in v2:
> >>>>> - add docstring for the new hook in union security_list_options
> >>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
> >>>>>     implemented
> >>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
> >>>>>
> >>>>> This series adds a new security hook that allows to initialize the security
> >>>>> context of kernfs properly, taking into account the parent context. Kernfs
> >>>>> nodes require special handling here, since they are not bound to specific
> >>>>> inodes/superblocks, but instead represent the backing tree structure that
> >>>>> is used to build the VFS tree when the kernfs tree is mounted.
> >>>>>
> >>>>> The kernfs nodes initially do not store any security context and rely on
> >>>>> the LSM to assign some default context to inodes created over them.
> >>>>
> >>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
> >>>> and expected filesystem behavior?
> >>>
> >>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
> >>>
> >>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
> >>
> >> OK, so as I said, this seems like a bug in kernfs.
> >>
> >>>
> >>>>
> >>>>> Kernfs
> >>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
> >>>>> syscalls, in which case the context is stored inside the kernfs node's
> >>>>> metadata.
> >>>>>
> >>>>> SELinux (and possibly other LSMs) initialize the context of newly created
> >>>>> FS objects based on the parent object's context (usually the child inherits
> >>>>> the parent's context, unless the policy dictates otherwise).
> >>>>
> >>>> An LSM might use information about the parent other than the "context".
> >>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
> >>>> to determine whether the Smack label of the new object should be taken
> >>>> from the parent or the process. Passing the "context" of the parent is
> >>>> insufficient for Smack.
> >>>
> >>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.

I actually had a patch to do just that at one point because I thought
for a while that it would be required to call
security_inode_init_security() (which I had tried to somehow force
into the kernfs node creation at some point), but then I realized it
is not actually needed (although would make thing a bit nicer) and put
it away... I will try to dig it out and reuse here.

> >>
> >> Right. But I'll point out that there is nothing to prevent an
> >> LSM from using inode information outside of the xattrs (e.g. uids)
> >> to determine the security state it wants to give a new object.
> >
> > If that's a real concern, the hook could pass the ia_iattr structure in addition to the simple_xattrs list and the security module could use any inode attributes it likes in making the decision.  Effectively it would be passing the entire kernfs_iattrs structure, but probably not directly since that definition is presently private to kernfs.
>
> Yes, it's a real concern. And no, just passing all of the kernfs internal data
> out in j-random formats does not pass muster. Al Viro was commenting the other
> day on how bad the LSM infrastructure interfaces are. The original proposal here
> is already big, cluttered and inadequate. Adding more to it to make up for its
> shortcomings should be sending up red flags.

I understand the concern about cluttering up things, but I just don't
see any nicer solution right now...

>
> I've been wallowing in the LSM infrastructure for the past seven years.
> Interfaces like this one, that propagate the idiosyncrasies of both
> the caller (kernfs) and one potential callee (SELinux) are much too
> common. I understand that there is a problem that needs a solution.
> This isn't it.
>
>
> >> I suggest that the better solution would be for kernfs to
> >> use inodes like a real filesystem. Every special case like this
> >> results in special cases like this special hook. It's hard
> >> enough to keep track of the general case in the Linux kernel.
> >
> > Feel free to propose an implementation if you like, but doing a complete rewrite of kernfs internals seems a bit out of scope.
>
> If this issue points out a serious problem with the kernfs implementation
> then I would expect that addressing the problem at its source would be in
> everyone's best interest. Did anyone even look at the possibility? If I
> said that I would do that, how long would you be willing to wait for it?

Granted, the "inodeless" abstractions in kernfs have perhaps gone too
far, but I believe that trying undo it would just shift the complexity
into kernfs and its users... IMHO that this solution (with the changes
proposed by Stephen) is not overly invasive and does not make the
potential future rework of kernfs and its handling by LSMs much more
difficult than it would be now. I'd prefer to apply an imperfect but
noninvasive solution to a practical problem now and leave extensive
refactoring as a separate task/discussion.

(Anyway, I don't want to rush this. I'll keep sending patches and
hopefully we'll eventually converge to some solution acceptable to
everyone.)

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
