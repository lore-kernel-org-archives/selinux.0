Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE1EC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE111227BF
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 13:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FLfKJ7x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLSNqu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:46:50 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:22265 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLSNqt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 08:46:49 -0500
X-EEMSG-check-017: 37200802|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="37200802"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2019 13:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576763207; x=1608299207;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=a9YolGb2KSFH2ThI8z9INt/N5uK1BbCN3x7Ot/zm0Rk=;
  b=FLfKJ7x6St3/6VkB5guxymQQrS2dUdaxLtrVH0aEqtuMiz+9Ti0eVQBU
   oKKFTNyN4UyyK9DTWownKok1OW2VAxgjXAGhvLk+ms1Vrr8r63zFGfpaf
   cBcRsxmBwShr3D2MsGqIPQBaUryYBmf2WvSU4z+QtcQqgemV5YdrPfa0u
   CslcW6MOqtXXkr19/tUWmB0q8QtLXsmh9PzC5UNS+TqTZNFSkuM3CbJAl
   eRmeX7RytLAZVgLDy5GbeVsWpYTHVcHCmXiYykYSZwnDUJD49t3kGNu7T
   iaN8WLEpVxtLNeLT23hazDgUW4CPl5MpyuPyqnPPufhO1zxJhQJPdFf5H
   g==;
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="36960459"
IronPort-PHdr: =?us-ascii?q?9a23=3AkH7duxVKvtWrwIe4lKfAjGEBN+nV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRCHtadThVPEFb/W9+hDw7KP9fy5AipauM/K7StKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYd/N6o9xR?=
 =?us-ascii?q?vEr3VVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhBOfixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTsELDHiHxmEXtkqCZal8o+vSo6uv7YrXmoYWQN4lohQHlLqsigMm/AeU8Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHkT7hHgec6n6nEvJzAO8gWqbC1DxVI3oo77hawFTam0N?=
 =?us-ascii?q?AWnXkdK1JFfQqKj5P0NFHVO/34Efe+jEiskDds3fzGOKbhDY/XInjMl7fhY6?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kaIPL2RkDxqsfVAQM+Mwywx+boEs5y1oQEWW2VGK?=
 =?us-ascii?q?OWLKTSsVqQ7OI1P+aMfJMVuCr6K/U9+/Hhl2Q5lkEdfKSyxpsYdHC4Ee57I0?=
 =?us-ascii?q?WXZXrjnM0BHX4WsQUkVuDllFqCUTtLbXaoQ608/i07CJ6hDYrbWo+imqeB0z?=
 =?us-ascii?q?m7H5FMfWBJFlCMHm31d4WKX/cDdjiSL9RgkjwCSbiuVYsh2Quyuw/9zrptNv?=
 =?us-ascii?q?DU9TEAtZL/yNh14PXelRM39TxzFcSdyWCNT3pvk2MOXTA22b5woU1nxleEy6?=
 =?us-ascii?q?h4jORSFcZP6PNRTgc6KZncwvR+C9DzXALBY9iIRE+9Qtq4HT4xU8gxw94SY0?=
 =?us-ascii?q?d9AtmiixfD0De3A78RibOGH4I08q3C0HjrPcp9yGjJ1LMnj1Y4RstDL2qmhr?=
 =?us-ascii?q?Rw9wLLHY7Gj12Zl7q2daQbxCPN73mMzW6PvEFeTQ5xXr7IXW4QZkTIt9T1/E?=
 =?us-ascii?q?DCQKG0CbQhLARBzdSOKqxQat3mlV9GXuvsOMzCY2KtnGe9HRWIya2SY4rxZ2?=
 =?us-ascii?q?od2yLdCEsfng8P/XaGLw8+BiKgo2LDCTxiD1XvY1nj8eNmsnO0Ulc0zx2Wb0?=
 =?us-ascii?q?1mz7e1+BkVhfyaS/8J3LIEvychpC9yHFamwd3WDcGNqBZ7c6VaZtM95lZH2n?=
 =?us-ascii?q?7DuAx5JJCvM6dihlsGeQRto0zuzwl3CplHkcUytHMl0gxyKa2F0FNAcTOUxJ?=
 =?us-ascii?q?PwNaPNKmn04h+vb7Xb2lDH3NaS/acP9uo3p0/4vA6zFUoi7m9n3MNP33ua+J?=
 =?us-ascii?q?rGFggSUYrpWEYt6xd6v63aYjU6547MzX1jK7S0sjvZ1tIxHuQl1xKgc85aMK?=
 =?us-ascii?q?ODEw/yCdMVC9KyJ+wtnlj6Ji4DadtT8akyd+atSfqaxK+mdLJ7mTm4pW9A5I?=
 =?us-ascii?q?R02EWW/mx3TeuejLgfxPTN5ReKTzfxih+at8nznY1VLWUJEnGX1TnvBIkXYL?=
 =?us-ascii?q?Z7O4kMFzH9cIWM2txiisu1CDZj/1m5CgZDgZL4dA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BtAgB+fftd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgXyBc?=
 =?us-ascii?q?QWBbAEgEoQwiQOGXAaBN4EBiGuRRQkBAQEBAQEBAQE3AQGEQAKCQDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIxU2CwULCxgCAiYCAlcGDQgBA?=
 =?us-ascii?q?RWCSj+CUwUgq3l1gTKFT4M1gT2BDiiMM3mBB4ERJw+CKDU+h1mCXgSNHlOJH?=
 =?us-ascii?q?kaIFo8ggj6CRIopiSUGG5pRLasGIoFYKwgCGAghDzuCbU8YDY0bAgEXjkEjA?=
 =?us-ascii?q?5FGAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Dec 2019 13:46:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBJDkHS0111930;
        Thu, 19 Dec 2019 08:46:19 -0500
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Simon McVittie <smcv@collabora.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
 <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
 <e7aa3b6f-cee1-6277-21dd-77a4db9bbc2b@tycho.nsa.gov>
 <a522de22-ba62-a24d-24f7-b69418e7ec0b@tycho.nsa.gov>
 <20191219121939.GA1291250@horizon>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55b5c889-ff38-38c4-578e-ec4211b837a4@tycho.nsa.gov>
