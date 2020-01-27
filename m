Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049EC2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A7205F4
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 13:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gCpyd9q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgA0N5g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:57:36 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:63588 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0N5f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 08:57:35 -0500
X-EEMSG-check-017: 73661413|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="73661413"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Jan 2020 13:57:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580133453; x=1611669453;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=X+GiMV4T1EUL+ugrkpuDcREUue+kt2E08JG6HEPobZg=;
  b=gCpyd9q+lstLRfhkx5qVUD4k+2YIEGXtPOxSG/Uu6dmEyOoyD1Ev/xyU
   mUYiSWerexuY5MCb1vox7jc4LKYD9mmWTLtu28/0MuDQ5APipugp+6oDA
   LS9mhVdaOIF02UizYS2mjR1pgeDoiZoq3rpDFYKb3M+ujDynn7ZMk0VLe
   zqrDmd06yNx505glk2UeRj1XN1L4z+MQeepsvZ5/7WI+ex8jniJj8WinH
   14iyKqQxjC4YR/zhNxSGceMLW84NAYQ9iexo/aS8vEQuAh/RbCYyIj6Be
   COtaHMfsFOHZKro7ZLI4PUU78Mmq9OR3gBdwzC5IComFIyT4ERlCB/TF9
   w==;
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="38276318"
IronPort-PHdr: =?us-ascii?q?9a23=3AgqwoVhCVyGU9+cqZby7yUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37oM6wAkXT6L1XgUPTWs2DsrQY0raQ6PqrBDJIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw/xx?=
 =?us-ascii?q?fXrXdFe+Vbzn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHH53bc+0+?=
 =?us-ascii?q?88Dw/I2gIuFM8KvHjNotj4MKIeXOaox6fK0DrDdetb1yrj5ojGch4vov+CUr?=
 =?us-ascii?q?x/fsXT1UYhGBjIjkmSpIH/Iz+ZyuoAvmqd4uF9VeyvkWknqwRprzay2scjlJ?=
 =?us-ascii?q?HJhoILxVDC6C533YM1Kse8SE5/f9GlEIZbuiaBN4RrWcMvWH1ouSYmxb0Gvp?=
 =?us-ascii?q?63Zi4KyI89yBLFZPyHdJaI7wvlWe2MLzl4g3dld6i+hxa06UWgxez8VtW00F?=
 =?us-ascii?q?ZXtSVJiMXDtncI1xHV98OJSeN981+81TuA2A3f8OFJLV0umabFJJMt3KQ8mo?=
 =?us-ascii?q?cVvE/eBCH5gl/2g7WTdkg8/+io7Pnobav+q5+HMo90lhn+MqMzmsyjGeg4Mh?=
 =?us-ascii?q?YBX2yc+emkyL3s51f5QLRXjv0tiKXZsZbaJcocpq6iHQBazpwv6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFRZdxKck4flIVTOIPH8DfunglSslilkx+zeM7H8DZjAIWLPnbf8cb?=
 =?us-ascii?q?pn9UJRxxQ/wcpC655MD7EOOvPzWkv/tNzCCR85NhS5w/36B9VmzY4eRWKODb?=
 =?us-ascii?q?OZMKPVq1OI4PkvLPOWaI8avzb9NeAp5+Tygn8hhV8dYa6p0IMPaHC8BPtmPl?=
 =?us-ascii?q?mZYWD3jdgbCmoKpBQxQ/HqiFKYTT5ffWq9X6U55jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q7BYNZZmRHClCKDHfpeJ6JW+kDaC2MOM9tiD8EWqa7S48nyx6usBX2y719Lu?=
 =?us-ascii?q?rb4icYr47s1MBp5+3PkhE/7SR0ANqG3G6TSWF0n38IRzgt0aB+v0Ny1EmM3b?=
 =?us-ascii?q?J/g/xCGtwAr89OBz83KYSU6+VnF8r4UwnBNoORTF+7Xs+sCBkrQ94xysNIaE?=
 =?us-ascii?q?F4TZHqlR3H3iy3E5cLmLGRQp856KTR2z72Pck5gzzt1LMglEUhWstCLyWEwO?=
 =?us-ascii?q?ZH+iLeAY/VlA/Rw76nf6ka3TLK3GaOwGfIu1tXBl1eS6LACEsDa1PWoNKx3U?=
 =?us-ascii?q?bLS7ujGPxzKQda4dKTIatNLNvyhBNJQ+m1a4eWWH64h2rlXUXA/biLdoe/Pj?=
 =?us-ascii?q?xGjSg=3D?=
X-IPAS-Result: =?us-ascii?q?A2CPBABP6y5e/wHyM5BmHQEBAQkBEQUFAYF7gX2BGFUgE?=
 =?us-ascii?q?iqEFIkDhnsGgRIliW+RSQkBAQEBAQEBAQEtCgEBhEACgkg4EwIQAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFNwyCOykBgnoBBSMVLyILDgoCAiYCAlcGAQwGAgEBgmM/AYJWJ?=
 =?us-ascii?q?Q+rPYEyhDUBgRSDNoE4BoEOKow4eYEHgTgMA4JdPoJkAgKBS4Mmgl4ElzRGl?=
 =?us-ascii?q?16CQ4JMhHaObwYbmnyOYIhklDoigVgrCAIYCCEPgycTPRgNk3gXFYM7inEjA?=
 =?us-ascii?q?zCOAgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Jan 2020 13:57:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00RDujKW192438;
        Mon, 27 Jan 2020 08:56:48 -0500
Subject: Re: [PATCH v4] libsepol, checkpolicy: remove use of hardcoded
 security class values
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        "Christopher J. PeBenito" <pebenito@ieee.org>
References: <20200121184017.18084-1-sds@tycho.nsa.gov>
 <pjdeevmzdqq.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0acce760-fce8-3744-cea7-b6d4249ea754@tycho.nsa.gov>
Date:   Mon, 27 Jan 2020 08:58:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <pjdeevmzdqq.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/26/20 5:57 AM, Petr Lautrbach wrote:
> 
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> libsepol carried its own (outdated) copy of flask.h with the generated
>> security class and initial SID values for use by the policy
>> compiler and the forked copy of the security server code
>> leveraged by tools such as audit2why.  Convert libsepol and
>> checkpolicy entirely to looking up class values from the policy,
>> remove the SECCLASS_* definitions from its flask.h header, and move
>> the header with its remaining initial SID definitions private to
>> libsepol.  While we are here, fix the sepol_compute_sid() logic to
>> properly support features long since added to the policy and kernel,
>> although there are no users of it other than checkpolicy -d (debug)
>> and it is not exported to users of the shared library.  There
>> are still some residual differences between the kernel logic and
>> libsepol.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> 
> The only problem I found running tests on this is related to SETools
> https://github.com/SELinuxProject/selinux/pull/200#issuecomment-577745225
> 
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks.  I guess the question is whether we should wait to merge it 
until setools has a corresponding fix ready or go ahead.

