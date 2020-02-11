Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD6CC352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D320675
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="E75bQ5SX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgBKOwR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:52:17 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:10465 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgBKOwR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 09:52:17 -0500
X-EEMSG-check-017: 54700617|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="54700617"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 14:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581432735; x=1612968735;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=f7E5XCSvIxM1SAaGk9iUkKhKY0I/eann6W2E//Fr2PU=;
  b=E75bQ5SXXUNNP9h99YW0JvVtdZYRapZq7KJRhOliaWqrsKVu9CbzGXB4
   tHSWcoJ6pNW0lLHtaKIt41LbVKgbp4dxjr3tpi+O9HD/rS7C5eixq3sV5
   H0LFyc9iv8tnwTYUmWYDsqpmofUoa6Lwo4kTEhap8OqGX5gOZF2SgGPed
   QVazmNjO5gVa3Mn0FFRor5uAwQIs8ppURXdmKeQ7GRmciZwGmMsBFiT4H
   E7bYOltQosibVwM+LLRrz/xh+vqKckDw7Wyb+NguhkWCppFO/uR3PhJoD
   YxpytP9df3XGl6pdTVkCkixZ7ZDoka9w7l8NLN1jx+rYjh1ycpIfRlRm3
   A==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="38947816"
IronPort-PHdr: =?us-ascii?q?9a23=3AiqOclBQVGANmxPrn21dITMcg6Npsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBKGt8tkgFKBZ4jH8fUM07OQ7/m8HzJbqsjf+Fk5M7VyFD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMgIZvJKk9xx?=
 =?us-ascii?q?rIr3BVZ+lY2GRkKE6ckBr7+sq+5oNo/T5Ku/Im+c5AUKH6cLo9QLdFEjkoMH?=
 =?us-ascii?q?076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XT?=
 =?us-ascii?q?Si6LprSAPthSwaOTM17H3bh8pth69AvhmvuwJwzJLVYIGNNfpxYKXdfc8BRW?=
 =?us-ascii?q?FcWspdTjFNDp+gY4cKCecOM/xYr43grFUQqxWwCxSnCOf2xjJGgnL62Ks32P?=
 =?us-ascii?q?kjHw7bxgwtB88AvnTKotX7N6kcX+66w6bKwjrfYP1bwiv95YvSfxw9vf2BU7?=
 =?us-ascii?q?B9fMzMwkcvDQPFiVCQpJT4MTOJyOsNq2ib4PRmVemylmAnrht+ojyrxsgyio?=
 =?us-ascii?q?jCm4UYykvZ+iVi24s1Od25R1J7Yd6jCpdQsTqaOJFsTsMtRGFopj83x7sbsp?=
 =?us-ascii?q?C1eygKzY4oxx/Za/GffImH/hXjW/uPLjp8nn5qYqq/hw60/EO9yeP8TtG53E?=
 =?us-ascii?q?tFoydKiNXBtm0B2wbN5sWIVPdx5Fqt1DCS3A7J8O5EO1o7la/DJp4kxb4/i4?=
 =?us-ascii?q?QcvFzYHi/zhEX2lKiWdlg4+uSw6+TofLHmppiEOo9okA7+KKUumtGkAegiMw?=
 =?us-ascii?q?gOWWab+eOn1LL94UL1WqlKj/0qnanZt5DWP8IbqbKiAwBJyIoj7he/DzO+3N?=
 =?us-ascii?q?QZm3kIMk5FdQqag4XmNFzCOvD1Aeqlj1iynzpn2erKMqD5DpXINHfDkbPhfb?=
 =?us-ascii?q?hn605bzQo+1ctf6I9PCrwaPPLyWlP+tNzfDhMjNQy02PzoBM9y1oMZR2KDGr?=
 =?us-ascii?q?WZP7/KsV+U+uIvJPGBZIkTuDb+MPUl6PnujXg2mV8ZY6alx4cYaHe9Hv5+OU?=
 =?us-ascii?q?WWfWLsgssdEWcNpgc+V/LliFmDUT5VenazULkx5i80CI24F4fPXIOtj6Kb3C?=
 =?us-ascii?q?e9AJJWYnpKCleWEXfnb4+EQesDaDqOIs99lTwJTaKhS4492hGurgD60adoIf?=
 =?us-ascii?q?LI9SIAtZLsztl15+vNmhEp7jF7FNid02CLT2FogGwIXTk2075joUBn1liD1q?=
 =?us-ascii?q?140LRkEol15vhKGiQgPJrR0e1xC5imXATCVtiOT1miT5OtBjRnCpoqztsPZV?=
 =?us-ascii?q?ttM8utgwqF3CewBbIR0buRC9h8yKPX33HrK45dwnfA2bJp20MnSctGL2GRjZ?=
 =?us-ascii?q?l//gnVCpXhmVmYkbqnb6IRwGjG82LVnkSUu0QNaxJ9SaXIWzgkY0LSqdnorh?=
 =?us-ascii?q?fZQ6SGFaUsMgwHz9WLbKRNdIu63h19WP7/NYGGMCqKkGCqCEPNn+jdYQ=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2CbBQCou0Je/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBbSASKoQViQOGaAEBAQaBEiWJcJB0A1QJAQEBAQEBAQEBNwEBhEACgms4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ0IWAYFiKQGDAgEFIw8BBVEJAg4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JXJY8wm3mBMokAgT6BDioBjDx5gQeBOAwDgl0+h1uCPCIEl?=
 =?us-ascii?q?l+BKZdqgkSCTpN4BgIZmw8tjjedNiI3gSErCAIYCCEPgydQGA2OKAEXjkEjA?=
 =?us-ascii?q?zCLC4NdAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Feb 2020 14:52:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BEpIQb171888;
        Tue, 11 Feb 2020 09:51:19 -0500