Date:   Thu, 19 Dec 2019 08:47:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219121939.GA1291250@horizon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/19 7:19 AM, Simon McVittie wrote:
> On Wed, 18 Dec 2019 at 15:50:45 -0500, Stephen Smalley wrote:
>> Ok, this seems to be a lack of support in AppArmor for saving the peer info
>> for unix/local domain sockets, so not your bug.  Doesn't implement the
>> necessary hooks.
> 
> Ubuntu kernels have working getsockopt SO_PEERSEC for AppArmor (which
> definitely works for D-Bus, or did when I tried it in the past), but it
> seems to be a downstream patch.
> 
> Is there a combination of LSMs where this works correctly and shows
> multiple LSMs' labels, either upstream or with downstream patches? D-Bus
> ought to be an early consumer of this information, but that's going to
> be difficult if there's nowhere I can test it. If there was a pair of
> in-tree or out-of-tree test LSMs that automatically labelled process
> 12345 and all sockets that it created with something like (pseudocode)
> 
> {
>    "labeltest1": "labeltest1process12345",
>    "labeltest2": "labeltest2process12345"
> }
> 
> then that would make testing straightforward.

AFAICT, you can't yet stack Smack+SELinux, and AppArmor requires 
out-of-tree patches to support SO_PEERSEC so there is no in-tree 
combination that will demonstrate the new SO_PEERCONTEXT for multiple lsms.

