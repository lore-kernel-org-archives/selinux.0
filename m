Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDCEC43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5521019
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 21:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF5521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeK3IXc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:23:32 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:2972 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3IXb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 03:23:31 -0500
X-EEMSG-check-008: 619888593|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="619888593"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Nov 2018 21:16:44 +0000
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="21167864"
IronPort-PHdr: =?us-ascii?q?9a23=3Acfr1zhS0E2x2jbxXVZBv38EeL9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZxyEt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiH/o06000O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaQIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eO73hA5bNLnzEkLf6Zr?=
 =?us-ascii?q?t98E9dxxQpzd9B+p1UC6sNIPLuWkXprtzXEgc5MxCow+bgENh9yIweWWWPA6?=
 =?us-ascii?q?CDNKPfqkWI6fwyLOmMfoAVpCzxJOQi5/7rlXU5g0MSfbG13ZsLb3C1BvNmI0?=
 =?us-ascii?q?CeYXr3hNcOC3sFsRQlQezwllKNTD5TaGyuX64m+j47D4emB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa29dBFCMEGnnd4GZVPcXcy+SLM5hnSIAVbe8UI8uywquuBX9y7p9Ie?=
 =?us-ascii?q?re4jcYuo771Nhp++3Tkgk/9SduAMSZ02CMTmF1nmUTSjAs2qBwvFZ9ylCC0a?=
 =?us-ascii?q?dlmfBXCdtT5/ZRWAcgKZHc1/B6C8z1Wg/ZZteGUkumQtG9DDEpVN0x3tsOb1?=
 =?us-ascii?q?94G9WliRDDxTSlD6UJmLyMAZw+6rjc0GTpJ8Zh13bG07Esj10nQstJKG2nib?=
 =?us-ascii?q?dz9wvNCI7TlUWWiaKqeL8C3C7C6miD13CCvEJGXw5qV6XKQ3QfalHRrdTj6U?=
 =?us-ascii?q?PIV6WuBqg/Mgtd1c6CLbNHatnojVVAWffiN83SY3+3m2exAhaIwL2MbJHxdm?=
 =?us-ascii?q?UD0yXSFlIEnxoQ/XmYLwg+ADmuo2bEADxpD1LvbFvm8fNip3OjUk800waKYl?=
 =?us-ascii?q?Vl17q0/B4VmPOdR+od3rIfpSgutSt0E0i539/NFdqAqBRufL9GbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpC6KKBinFEeeRxtv0zyzxV3FplAkc8yoXMx0gVyLaOY0FVcdzKXxp?=
 =?us-ascii?q?3wJLLXJXfo/By1aK7ZxEve0NCI9acL8vg4rE/jvA6xHEo473pny8VV02eb5p?=
 =?us-ascii?q?jSEQUTX4j+UkIs9xh6vLzaeDcy6J7U1XJ2Lam4qCPN29UsBLht9hH1WtZcNK?=
 =?us-ascii?q?SfXDTgHtcXC8nmfOkrmFyudTofLu1I+aI1ecO7Iaiowqmuad18kSqmgGIP24?=
 =?us-ascii?q?V01kaB5mIoUeLT94oUyPGfmA2cXnHzi0n34ZO/opxNeTxHRjn38iPjHoMEI/?=
 =?us-ascii?q?QoJYs=3D?=
X-IPAS-Result: =?us-ascii?q?A2AuAAAhVgBc/wHyM5BlGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFaKYE1MyeDeZQhUAEBBoEILYkejiaBejgBhEACgzIiNgcNAQMBAQEBA?=
 =?us-ascii?q?QECAWwogjYkAYJhAQEBAQIBIw8BBUEFCwsYAgImAgJXBg0GAgEBgl4/gXUFC?=
 =?us-ascii?q?Kl2gS+KLoELiwsXeIEHgTiCa4gFglcCiRaCA4UFUI81CZEsBhiBWog0hw6aG?=
 =?us-ascii?q?wMugVUrCAIYCCEPgyeQeSEDMIEFAQGNPwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Nov 2018 21:16:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wATLGhGD029610;
        Thu, 29 Nov 2018 16:16:43 -0500
Subject: Re: overlayfs access checks on underlying layers
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
 <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov>
Message-ID: <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
Date:   Thu, 29 Nov 2018 16:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/29/18 4:03 PM, Stephen Smalley wrote:
> On 11/29/18 2:47 PM, Miklos Szeredi wrote:
>> On Thu, Nov 29, 2018 at 5:14 PM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>
>>> Possibly I misunderstood you, but I don't think we want to copy-up on
>>> permission denial, as that would still allow the mounter to read/write
>>> special files or execute regular files to which it would normally be
>>> denied access, because the copy would inherit the context specified by
>>> the mounter in the context mount case.  It still represents an
>>> escalation of privilege for the mounter.  In contrast, the copy-up on
>>> write behavior does not allow the mounter to do anything it could not do
>>> already (i.e. read from the lower, write to the upper).
>>
>> Let's get this straight:  when file is copied up, it inherits label
>> from context=, not from label of lower file?
> 
> That's correct.  The overlay inodes are all assigned the label from the 
> context= mount option, and so are any upper inodes created through the 
> overlay.  At least that's my understanding of how it is supposed to 
> work.  The original use case was for containers with the lower dir 
> labeled with a context that is read-only to the container context and 
> using a context that is writable by the container context for the 
> context= mount.
> 
>> Next question: permission to change metadata is tied to permission to
>> open?  Is it possible that open is denied, but metadata can be
>> changed?
> 
> There is no metadata change occurring here. The overlay, upper, and 
> lower inodes all keep their labels intact for their lifetime (both 
> overlay and upper always have the context= label; upper has whatever its
                                                   ^^lower^^

> original label was), unless explicitly relabeled by some process.  And 
> when viewed through the overlay, the file always has the label specified 
> via context=, even before the copy-up.
> 
>> DAC model allows this: metadata change is tied to ownership, not mode
>> bits.   And different capability flag.
>>
>> If the same is true for MAC, then the pre-v4.20-rc1 is already
>> susceptible to the privilege escalation you describe, right?
> 
> Actually, I guess there wouldn't be a privilege escalation if you 
> checked the mounter's ability to create the new file upon copy-up, and 
> checked the mounter's access to the upper inode label upon the 
> subsequent read, write, or execute access.  Then we'd typically block 
> the ability to create the device file and we'd block the ability to 
> execute files with the label from context=.
> 
> But copy-up of special files seems undesirable for other reasons (e.g. 
> requiring mounters to be allowed to create device nodes just to permit 
> client's to read/write them, possible implications for nodev/noexec, 
> implications for socket and fifo files).

