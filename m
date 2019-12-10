Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1151C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 20:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0BE2073B
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 20:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eqeJ4kXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJUii (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:38:38 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:23543 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLJUii (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 15:38:38 -0500
X-EEMSG-check-017: 55963376|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="55963376"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 20:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576010309; x=1607546309;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=lfO5we7wwpI8nN3wmHd46pWn9cMX7oBO0CHd+sPkDH8=;
  b=eqeJ4kXjQf7rlseOSWK9kKDy/SmOr41+wq9Ln6YkhgwGLtUK86in7KZ4
   ir7WP5ubmgbEQfZ/TXJJKYjLZFh3SkVCCblVnUOepam1Bds/6Y9nFixDA
   9UYB2MsdyKdweCiQ4EDFZY0kqo1ITxJo64Bhqzzi3YJfF8Fx95RmiU6od
   A9dM8KWG4Of1sfuCWZ6dqnY0lGjs9153dy0Xec2sal++xUjQzhqG83mrt
   eA2AbIQK7kC8oLYABFrRDNSqR84tLlIHALpZDPh9bEB5vbNxHSwqgBnNn
   8oHXPZq4HWDw2KmA4R6tJG+AZai+hq/Q3eP2Sy038GrpHzQ9TFK0kCAt7
   g==;
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="36574530"
IronPort-PHdr: =?us-ascii?q?9a23=3ApcPdih17nUxBxqmTsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMWLPad9pjvdHbS+e9qxAeQG9mCsLQd2rGd6vu/EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7qQvcusYLjYZsKKs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzoJOD4j9GHcl9J+gqRVrhm8oxBz2pDYbYWQOPd4Y6jTf84VRX?=
 =?us-ascii?q?BZU8hMSSJBDIOyYYgBAeUPMulXrZXyqVQVoBuiBwShHv/jxiNGi3L026Axzu?=
 =?us-ascii?q?QvERvB3AwlB98ArWjUo8vtNKcST++1yrTDwyjGb/xM3Tf97JbHcxA8qvyLRr?=
 =?us-ascii?q?J/bNHRxFIzFwLFklqQqYvlMymT1uQWqWeX9eVgVeWxi2M+rQx6vzahxsApio?=
 =?us-ascii?q?bTh4IVzEjJ9Sp4wIYpJd24VVV0bcS4H5tXsiGXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcrz9Bf4IlUCrEFIP3pXE/+qcfVDhA8MwOuwubnDM9x2Z8ZWWKKGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfJQVtyj5K/gk4f7ukHA4lEQDfammw5QXcmq0Hvd4LE?=
 =?us-ascii?q?WDZ3rjnNMBHX0NvgokQ+y5wGGFBBxUfHavVuoH7TE+CY6iDoDNS5rl1L6Gxy?=
 =?us-ascii?q?e/F5taTm9DA1GIV3zvctPAE+wBbCOUP99JjDMJT/6iRpUn2BXosxX1mJR9Ke?=
 =?us-ascii?q?+BwTEVrZLu0pBO4uTXkRwjvWhvA9+1z3CGT2YymHgBATAxwvYs8gRG1l6f3P?=
 =?us-ascii?q?0g0LRjHttJ6qYMCFY3?=
X-IPAS-Result: =?us-ascii?q?A2A+AABMAfBd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBbQMBAQELAYFzgRhVIBIqhAOJA4ZwBoESJYlpkUYJAQEBAQEBAQEBKwwBA?=
 =?us-ascii?q?YN7RQKCJzcGDgIQAQEBBAEBAQEBBQMBAWyFNwyCOymCewEFIxVRCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfPwGCUiUPrnSBMoQ6AYEUg0SBSIEOKAGMMXmBB4E4DAOCX?=
 =?us-ascii?q?T6BF4FNAoEsg0eCXgSWfEaXIoI5gjuEaI5HBhuDNpcCjFqBcIhFk3wjgVgrC?=
 =?us-ascii?q?AIYCCEPgycJRxEUjHIXg1CFZYUMIwMwjHWCQQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Dec 2019 20:38:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAKcFhA163853;
        Tue, 10 Dec 2019 15:38:15 -0500
Subject: Re: [PATCH] python/semanage: check variable type of port before
 trying to split
To:     Joshua Schmidlkofer <joshland@gmail.com>, selinux@vger.kernel.org
References: <CAHduLLQV07RPLcV-3ffaebEosQS_DRAk_7ZconHbdkx8oAHejQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ef5d3b3d-5f6f-7f74-0409-9425bfd9b7af@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 15:38:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHduLLQV07RPLcV-3ffaebEosQS_DRAk_7ZconHbdkx8oAHejQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/6/19 7:17 PM, Joshua Schmidlkofer wrote:
> While using Ansible's Selinux module to manage ports, I discovered
> that numerical ports caused an unhandled exception in 'seobject.py'.
> This appears to be a bug, and I am proposing a fix which checks the
> type of the argument before operating on it.  This maintains the
> original functionality in the case of a string, and acts in the same
> fashion if you supply an integer.
> 
> I did not find any open bug report against the SELinux project. The
> downstream bug report is here:
> https://github.com/ansible/ansible/issues/60968
> 
> 
> Signed-off-by: Joshua Schmidlkofer <joshua@joshuainnovates.us>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   python/semanage/seobject.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index dc413ca5..0e9ce290 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1070,7 +1070,11 @@ class portRecords(semanageRecords):
>           if port == "":
>               raise ValueError(_("Port is required"))
> 
> -        ports = port.split("-")
> +        if isinstance(port, str):
> +            ports = port.split('-', 1)
> +        else:
> +            ports = (port,)
> +
>           if len(ports) == 1:
>               high = low = int(ports[0])
>           else:
> --
> 2.23.0
> 

