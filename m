Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D7C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD62821775
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 18:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n8uMxpds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBFSMK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:12:10 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:19294 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgBFSMK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 13:12:10 -0500
X-EEMSG-check-017: 53882841|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="53882841"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 18:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581012727; x=1612548727;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4PMo+gFw18rYhgteclnTPCAGX/Iu/u9vd7kkq3t2kyQ=;
  b=n8uMxpdsZhMMOJs+2xi+SY2f37i0wGEAA4A9IipF4VcAynCt25wICUDH
   qHXzCARgrVw2q728SgZGsp9hobu70nAjht/1jIZB1tqLNBUfba4uWU/oh
   eBUx6YoRGJ/Fvo2Cw7WAR+uQnqzocucyjen6JN5uVVuEgEn6HYBlkG7r9
   sDLTky5vEPkQFnm4UYv+4wlMt1tJi5qJmVbLKNNao7fr9UZwPFBy/7vR0
   W0tWi5M8qjvRpHgxOw6OVat2j/96w5AMmMab+5o48pgkJY+e28qkgoqdU
   lFAOp7kV927UBJHDylDU1tHa3KkHU/v59MeiMui0ZC1urO5iAUfM4iNTX
   w==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32775798"
IronPort-PHdr: =?us-ascii?q?9a23=3ArUarUBzSYtHf5m7XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4QLfad9pjvdHbS+e9qxAeQG9mCt7QZ0KGP6/+oGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFiJ6s/xR?=
 =?us-ascii?q?fFv2dEduZLzm9sOV6fggzw68it8JNt6Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFiXHs3a0+zu?=
 =?us-ascii?q?8vDwfI0gI9FN4KqXjZotH4OKIUXOuozqfH0C/DYutL1znj5ojGchMvr/+CUr?=
 =?us-ascii?q?1/c8Xe1UYhGhjZjliSs4HpIy+Z2+oPvmWd8uFuVfivi2kiqwxpvzav2tkjip?=
 =?us-ascii?q?HJho0LzFDP6Dh3wIMvKt28TE50f96lG4ZXuiGBKoR2WdgvQ31ouSkmyr0Gvo?=
 =?us-ascii?q?S3fC4RyJs93RLfZPuHc5aR7x/lSe2fLzB4hHd/d7K+gRa/6UegyuzgVsm0zV?=
 =?us-ascii?q?ZFtTBJncXLtnAI0RHY98uJSuNl80u81juC2Brf5+FZLUwui6bWJIAtzqQtmp?=
 =?us-ascii?q?cVrE/NBDX5mF/sg6+Tbkgk/++o5Pn5bbj+vZ+cMpN0ihn5MqQzhsyzGeQ4PR?=
 =?us-ascii?q?YKX2ic4em8yKfs/Vf4QLVXlf06iKjZsJbUJcQcva62HRNa3pw/6xe/Ezim0N?=
 =?us-ascii?q?MYkWMBLF1ZYxKIk5LlO1TPIPD8Ffu/glKsnyl3x/3eI7HsDZrAImLDnbv8Z7?=
 =?us-ascii?q?px9UFRxBQpwdxC/55UD6sOIPP3Wk//rtzYCRo5PhSvw+n6E9VwzZ8eWGKTDa?=
 =?us-ascii?q?+ZN6Peq1mI5vk1LOWWa48Vvyj9J+A/5/HylX85hUMdfa6x0JsMbXC4Ge5mLF?=
 =?us-ascii?q?udYXX2hNcODHwHvgU5TOzth12CVSBca2yuUKI74zExEJimApvbRoCxnLyB2z?=
 =?us-ascii?q?+2HoVMaWBbDlCBCm/oeJ+ZW/cIcS6SJ8hhkjseVbe/UYMuyRautAriwbp9Mu?=
 =?us-ascii?q?XU4jEYtY7k1NVt+eLTjQs99SZ1D8SGyGyNV3t7nnkJRz8txKB/pVZyxUud3q?=
 =?us-ascii?q?RihPxYD9NT7etTUggmLZ7c0/B6C9fqVwLCYNiGVk2mTcmhATE2TdI82MMBY0?=
 =?us-ascii?q?ZnG9WlixDD3jeqA7oPm7yMHpw0/brW32LtKMZl13bGyK4hgkE8TctJKW2mga?=
 =?us-ascii?q?h/+hPNCI7PlEWZkr2qdasG0C7K7meDwnKEvFtEXw5oTaXFQXcfa1PKotvl/E?=
 =?us-ascii?q?PCSKSuCa88PwRbz86NN7FKatrojVpbXvvsJNPeY2epkWeqGRmI3q+MbJbte2?=
 =?us-ascii?q?gFwCXdD04EkgAJ8XaCKAgxGiShrnnfDDxoCVLgfUfs/fNip3O8S08+1xuKYF?=
 =?us-ascii?q?F517qp5h4VguSRS+gN0bIAuSchrSh0HVmm0tLIBNqPuRBhcL9fYdwj+ldH03?=
 =?us-ascii?q?zWtwhnMpynNaBiiUYUcx5rsEP2yxV3FoJAnNAurHMrygpyNK2Z3EpCdzyGx5?=
 =?us-ascii?q?DwPKPYKm3p8RCxZK7ZxEve3MyV+qgR8vQ4rUvsvAWzGkol6XVn3MFf02GA6Z?=
 =?us-ascii?q?XSEAoSTZXxX1409xdkvbHaZDcy54fN2X1wL6a7qDrC1skzC+sj1xmgZdBfMK?=
 =?us-ascii?q?KZGwPoD8IaAM2uIvQwm1e1dhIEIPxS9KksMsy6cPuG3qirPOF6nDKhlmlH74?=
 =?us-ascii?q?d90kWD9yp4VOHExYoKw/ad3ljPazCpt0usrM3x0aVDfzwWF2yzgXz/AYlLa6?=
 =?us-ascii?q?l7e4ojBmCpLMm6gN55gsi+dWRf8QuYG14e2MKvMSGXZlj50BwYgV8bulS7iC?=
 =?us-ascii?q?C4yHpyiDhvoa2Bin+di9/+fQYKbzYYDFJpik3hdM3t1IEX?=
