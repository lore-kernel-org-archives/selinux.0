Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A19C04EB8
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D3F2146D
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 15:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D3F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeK2Cof (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:44:35 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:45345 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2Coe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 21:44:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gS1yt-0003lu-Ds; Wed, 28 Nov 2018 08:42:27 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gS1xb-0002el-U5; Wed, 28 Nov 2018 08:42:27 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Paul Moore <paul@paul-moore.com>
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        trond.myklebust@primarydata.com, seth.forshee@canonical.com,
        linux-fsdevel@vger.kernel.org,
        <linux-security-module@vger.kernel.org>
References: <20181116131202.26513-1-omosnace@redhat.com>
        <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
        <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com>
        <CAFqZXNvSdKYr998v3hEhZu4pRwuQs8Q7qRWPhOAtLAc9__Bs6w@mail.gmail.com>
        <CAHC9VhTvuPvnkfgQhT4+AM3iEz4_p85QgShM_oXmpVtLKuq10Q@mail.gmail.com>
Date:   Wed, 28 Nov 2018 09:40:56 -0600
In-Reply-To: <CAHC9VhTvuPvnkfgQhT4+AM3iEz4_p85QgShM_oXmpVtLKuq10Q@mail.gmail.com>
        (Paul Moore's message of "Mon, 26 Nov 2018 18:25:30 -0500")
Message-ID: <87r2f5fbw7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gS1xb-0002el-U5;;;mid=<87r2f5fbw7.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19u0AHwr6AtWU9IeRWydkHOSSekSKb3kcQ=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] selinux: always allow mounting submounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Nov 21, 2018 at 10:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> On Wed, Nov 21, 2018 at 1:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> > On Tue, Nov 20, 2018 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
>> > > On Fri, Nov 16, 2018 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> > > > If a superblock has the MS_SUBMOUNT flag set, we should always allow
>> > > > mounting it. These mounts are done automatically by the kernel either as
>> > > > part of mounting some parent mount (e.g. debugfs always mounts tracefs
>> > > > under "tracing" for compatibility) or they are mounted automatically as
>> > > > needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
>> > > > automounts are either an implicit consequence of the parent mount (which
>> > > > is already checked) or they can happen during regular accesses (where it
>> > > > doesn't make sense to check against the current task's context), the
>> > > > mount permission check should be skipped for them.
>> > > >
>> > > > Without this patch, attempts to access contents of an automounted
>> > > > directory can cause unexpected SELinux denials.
>> > > >
>> > > > In the current kernel tree, the MS_SUBMOUNT flag is set only via
>> > > > vfs_submount(), which is called only from the following places:
>> > > >  - AFS, when automounting special "symlinks" referencing other cells
>> > > >  - CIFS, when automounting "referrals"
>> > > >  - NFS, when automounting subtrees
>> > > >  - debugfs, when automounting tracefs
>> > > >
>> > > > In all cases the submounts are meant to be transparent to the user and
>> > > > it makes sense that if mounting the master is allowed, then so should be
>> > > > the automounts. Note that CAP_SYS_ADMIN capability checking is already
>> > > > skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
>> > > >  - sget_userns() in fs/super.c:
>> > > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
>> > > >             !(type->fs_flags & FS_USERNS_MOUNT) &&
>> > > >             !capable(CAP_SYS_ADMIN))
>> > > >                 return ERR_PTR(-EPERM);
>> > > >  - sget() in fs/super.c:
>> > > >         /* Ensure the requestor has permissions over the target filesystem */
>> > > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
>> > > >                 return ERR_PTR(-EPERM);
>> > > >
>> > > > Verified internally on patched RHEL 7.6 with a reproducer using
>> > > > NFS+httpd and selinux-tesuite.
>> > >
>> > > I think this all sounds reasonable, but please verify this with an
>> > > upstream kernel.  Upstream our focus is on the upstream kernel
>> > > (surprise!), downstream RHEL is your responsibility, not ours :)
>> >
>> > I tested on RHEL because that's what I can do most conveniently. I
>> > don't have a very good workflow/environment for complex testing on
>> > upstream right now. I don't expect the results to be any different on
>> > the upstream kernel, but I understand your concern. I have been
>> > thinking about some patch testing automation using Fedora Rawhide (I
>> > hope that's close enough to upstream at least :), so I guess it's time
>> > to get scriptin'...
>>
>> I have now tested it on Fedora Rawhide with a scratch kernel with this
>> patch applied [1] (x86_64 only). I ran the whole selinux-testsuite
>> with the submount test [2] and everything passed (except for the known
>> overlay failures and skipped binder test) ...
>
> Merged into selinux/next, thanks.


A few late comments on this.

The change mentioned in fixes did not remove a SB_KERNMOUNT so I don't
see how it is a fix for that.  That change just added SB_SUBMOUNT so you
can test for and detect this situation.  Are you seeing something that I
am not in that change?

I expect what we need for the long term is to move sb_kern_mount except
for the security mount option bits into do_new_mount so security modules
don't have to perform funny checks because the security hook is in the
wrong place.

Further as far as I can tell from reading the code every filesystem that
performs submounts except for nfs is broken.  As no one else calls
security_sb_clone_mnt_opts.  Instead the normal mnt_opts hooks are
called with no security mount options.

Which leads me to point that smack doesn't even implement
sb_clone_mnt_opts so I expect smack gets the security mount options
wrong.

Is it common to specify the security mount options on filesystems?
I see the code.  I see what needs to be done to keep them working.
(Commas in options names ick).  I don't understand how they are used and
how common they are.

I care because the vfs is in the middle of some work to clean up this
side of mounting and at the very least I am review changes and spotting
bugs.  Understanding how the security mount options work from the
perspective of someone who actually uses them would be a real help.

Eric
