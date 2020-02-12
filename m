Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE8C2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525852073C
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nX6c6PT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLSI3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:08:29 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:29108 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBLSI2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 13:08:28 -0500
X-EEMSG-check-017: 58311661|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="58311661"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 18:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581530903; x=1613066903;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xdKqfTeS3cUUUdfMBjls18OGCcQWswDazZ6dHFbCVxo=;
  b=nX6c6PT2WR1w9z2iC8vlncJAoSjxiwCuRHfUrgr8j9x/gD65J6L4oXfF
   87EizuIdU6niKLWuPrnZBvneZ4VT7/C1xQIKKBXzuKCc424PxDNDTggb0
   5iCTqJWG8mVlbyIGI3+qQrJ6UVLP5qCyEBRLfQJC6lQqoKL0AQLfJN4jr
   +b7hA2c++edPXAuDldu6NozqbqcRjraH8jBOJuGemBD47Ic50hzrvkKJa
   5YCK/xFmhK37LBs3H9DoIdheY7DID7ZCJCbZhJ0De4UtHiJVSwWePAo1j
   JMWN1AHiVt3ysy8eQL0ngWlA3KBxnJQoETeDpTD5ZcTz/LVkncfAl7rU8
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39029494"
IronPort-PHdr: =?us-ascii?q?9a23=3A5FJH1RLK9Jdqvt5+o9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXL/z/rarrMEGX3/hxlliBBdydt6sYzbSL+Pm4CSQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twTcu8kZjYd/Nqo8yQ?=
 =?us-ascii?q?bCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx17MIuZ?=
 =?us-ascii?q?m+fCcQyZQnwQbSa/OGc4iU4hLjSf2eLS1ki3JifbKznw6y/lK9yu34T8W01V?=
 =?us-ascii?q?FKri1fktbSrHwCyxvT6s2BR/Bg/UmhwS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEynrk0vslqCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMg?=
 =?us-ascii?q?QWX2iU5+C81Lr78E3lWrpKlPw2krTCsJzAJMQboKC5AwhO0ok99xmzFSum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHgJTyO17SOvz4CPa/g1C0nDdqwfDJIKHhD43QInXMn7rtZ7?=
 =?us-ascii?q?Zw51NGxAYtwt1T+YhYBqwZLPL2QEDxtdjYDhEjMwyzxubqEM592Z4FWW+UHq?=
 =?us-ascii?q?+YML/dsV+P5u41JemMf5UatCzyK/gi+f7ilWU5lkMFfam1wZsXb2i1Hu9jI0?=
 =?us-ascii?q?Wee3rjnNMBHn0MvgUjV+Hqh1qCUTlcZ3a2Qa0w/C00CIWjDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GEkqDEWrsd4ifQ/cDcj+SIst4njwBUrihTJUh2g+0uADmzLpnK/?=
 =?us-ascii?q?Le+jcEupL7yNh1++rTmAku+jNoFcSd1HqNT3pvk2wSQT85wbp/oUt8yliey6?=
 =?us-ascii?q?R3n/tYFdlL7fNTTgg6LYLcz/B9C93qRg3BedGJSFChQtW8BjE8Vd0xw9gJY0?=
 =?us-ascii?q?ZyH9WtkArP0DatA78Qj7aLHoA78rrA33jtIMZw03XG27c7j1kgXMRPMXSqhr?=
 =?us-ascii?q?Jh+AfJAo7EiF+Wl6C3eqQG2y7N9XqMwXCSs0FfVQ56Sb/FUmwHZkvKsdT54V?=
 =?us-ascii?q?vPQKG2Cbs9KAtByNWCJ7BSatLzl1VGRezjOMzaY22rh2i/GwyExrSWbIrlY2?=
 =?us-ascii?q?8dxjnSCFAYkwAP+naLLQs+CTm/rGLFEDNuElXvY0D3/OZiqHO7VEg0zwSLb0?=
 =?us-ascii?q?180rq54BkVheaTS/kLxLILpD8hqyloHFa6x9/ZEdyApxZmfKVaet4y/lFH1W?=
 =?us-ascii?q?XctwxmMZysNadihkQRcw5vpUPhyw13CplckcgttH4q0A1yKaSY0V9bczOYwI?=
 =?us-ascii?q?z/Or7MJ2nz+hCvd7DZ2lXE3NmK/acP7ewyq0//swGxCkoi73Jn3sFO03SC4p?=
 =?us-ascii?q?XKDQwSUY/+U0ss6Rh6qK/VYjMn64PXy3JsK6+0vSHG294zA+sl0Bmgdc9FMK?=
 =?us-ascii?q?yYDA/yD9EaB8+2JewumlipaA8EPe9L+K43Icymbf2G17CvPOt7gjKmgnpI4J?=
 =?us-ascii?q?pn3kKP6SV8UOjI0IgBw/2C2QuHTTj83x+dtZXMhY1aaDdaO22lxCztAoIZMr?=
 =?us-ascii?q?Z3epwGDW6oL+W4wdJxg5OrUHldohrrP1ob3IeMfh2IYhSpxQRN0WwPqGGj3C?=
 =?us-ascii?q?6/yCZ51Touq/zM8jbJxrHZaBcfOmNNDFJnhFPoLJn828sWR2C0fgMpk12j/k?=
 =?us-ascii?q?+8yK9F8vcsZ1LPSFtFKnClZ1ppVbG94//bOJ9C?=