X-IPAS-Result: =?us-ascii?q?A2DUAgCOVjxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVCESKoQViQOGZQEBAQaBEiWJcJB0A1QJAQEBAQEBAQEBKwwBAYRAAoJhO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMBAQEBAQMjFUEQCw4EAwMCAiYCA?=
 =?us-ascii?q?kkOBg0GAgEBgmM/AYJWJQ+sJnWBMoVKg2GBOAaBDiqMPXmBB4E4DAOCXT6CZ?=
 =?us-ascii?q?AKEdYI8IgSWXWFGl2eCRIJOhHyOdgYbmwuXTpRIIjeBISsIAhgIIQ+DJ1AYD?=
 =?us-ascii?q?ZIQinEjAzCMByyCFwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 18:12:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016IB5E8194581;
        Thu, 6 Feb 2020 13:11:06 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>
Cc:     paul@paul-moore.com, eparis@parisplace.org, keescook@chromium.org,
        anton@enomsg.org, Colin Cross <ccross@android.com>,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>
References: <20200206165527.211350-1-smoreland@google.com>
 <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
 <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov>
 <CAKLm694DMH0JCpHuT4HgMd4yCNJZPFMpex8iEiRF9kRjPb0d6g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a8321785-902d-9186-fcf5-ee12a362a207@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 13:12:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKLm694DMH0JCpHuT4HgMd4yCNJZPFMpex8iEiRF9kRjPb0d6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 12:41 PM, Steven Moreland wrote:
> On Thu, Feb 6, 2020 at 9:35 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 2/6/20 12:21 PM, Stephen Smalley wrote:
>>> On 2/6/20 11:55 AM, Steven Moreland wrote:
>>>> From: Connor O'Brien <connoro@google.com>
>>>>
>>>> Add support for genfscon per-file labeling of bpffs files. This allows
>>>> for separate permissions for different pinned bpf objects, which may
>>>> be completely unrelated to each other.
>>>
>>> Do you want bpf fs to also support userspace labeling of files via
>>> setxattr()?  If so, you'll want to also add it to
>>> selinux_is_genfs_special_handling() as well.
>>>
> 
> Android doesn't currently have this use case.
> 
>>> The only caveat I would note here is that it appears that bpf fs
>>> supports rename, link, unlink, rmdir etc by userspace, which means that
>>> name-based labeling via genfscon isn't necessarily safe/stable.  See
>>> https://github.com/SELinuxProject/selinux-kernel/issues/2
>>>
> 
> Android restricts ownership of these files to a single process (bpfloader) and
> so this isn't a concern in our architecture. Is it a concern in general?

I guess if the inodes are pinned in memory, then only the original name 
under which the file is created will be relevant to determining the 
label and subsequent rename/link operations won't have any effect. So as 
long as the bpfloader creates the files with the same names being 
specified in policy, that should line up and be stable for the lifecycle 
of the inode.

The alternative model is to have bpfloader look up a context from the 
userspace file_contexts configuration via selabel_lookup(3) and friends, 
and set it on the file explicitly.  That's what e.g. ueventd does for 
device nodes.  However, one difference here is that you could currently 
only do this via setxattr()/setfilecon() after creating the file so that 
the file would temporarily exist in the default label for bpf fs, if 
that matters.  ueventd can instead use setfscreatecon(3) before creating 
the file so that it is originally created in the right label but that 
requires the filesystem to call security_inode_init_security() from its 
function that originally creates the inode, which tmpfs/devtmpfs does 
but bpf does not.  So you'd have to add that to the bpf filesystem code 
if you wanted to support setfscreatecon(3) on it.
