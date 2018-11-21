Return-Path: <SRS0=ZtKf=OA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7731CC43441
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6A21479
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 15:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC6A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeKVCNr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:13:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38357 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbeKVCNr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 21:13:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so1008176otl.5
        for <selinux@vger.kernel.org>; Wed, 21 Nov 2018 07:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+801kxTaf/ZJLUgeSXYSduycKGqx6IeEf/rgEvbaX40=;
        b=ViOMfw2OoHmVaAM4d6CP85JRk4Q+gIlO6DS5Jjn9lmW5yNdjUwGwcfQZgY1/hVpNEW
         nzwgKRWuWOTdo0iCWLQqLmzX9opb/LLvdxR9f8uwzLBupBpJ0LorLSl6WxstKF4s+K4R
         TiWA2OpZ1+gAuDFTm36q54EP0b02fQ5qX7MBdtBJOLwcd60Ah2OW7QTXLIthmt4T902m
         n/DwkU84BmHZiLNjkGd9xIm0dSNGXlizqYQ5IrqfEGP94noXN2HiMTwKBy0IkSA1INnZ
         9ePXypVZfAZHdGw/9ArrnHzd2nyjwb/Yrym+2C0N2MFmmXj5n1dqiwMnBeWIa958HtHb
         9X2g==
X-Gm-Message-State: AA+aEWbya1SJ3693fCAa1Tw7LZafrnh5+42+QTSAUWgFzfenZ4znP7xA
        Fml0RFFqpTJHqinUz1aP8QVI04g71tjtS9rc0p2NcCdL
X-Google-Smtp-Source: AFSGD/WcP4mIZ4raIj3ml6cbMnwcMKQUsiuF0Osah0g0bG07HXstt2SD8svDcgPae/tjHVnew0W0qWRdOyC/y/8XsP0=
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr4371041otl.319.1542814730289;
 Wed, 21 Nov 2018 07:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20181116131202.26513-1-omosnace@redhat.com> <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
 <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com>