X-IPAS-Result: =?us-ascii?q?A2CNAgCjPkRe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQUiQOGZQEBAQEBAQaBN4lwkHMDVAkBAQEBAQEBAQErDAQBAYRAA?=
 =?us-ascii?q?oJtOBMCEAEBAQUBAQEBAQUDAQFshTcMgjspAYMBAQEBAQIBIxURMBALDgQDA?=
 =?us-ascii?q?wICJgICSQ4GAQwGAgEBgmM/AYJWBSAPq0t1gTKFSoNIgT6BDiqMPnmBB4E4D?=
 =?us-ascii?q?4JdPoJkAoR1gjwiBI4CiF9kRpdrgkSCT4R+jn4GHJsVjmiIbpRQIjeBISsIA?=
 =?us-ascii?q?hgIIQ+DJwlHGA2SEIpxIwMwjx4sghcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 18:08:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CI71i0156600;
        Wed, 12 Feb 2020 13:07:01 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Colin Cross <ccross@android.com>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200206165527.211350-1-smoreland@google.com>
 <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
 <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov>
 <CAKLm694DMH0JCpHuT4HgMd4yCNJZPFMpex8iEiRF9kRjPb0d6g@mail.gmail.com>
 <a8321785-902d-9186-fcf5-ee12a362a207@tycho.nsa.gov>
 <CAHC9VhQVcgQ7ZKXi+Umm51WNgfNSzNX7Zoe=MyaLo1rRm-uUtA@mail.gmail.com>
 <CAKLm695ZVCfdTnyA4UjaWeQmP3gGNjk_kMj1YOdV+kAbcvSrBw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a8753441-ef0f-09f2-520d-f8ea8eedb2fb@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 13:09:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKLm695ZVCfdTnyA4UjaWeQmP3gGNjk_kMj1YOdV+kAbcvSrBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/12/20 12:46 PM, Steven Moreland wrote:
> And I strongly encourage our downstream in the same way :) I try, I
> try. However, I am a n00b here (thanks for merging "my" first linux
> patch).
> 
> Looking at this code, I was wondering, why isn't SELinux labelling
> completely orthogonal to the fs type? Is this a measurable
> memory/performance thing?

If you just mean why don't we turn on SE_SBGENFS for all filesystem 
types, that's discussed in
https://github.com/SELinuxProject/selinux-kernel/issues/2

It isn't always safe so we have been whitelisting the filesystem types 
that are supported.

More generally, labeling in SELinux goes beyond just GENFS; there are 
the SECURITY_FS_USE_* filesystem labeling behaviors defined by policy 
and those are also based on fstype, just not hardcoded in the kernel.

> 
> 
> On Tue, Feb 11, 2020 at 7:17 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, Feb 6, 2020 at 1:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 2/6/20 12:41 PM, Steven Moreland wrote:
>>>> On Thu, Feb 6, 2020 at 9:35 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>
>>>>> On 2/6/20 12:21 PM, Stephen Smalley wrote:
>>>>>> On 2/6/20 11:55 AM, Steven Moreland wrote:
>>>>>>> From: Connor O'Brien <connoro@google.com>
>>>>>>>
>>>>>>> Add support for genfscon per-file labeling of bpffs files. This allows
>>>>>>> for separate permissions for different pinned bpf objects, which may
>>>>>>> be completely unrelated to each other.
>>>>>>
>>>>>> Do you want bpf fs to also support userspace labeling of files via
>>>>>> setxattr()?  If so, you'll want to also add it to
>>>>>> selinux_is_genfs_special_handling() as well.
>>>>>>
>>>>
>>>> Android doesn't currently have this use case.
>>>>
>>>>>> The only caveat I would note here is that it appears that bpf fs
>>>>>> supports rename, link, unlink, rmdir etc by userspace, which means that
>>>>>> name-based labeling via genfscon isn't necessarily safe/stable.  See
>>>>>> https://github.com/SELinuxProject/selinux-kernel/issues/2
>>>>>>
>>>>
>>>> Android restricts ownership of these files to a single process (bpfloader) and
>>>> so this isn't a concern in our architecture. Is it a concern in general?
>>>
>>> I guess if the inodes are pinned in memory, then only the original name
>>> under which the file is created will be relevant to determining the
>>> label and subsequent rename/link operations won't have any effect. So as
>>> long as the bpfloader creates the files with the same names being
>>> specified in policy, that should line up and be stable for the lifecycle
>>> of the inode.
>>>
>>> The alternative model is to have bpfloader look up a context from the
>>> userspace file_contexts configuration via selabel_lookup(3) and friends,
>>> and set it on the file explicitly.  That's what e.g. ueventd does for
>>> device nodes.  However, one difference here is that you could currently
>>> only do this via setxattr()/setfilecon() after creating the file so that
>>> the file would temporarily exist in the default label for bpf fs, if
>>> that matters.  ueventd can instead use setfscreatecon(3) before creating
>>> the file so that it is originally created in the right label but that
>>> requires the filesystem to call security_inode_init_security() from its
>>> function that originally creates the inode, which tmpfs/devtmpfs does
>>> but bpf does not.  So you'd have to add that to the bpf filesystem code
>>> if you wanted to support setfscreatecon(3) on it.
>>
>> Considering the relative maturity of bpf, and bpffs, I think it's okay
>> to take this small step right now, with the understanding that more
>> work may need to be done, depending on how this is generally adopted
>> by distros and users (for those of you not following the other thread,
>> I've merged the v3 draft of this patch).
>>
>> However, I've been noticing a trend from the Android folks of tossing
>> patches over the wall without much thought beyond the Android use
>> case.  I understand the Android devs have a job to do, and products to
>> focus on, but I would strongly encourage them to think a bit longer
>> about more general use cases before submitting patches upstream.
>>
>> --
>> paul moore
>> www.paul-moore.com