Subject: Re: [PATCH] label_file.c: Fix MAC build
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Nick Kralevich <nnk@google.com>, selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20200207230032.210843-1-nnk@google.com>
 <92a60e95-f304-5361-82dc-89a3c3590962@tycho.nsa.gov>
Message-ID: <19856785-351e-6b74-13ad-f0f40ae1755a@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 09:53:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <92a60e95-f304-5361-82dc-89a3c3590962@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 3:49 PM, Stephen Smalley wrote:
> On 2/7/20 6:00 PM, Nick Kralevich wrote:
>> On Android, the label_file.c file is compiled for all platforms,
>> including OSX. OSX has a slightly different prototype for the
>> getxattr function.
>>
>> ssize_t getxattr(const char *path, const char *name, void *value, 
>> size_t size, u_int32_t position, int options);
>>
>> which causes a compile error when compiling libselinux on OSX.
>>
>>    ```
>>    external/selinux/libselinux/src/label_file.c:1038:37: error: too 
>> few arguments to function call, expected 6, have 4
>>                                         read_digest, SHA1_HASH_SIZE);
>>                                                                  ^
>>    
>> /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/sys/xattr.h:61:1: 
>> note: 'getxattr' declared here
>>    ssize_t getxattr(const char *path, const char *name, void *value, 
>> size_t size, u_int32_t position, int options);
>>    ^
>>    1 error generated.
>>    ```
>>
>> On OSX builds, add the additional arguments so that the code compiles.
>>
>> As both SELinux labels and the restorecon partial digest are stored in
>> extended attributes, it's theoretically possible that someone
>> could assign SELinux labels and hash digests on OSX filesystems.
>> Doing so would be extremely weird and completely untested, but
>> theoretically possible.
>>
>> Signed-off-by: Nick Kralevich <nnk@google.com>
> 
> Wondering why the getxattr() call isn't done in the selinux_restorecon 
> code instead, or why this is needed as a separate selabel_ interface at 
> all. Probably too late though to change it though without breaking API/ABI.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

This is now applied.  Unless there is a real reason to export it outside 
libselinux, we may wish to remove 
selabel_get_digests_all_partial_matches() from label.h and the man 
pages, drop the sample util, possibly add a selinux_log() deprecation 
warning to the selabel_get_digests_all_partial_matches() function to 
discourage any further use, and switch selinux_restorecon over to using 
its own private copy of the same logic.  Then maybe someday we can drop 
it, but that would technically be an ABI break even if there are no 
other users beyond the sample util.
