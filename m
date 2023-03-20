Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC2C7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 13:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjCTN62 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCTN6N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 09:58:13 -0400
X-Greylist: delayed 23624 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 06:57:47 PDT
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030099EDD
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679320665;
        bh=k0cs3NobB1qikALYR0Xj2DibOWlj77gDVoD1OxKm3C0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=H+s9lcDFt1fiCotJA4AAiuGMUnc2yX0sX9MtjefFwoh7UVTJF+g3cyG1Yl7tO7t7N
         Z/i0t9wI4YvdQVFgGu8Yq1BKlg0BWCN+9oFSoNRWiPak/OH2MvOjiP+c1erjZyIxOT
         7rJlBpHgxKQdrR2CT3aNMu+XSnw60cRMkylRzKfM=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id 16A913CC;
        Mon, 20 Mar 2023 14:57:45 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: cgroup2 labeling question
References: <87mt47ga29.fsf@defensec.nl>
        <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
Date:   Mon, 20 Mar 2023 14:57:44 +0100
In-Reply-To: <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
        (Stephen Smalley's message of "Mon, 20 Mar 2023 09:35:14 -0400")
Message-ID: <871qljfrtz.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>> Hi,
>>
>> I was reading this pull request [1] and looked into how I might be able
>> to implement this in policy but there seem to be some technical
>> difficulties.
>>
>> * I already use getfscon to seperate the systemd user.slice because the
>>   system manager delegates the user.slice to the user manager.
>>
>>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
>>
>>   In the past the proved to be a racy where systemd attempts to
>>   write before the object has the context associated with the genfscon.
>
> I don't understand how this could be racy - genfscon-assigned contexts
> should be assigned when the dentry is first instantiated via
> inode_donit_with_dentry and therefore the inode shouldn't be
> accessible to userspace prior to this initial assignment AFAIK.
> Possibly I am missing something.

I recall encountering this sporadically, but I admit that it has been a
while since I supressed it in policy. I might try to reproduce. AFAIK my
policy is the only policy that actually labels some trees on cgroup2 fs
with private types currently.

>
>>   I decided to dontaudit attempts to write to the mislabeled object and
>>   it *seems* as if systemd retries until it can write it i.e. when the
>>   object carries the expected label and so that seems to work eventually
>>   but it looks fragile.
>>
>> * The challenge with memory pressure implementation [2] is that these
>>   "memory.pressure" files end up in random locations under
>>   "/system.slice" for example:
>>
>>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
>>
>>   Where in the above systemd-journald.service might be
>>   templated (systemd-journald@FOO.service). Point is that the path is
>>   random. genfscon does not support regex and glob. I can't do for examp=
le:
>>
>>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
>>   cgroupfile_context)
>>
>>   Fortunately cgroup2fs supports relabeling but if systemd has to
>>   manually relabel the cgroup files then I would imagine that this is
>>   racy as well, and that does not really solve the underlying issue.
>>
>>   I am looking for ideas and suggestions
>
> Optimally one of two things would happen:
> 1. The kernel would label the inode correctly when it is first created
> (e.g. by augmenting genfscon to support more general matching), or
> 2. The userspace component that creates these files would label them
> correctly at creation (via setfscreatecon() prior to creation).

Agree but 1. would require regex/glob support for genfscon and 2. these
files aren't "created" by userspace AFAIK and so setfscreatecon or
automatic object type transitions are probably not an option here.

>
> Pardon my ignorance but what creates these files initially? The kernel
> in response to some event or systemd or some other userspace
> component?

Yes AFAIK it is the former (psuedo filesystem similar to procfs, debugfs
in that sense). This is also why I don't think that the PR mentioned is
tested because cgroup2 fs labeling is done with genfscon and not fsuse
trans or fsuse xattr so even if the files would be created by
userspace (which I think is not the case) the specified automatic object
type transition rule wouldnt work.

I think eventually we currently probably have little choice but to make sys=
temd
reset the context of said cgroup file manually. Just wanted to see if
there are alternatives.

>
>> [1] https://github.com/SELinuxProject/refpolicy/pull/607
>> [2] https://github.com/systemd/systemd/blob/main/docs/MEMORY_PRESSURE.md

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
