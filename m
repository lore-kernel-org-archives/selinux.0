Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F17C388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A264920882
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 20:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2wQyfqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756087AbgJWU3J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756082AbgJWU3J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 16:29:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC404C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 13:29:08 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k3so1940158otp.1
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MiBNGbCe/ZgntsFF4/93BRUW1ZmO6HENIIcJWEmE3BE=;
        b=l2wQyfqXelNRx6K5PkHY2LtK1FDCe0lno4wKoxXTwl9pRFe+peKPIwPyZS1XnMRvu+
         2cRj5li0YQCD8H3XCkK5C+DJ5xef97xlCRKp7NQtsKxpAnga0IGPtcEIDYht+ySPscLO
         Arsega13alsXhAUZPl0fVFaRY9GArQEI4OAXIU/4iI8O1riT3ad0kcgWUO2Kjo2Xiqvw
         JiVxUL6I/Ji4C8kwtGeHUoarS1pVdsbOhRVitgulpGDOsp4o2TdgiqUvl+sWx3GdXPVN
         gnC1G1ZJSznBLaE1gr+4cL0JjjbDLF6+Ivn5Ftg8ETryT7d2dKVVVyyjtcIcGJwMUSd3
         FwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MiBNGbCe/ZgntsFF4/93BRUW1ZmO6HENIIcJWEmE3BE=;
        b=XanKT4qR6Gzq4LY06G+PQDOcKp1X4M78giFl9I4Q+euAzHtDHw/wzPc+e5a4tE8a57
         cWFG46ya/OvlCxzI/FdxZiFAN12+gPkgZQjylVt2aWpqTFcZp/EgMuexxEsPo5qQXgGp
         E7kjz88WEuoVYawtODSoTV+T6ddb+akHEL+4pa3/CqB4Gwnsoi+CcQuqeTYeBqu4ugr4
         osXeR/o8ssC5hhxCjMV2IdrvYmPQBU/omoGas7iBdO3jjW9lrB2sIdKDK571PmI8vGHX
         2y5tRRvZOXWjw42zp2ab0bxpgM/ClhHeFim/0F5FizKjojtJ32yY9oJ7I81QxfRp4DVK
         IQsQ==
X-Gm-Message-State: AOAM530vTkeIQBq05JzFHtz9sJUDWBqAk6CEq+pvlnvMWNkoKXBShUp+
        WDPsl9HCH92yIncRWVTV7CFGwTDgobZTBFnO6d8=
X-Google-Smtp-Source: ABdhPJwd2ycL6VY3KzxXyd9TADIq4Mpo8JF3WeiWb9yrFqqZHj84wwwNUrmo1v//GbFMIdFBe651DpprncoSQkip9s8=
X-Received: by 2002:a9d:4549:: with SMTP id p9mr3389808oti.196.1603484946096;
 Fri, 23 Oct 2020 13:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <08E7D9BD-ACF8-4DDA-85A7-52F5C89B274F@gmail.com>
 <CAP+JOzTd21176V19FkvVzSyp_qDE3KOH3QbmXpou3YRuJ8drPQ@mail.gmail.com>
 <CA+w97WydYacO9Lx_2T1ix=WB604RRDWUwiC+dSCU8i_BNqxO6w@mail.gmail.com>
 <CAP+JOzQzk3kzsD=ueKQuei6Td+HzVsTftFhufdj7RTF5-j=3gQ@mail.gmail.com>
 <CA+w97WyRs+sg5_mGbcoXnDAfeUp10vt=JZVgqdKq2xiARtkCyw@mail.gmail.com> <CA+w97WwyUS8-0ju7YNPSjtymi8yoWyW8MOVboZFJ5e4MHN9DJw@mail.gmail.com>
In-Reply-To: <CA+w97WwyUS8-0ju7YNPSjtymi8yoWyW8MOVboZFJ5e4MHN9DJw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 23 Oct 2020 16:33:02 -0400
Message-ID: <CAP+JOzSti4Z1PpRN5aJSnZm0KqxWguxTktxQjOQKNE2kVQ0AEw@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     Ian M <merinian@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Adding the SELinux back on as a cc)

A file_contexts file is created when the policy is built using
Refpolicy or CIL. It must be created manually when using checkpolicy
on a policy.conf file. Since you are using restorecon, I would guess
that there is a file_contexts file in
/etc/selinux/targeted/contexts/files/.
Jim



On Fri, Oct 23, 2020 at 4:14 PM Ian M <merinian@gmail.com> wrote:
>
> It answers half my question I think,
>
> The other half being where is the initial label coming from?    As Bill s=
aid the cpio does not support xattr so that field is empty on boot and is p=
opulated sometime after.
>
> If I knew when and why that labeling was happening I think I'd be in a go=
od position to move forward with my work.
>
> Thanks,
>
> Ian
>
> On Fri, Oct 23, 2020 at 4:12 PM Ian M <merinian@gmail.com> wrote:
>>
>>
>>
>> On Fri, Oct 23, 2020 at 4:02 PM James Carter <jwcart2@gmail.com> wrote:
>>>
>>> Does Bill's response on the SELinux list answer your question?
>>>
>>> Jim
>>>
>>>
>>> On Fri, Oct 23, 2020 at 2:18 PM Ian M <merinian@gmail.com> wrote:
>>> >
>>> > Hi Jim,
>>> >
>>> > Thanks for your response.
>>> >
>>> > My confusion surrounds how the filesystem gets its initial labels, th=
ey do not seem to be coming from the policy itself.
>>> >
>>> > e.g. the contents of /bin/ should be labeled bin_t according to the p=
olicy, but are root_t at boot.
>>> >
>>> > The filesystem does support xattrs, but as it is a ramdisk used to bo=
ot linux the extended attributes do not survive a reboot.
>>> >
>>> > Thanks,
>>> >
>>> >
>>> > Ian
>>> >
>>> >
>>> >
>>> >
>>> >
>>> >
>>> > On Fri, Oct 23, 2020 at 2:06 PM James Carter <jwcart2@gmail.com> wrot=
e:
>>> >>
>>> >> On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
>>> >> >
>>> >> > Hello,
>>> >> >
>>> >> > I hope this is the right list for this question:
>>> >> >
>>> >> > I've got an embedded system that uses its initramfs as its root fi=
lesystem as well.  At boot, after the selinux policy loads, everything on t=
he rootfs is incorrectly labeled as system_u:object_r:root_t.   I have temp=
orarily worked around this by adding a restorecon on the rootfs at boot, bu=
t since the rootfs is a ramdisk the changes do not survive a system reboot.
>>> >> >
>>> >> > I may be incorrect, but my understanding (assumption?) is that the=
 labels would be applied when the policy is loaded at boot.  So I cannot un=
derstand why the labels are always incorrect.
>>> >> >
>>> >> Filesystem labels are not applied when the policy is labeled. On
>>> >> filesystems that support xattrs, a fs_use_xattr rule is used to tell
>>> >> SELinux to use the label stored in the security.selinux xattrs, but
>>> >> the filesystem will still have to be labeled initially. If the fs do=
es
>>> >> not support xattrs and every file can be labeled the same, then a
>>> >> genfscon rule can be used.
>>> >>
>>> >> I am not sure of your exact case, but you can find more information =
in
>>> >> the SELinux Notebook - See
>>> >> https://github.com/SELinuxProject/selinux-notebook
>>> >>
>>> >> Jim
>>> >>
>>> >> >
>>> >> > Thanks,
>>> >> >
>>> >> > Ian