In-Reply-To: <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 21 Nov 2018 16:38:38 +0100
Message-ID: <CAFqZXNvSdKYr998v3hEhZu4pRwuQs8Q7qRWPhOAtLAc9__Bs6w@mail.gmail.com>
Subject: Re: [PATCH] selinux: always allow mounting submounts
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 21, 2018 at 1:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Nov 20, 2018 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Nov 16, 2018 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > If a superblock has the MS_SUBMOUNT flag set, we should always allow
> > > mounting it. These mounts are done automatically by the kernel either as
> > > part of mounting some parent mount (e.g. debugfs always mounts tracefs
> > > under "tracing" for compatibility) or they are mounted automatically as
> > > needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
> > > automounts are either an implicit consequence of the parent mount (which
> > > is already checked) or they can happen during regular accesses (where it
> > > doesn't make sense to check against the current task's context), the
> > > mount permission check should be skipped for them.
> > >
> > > Without this patch, attempts to access contents of an automounted
> > > directory can cause unexpected SELinux denials.
> > >
> > > In the current kernel tree, the MS_SUBMOUNT flag is set only via
> > > vfs_submount(), which is called only from the following places:
> > >  - AFS, when automounting special "symlinks" referencing other cells
> > >  - CIFS, when automounting "referrals"
> > >  - NFS, when automounting subtrees
> > >  - debugfs, when automounting tracefs
> > >
> > > In all cases the submounts are meant to be transparent to the user and
> > > it makes sense that if mounting the master is allowed, then so should be
> > > the automounts. Note that CAP_SYS_ADMIN capability checking is already
> > > skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
> > >  - sget_userns() in fs/super.c:
> > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
> > >             !(type->fs_flags & FS_USERNS_MOUNT) &&
> > >             !capable(CAP_SYS_ADMIN))
> > >                 return ERR_PTR(-EPERM);
> > >  - sget() in fs/super.c:
> > >         /* Ensure the requestor has permissions over the target filesystem */
> > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
> > >                 return ERR_PTR(-EPERM);
> > >
> > > Verified internally on patched RHEL 7.6 with a reproducer using
> > > NFS+httpd and selinux-tesuite.
> >
> > I think this all sounds reasonable, but please verify this with an
> > upstream kernel.  Upstream our focus is on the upstream kernel
> > (surprise!), downstream RHEL is your responsibility, not ours :)
>
> I tested on RHEL because that's what I can do most conveniently. I
> don't have a very good workflow/environment for complex testing on
> upstream right now. I don't expect the results to be any different on
> the upstream kernel, but I understand your concern. I have been
> thinking about some patch testing automation using Fedora Rawhide (I
> hope that's close enough to upstream at least :), so I guess it's time
> to get scriptin'...

I have now tested it on Fedora Rawhide with a scratch kernel with this
patch applied [1] (x86_64 only). I ran the whole selinux-testsuite
with the submount test [2] and everything passed (except for the known
overlay failures and skipped binder test):

domain_trans/test ........... ok
entrypoint/test ............. ok
execshare/test .............. ok
exectrace/test .............. ok
execute_no_trans/test ....... ok
fdreceive/test .............. ok
inherit/test ................ ok
link/test ................... ok
mkdir/test .................. ok
msg/test .................... ok
open/test ................... ok
ptrace/test ................. ok
readlink/test ............... ok
relabel/test ................ ok
rename/test ................. ok
rxdir/test .................. ok
sem/test .................... ok
setattr/test ................ ok
setnice/test ................ ok
shm/test .................... ok
sigkill/test ................ ok
stat/test ................... ok
sysctl/test ................. ok
task_create/test ............ ok
task_setnice/test ........... ok
task_setscheduler/test ...... ok
task_getscheduler/test ...... ok
task_getsid/test ............ ok
task_getpgid/test ........... ok
task_setpgid/test ........... ok
file/test ................... ok
ioctl/test .................. ok
capable_file/test ........... ok
capable_net/test ............ ok
capable_sys/test ............ ok
dyntrans/test ............... ok
dyntrace/test ............... ok
bounds/test ................. ok
nnp_nosuid/test ............. ok
mmap/test ................... ok
unix_socket/test ............ ok
inet_socket/test ............ ok
overlay/test ................ 62/119
#   Failed test at overlay/test line 275.

#   Failed test at overlay/test line 293.
overlay/test ................ 97/119
#   Failed test at overlay/test line 547.

#   Failed test at overlay/test line 622.
# Looks like you failed 4 tests of 119.
overlay/test ................ Dubious, test returned 4 (wstat 1024, 0x400)
Failed 4/119 subtests
checkreqprot/test ........... ok
mqueue/test ................. ok
mac_admin/test .............. ok
atsecure/test ............... ok
submount/test ............... ok
cap_userns/test ............. ok
extended_socket_class/test .. ok
sctp/test ................... ok
netlink_socket/test ......... ok
prlimit/test ................ ok
binder/test ................. skipped: Binder not supported by kernel

Test Summary Report
-------------------
overlay/test              (Wstat: 1024 Tests: 119 Failed: 4)
 Failed tests:  81, 83, 107, 112
 Non-zero exit status: 4
Files=54, Tests=615, 133 wallclock secs ( 0.45 usr  0.28 sys +  3.37
cusr 11.14 csys = 15.24 CPU)
Result: FAIL
Failed 1/54 test programs. 4/615 subtests failed.

[1] https://koji.fedoraproject.org/koji/taskinfo?taskID=31037298
[2] https://github.com/SELinuxProject/selinux-testsuite/pull/43

>
> I was hoping to get some independent testing after porting the test to
> the selinux-testsuite... (But I get it, the burden of proof is on my
> side...)
>
> >
> > > Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/hooks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 7ce683259357..7ce012d9ec51 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2934,7 +2934,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
> > >                 return rc;
> > >
> > >         /* Allow all mounts performed by the kernel */
> > > -       if (flags & MS_KERNMOUNT)
> > > +       if (flags & (MS_KERNMOUNT | MS_SUBMOUNT))
> > >                 return 0;
> > >
> > >         ad.type = LSM_AUDIT_DATA_DENTRY;
> >
> > --
> > paul moore
> > www.paul-moore.com
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