>  From my user-space developer perspective, I'd really like the kernel
> to have at least brief documentation of the assumptions that can be
> made about the compound format, to avoid people like me having to
> ask the linux-security-module mailing list and use the answers as our
> documentation:
> 
> - Can I assume that the LSM names (conceptually, keys in the associative
>    array) are printable ASCII? If not, can I at least assume that they are
>    printable UTF-8, or that LSMs whose names are not printable UTF-8 are
>    too weird to be worth supporting in user-space APIs?
> 
>    If this decision hasn't been made yet, I would like to request ASCII,
>    or UTF-8 if a wider character repertoire is desired - that would make
>    user-space APIs a lot easier to write.

ASCII works for me.

> 
> - What can I assume about the format of the labels (values in the
>    associative array)?
> 
>    From previous conversations on linux-security-module it seems the
>    answer is: they are intended to be printable strings; their encoding
>    is unspecified (could be ASCII or UTF-8, but equally could be Latin-1
>    or anything else); there are no reserved or disallowed characters
>    except '\0'; individual LSMs like SELinux and AppArmor might impose
>    tighter restrictions, but LSM-agnostic code can't assume those
>    restrictions are present.
> 
>    Even if the format is conceptually an unspecified encoding with every
>    nonzero byte allowed, if LSM and security policy authors establish a
>    convention that the labels are ASCII or UTF-8 without control characters
>    such as newlines, that would make user-space a lot easier to deal with.

I believe there is existing userspace code that seems to presume that 
they are NUL-terminated strings printable using %s format specifiers to 
printf-like functions in output and log messages _without_ any escaping. 
  Not just the LSM-specific libraries. systemd (for SO_PEERSEC), 
procps-ng (for /proc/pid/attr/current), perhaps others.  I think we can 
rely on that remaining true since the world would break.

> - Can I assume that the names and labels in /proc/$pid/attr/context
>    correspond exactly (same label <=> same bytes) to the ones in
>    SO_PEERCONTEXT?
> 
>    In particular, a design issue in the previous interfaces with
>    /proc/$pid/attr/current and SO_PEERSEC was that AppArmor puts
>    "unconfined\n" in /proc/$pid/attr/current, but "unconfined\0" in
>    SO_PEERSEC, and implementations of protocols like D-Bus can't know
>    that these are meant to be the same without LSM-specific knowledge
>    (namely "AppArmor profile names can't contain newlines").
> 
>    If this new API is an opportunity to declare that LSMs are expected
>    to put the same canonical form of a label in /proc/$pid/attr/context and
>    SO_PEERCONTEXT, possibly with a non-canonical version (adding '\n' or
>    '\0' or similar) exposed in the older /proc/$pid/attr/current and
>    SO_PEERSEC interfaces for backwards compatibility, then that would make
>    life a lot easier for user-space developers like me.

I'm all for this but the current implementation reuses the same 
underlying hooks as SO_PEERSEC, so it gets the same result for the 
per-lsm values.  We'd need a separate hook if we cannot alter the 
current AppArmor SO_PEERSEC format.  Technically AppArmor seemingly 
doesn't truly provide SO_PEERSEC in mainline today even though it 
implements the hook for returning the result because it never actually 
sets the peer on Unix domain or INET domain connections AFAICT, so they 
could change the format upstream without a compatibility break but it 
may break Ubuntu.  So it might require using a new hook for 
SO_PEERCONTEXT.  Which is fine with me.

> - Does the order of the names and values matter? Can I assume anything
>    about them?
> 
>    It would make the D-Bus API more straightforward if I can assume that
>    the order doesn't matter, and represent it as an unordered map
>    (associative array), like a Perl hash or Python dict.

IMHO order shouldn't matter.

> I'm asking all this from the D-Bus perspective, but anything that
> wants to store or forward LSM contexts in an LSM-agnostic way will
> have essentially the same requirements - I could imagine X11, Wayland,
> varlink etc. hitting the same problems D-Bus did.
> 
> Thanks,
>      smcv
> 

