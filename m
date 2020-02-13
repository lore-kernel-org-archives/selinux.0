Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DABCC352A3
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 20:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FFB2168B
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 20:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YWkHqNqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgBMUyx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:54:53 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:60373 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgBMUyx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 15:54:53 -0500
X-EEMSG-check-017: 55962556|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,438,1574121600"; 
   d="scan'208";a="55962556"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2020 20:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581627291; x=1613163291;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=+o3VCmZk4dfLFGcsvWLbH5cDZP2xGa1k5gyjDi1cbXs=;
  b=YWkHqNqdm0YVA1CNJhUP6ZI1laE+OiWZozeErJi2LQ6EJIo8VfglMfMW
   EwaMLrTPj9HdKpWytAjZBGXPYDEzeezFesDoIr7vxvZSmaTj7BWhNEJKS
   urDGmxQDIpHYvEVDrMSzpoqCYkmT47NqAB9rniLIahRuUP8kTamsIIJC3
   Ks5P4QRW/s9KzUho0266pD7MCu2FudDPbYjV+M/PM8awHMtG2sS0e140f
   mYePtKT5ZqGaelOMOTAzJrwAOoS/Fh/pswDh9VMR4WELJ2UpnN0Jf2vW9
   H+3gyO0b9P2j39vi1TaqsJTFUJsQdpl9fPJcZgapCuXM81xEto3yWEI6k
   A==;
X-IronPort-AV: E=Sophos;i="5.70,438,1574121600"; 
   d="scan'208";a="39104966"
IronPort-PHdr: =?us-ascii?q?9a23=3AcZRbaRK05s/TlLWnINmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLvXxwZ3uMQTl6Ol3ixeRBMOHsq4C1bqd6vy7EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjctcYajZZtJ6s/1x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1BO7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJsETDGCH2mELtjKCIakoo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakMIOjyWkDttNzXFAU5PBGszOn7ENp91pkRWWOJAq?=
 =?us-ascii?q?CHK6PfqkSH5v4uI+mKeI8apiz9K/476P7yl3M2hVgdfayx15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mdcOD2MKvgs4TOz3h1yPSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZjMONlfZK3bjd4yeV78sYSOUL9QpxiYFXrioUYMW3iauvQ78xqFPJP?=
 =?us-ascii?q?bV/DEVr5TuyJ5+4OiF0Vkp+Dh1CdmN+3+CQnsynW4SQTIymqdlrh9T0FCGhJ?=
 =?us-ascii?q?NkjuRYGNob3PZAVgM3JNaI1OBhI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnP3UrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2C7AgC9tkVe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQUiQOGXwaBN4lwkUoJAQEBAQEBAQEBIxQEAQGEQAKCcDgTAhABA?=
 =?us-ascii?q?QEFAQEBAQEFAwEBbIU3DII7KQGDAQEBAQECASMVRgsLGAICJgICVwYBDAgBA?=
 =?us-ascii?q?YJjPwGCVgUgrRN1gTKFSoNHgT6BDiqMPnmBB4E4D4JdPoJLhRCCPCIEl0VGl?=
 =?us-ascii?q?2uCRIJPhH6OfgYcmxeOaJ0+IoFYKwgCGAghDzuCbAlHGA2YYYQgIwMwjyEBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Feb 2020 20:54:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01DKrppu131389;
        Thu, 13 Feb 2020 15:53:52 -0500
Subject: Re: [RFC PATCH 0/1] selinux-testsuite: Use native filesystem for fs
 tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200213163037.14494-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9ee7126b-b021-b384-ecb5-615f041d0a09@tycho.nsa.gov>
Date:   Thu, 13 Feb 2020 15:55:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213163037.14494-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/13/20 11:30 AM, Richard Haines wrote:
> This is a first attempt at running the filesystem and fs_filesystem tests
> on the native filesystem.
> 
> It supports NFS when using the tools/nfs.sh script. NFS will support options
> with rootcontext and fscontext, however due to the fsconfig(2) they bug will
> not pass with these (see note in nfs.sh).
> 
> The filesystem types supported are: ext2, ext3, ext4, xfs, btrfs, hfsplus,
> reiserfs, nfs4. If not in this list, tests are skipped. I'm not sure what
> others need supporting, these seem reasonable and available on Fedora.

Didn't receive the patch but will comment on a few items in your cover 
letter.

Offhand, I'd suggest pruning it to just ext4, xfs, and nfs4.  There is 
no separate ext3 filesystem in the kernel anymore (ext4 provides the 
implementation for both ext3 and ext4).  ext2 and reiserfs seem to be 
legacy filesystems and reiserfs never supported SELinux well to my 
knowledge.  btrfs SELinux support seems to not be well supported; absent 
a distro supporting them both that seems unlikely to change. hfsplus is 
orphaned per MAINTAINERS and not likely to be used as a primary 
filesystem for SELinux regardless.

> I've had to add a number of policy rules to support these types, however
> I've made no attempt to consolidate them. Most are for supporting rootcontext
> and fscontext on NFS. Rules for the 'context' option were many more so
> decided not to add them - any views on this.

Wasn't sure what issue you are encountering there.  Could you use an 
attribute ala file_type and/or fs_type or the corresponding refpolicy 
interfaces to allow what you need with just a few rules?
> When testing btrfs, most tests will fail on tests/fs_filesystem due to
> the fsconfig(2) bug.

Yes, I'm disinclined to include btrfs in our testing until/unless a 
SELinux maintainer is using a distro that defaults to it (or the 
maintainer defaults to using it regardless) and ensures that it is kept 
functioning.
