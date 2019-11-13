Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F66C43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DB6229F0
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BsgQ52MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKMPpi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:45:38 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:63879 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMPpi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 10:45:38 -0500
X-EEMSG-check-017: 26456361|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="26456361"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Nov 2019 15:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573659923; x=1605195923;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UKbmxcMN1JhbcbsDkcK6SxjFeP1CbBWcPKOso886gHY=;
  b=BsgQ52MBvurV5W4evO/T2k7eyUuzZVRrMb1jW59ScLdqg5NTkszDFK1d
   FS0oQzPsWwWMdkhVxeFisO6kVvjLHFq0JHqMtKmuMfNNcRML0Fo8+jAtB
   MNvlb9h9zwSxmHu7w9Hb/rjX1ubqKjDYUVlDrtPwCb0d2Aj6phk5jq7Gk
   vVGnq9c5+YTXaCiT43NsN2b2yXF4NCgoUg0TwPMR5x5bD48TLKhA/WODH
   3NNeVieDfw1T+SKTJP4ncuNMcJKsx1hKsjn9t1kBAcZwmLF0rmvkbWE61
   zNya0Z6S181kZTq475nL/9z0CCReboXpZ1oi1rGLJI7h44pgBtcmcC6Zo
   g==;
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="30054811"
IronPort-PHdr: =?us-ascii?q?9a23=3Avh6VvBM6Py9UjXU9aB8l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z6pcbcNUDSrc9gkEXOFd2Cra4d0KyP6PmrBj1IyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjfq8UajolvJ6IswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?ohDw/G0g8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIh3r4xmY?=
 =?us-ascii?q?YTsUTEBCP2nln5jLSKeUk+/+io6uDnbq3npp+aKYB0lhnzPrkhl8GwG+g1Mh?=
 =?us-ascii?q?UCU3KF9emzyrHv51D1TK1PjvIsk6nZtJ7aJd4cpq68GwJVyZss6w2kAje60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBlIjmIUvCIP//Dfehm1isiitkx+jaPr39BZXANn7DkLb9cr?=
 =?us-ascii?q?Z6705T0hEzwcpe55JTDbEBO+nzV1T0tNHXAR41KQu0w/zoCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/fwgI+2NZI8TpTb8JOMo5+DhjXAng18RZ6qp0oUNaHC+APtmJ1?=
 =?us-ascii?q?+VYX32gtcOCW0KpBYxTPT2iF2eVj5ef3OyX6M/5j4lE4+pF4PDRpypgLyA2i?=
 =?us-ascii?q?e7A5JXanpBClCWHnfib5+EVOsUaCKOPs9hlSQJVaClS4A7yBGuqBX6xKF9Ie?=
 =?us-ascii?q?fP4C0Xq4/s1Nhv6O3Pjx096Tt0D8HOm12KGkd1lWQMTiR+/ad4ulc1nlGC2q?=
 =?us-ascii?q?98iuceFNtU/OhhV1sqc5nGwLo+Q+vfXgPHY8fBTFe9Xp3yGjw1T9Qs0/cQbE?=
 =?us-ascii?q?tnXdavlBbO22ytGbBDxJKRA5lhyb7Rx3j8IY5Gzn/C0KQwxw09TtBnKXythq?=
 =?us-ascii?q?k58RPaQYHOjRPKxO6Raa0A0XuVpy+4xm2UsRQdCVUhXA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CMAgDgI8xd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CxsVAEyKoQpj2EGgTaJZoofhyQJAQEBAQEBAQEBIxEBAgEBhEACgiAkOBMCD?=
 =?us-ascii?q?gEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBIw8BBUEQCxgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYJSBSCvRnWBMokHgUiBDiiMFBh4gQeBOII2NT6BF4Y+gl4Ej?=
 =?us-ascii?q?R+Jd5YRBmiCMoI2hGGOKgYbgzCWTi2OGpwNIoFYKwgCGAghDzuCbAlHERSbX?=
 =?us-ascii?q?oQgIwMwgQUBAZBcAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Nov 2019 15:45:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xADFjJ2t020418;
        Wed, 13 Nov 2019 10:45:20 -0500
Subject: Re: [PATCH 2/3] libselinux, libsemanage: fix python_exception.i
 dependencies
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Michael Shigorin <mike@altlinux.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
 <20191111115315.1173097-2-nicolas.iooss@m4x.org>
 <bdf62121-254c-884c-f318-6f7f530cc006@tycho.nsa.gov>
 <CAJfZ7=nuaL0bcb3gWqtZF1ChxpPJjajAP98U73iym0zjiwM0QQ@mail.gmail.com>
 <38df93c8-c552-d4bc-29cb-6bcbc3de3840@tycho.nsa.gov>
Message-ID: <c3a73462-119a-18ef-abba-2d8bcca41391@tycho.nsa.gov>
Date:   Wed, 13 Nov 2019 10:45:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <38df93c8-c552-d4bc-29cb-6bcbc3de3840@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 9:53 AM, Stephen Smalley wrote:
> On 11/13/19 3:30 AM, Nicolas Iooss wrote:
>> On Tue, Nov 12, 2019 at 4:39 PM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>>
>>> On 11/11/19 6:53 AM, Nicolas Iooss wrote:
>>>> selinuxswig_python_exception.i and semanageswig_python_exception.i need
>>>> to be regenerated when either an input header file changes or
>>>> exception.sh changes. Add the missing items to the respective 
>>>> Makefiles.
>>>>
>>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>>
>>> Wondering if we ought to be passing the dependencies as arguments to
>>> exception.sh and having it use them rather than a hardcoded header file
>>> path, but regardless:
>>>
>>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>> I merged my three patches. Thanks for your review.
>>
>> In my humble opinion, I find it simpler not to pass any argument to
>> the script, users can regenerate the files by running exception.sh
>> directly.
>>
>> Nevertheless, when I wrote this patch, there is something that
>> surprised me. In libselinux, only functions in selinux.h are
>> considered when adding glue code to raise OSError from errno when a
>> function returns a negative value. Contrary to semanage.h, selinux.h
>> does not include every other libselinux headers. More precisely, "grep
>> '^extern int ' libselinux/include/selinux/*.h" shows some functions in
>> avc.h, label.h and restorecon.h that are not handled. For example
>> avc_netlink_open() documented in its manpage to return -1 and set
>> errno when an error occurs, but is not present in
>> selinuxswig_python_exception.i. Is this a bug?
>> If yes, fixing it requires changing the API of selinux Python module,
>> which could break some applications (a function would raise an
>> exception instead of returning -1).
> 
> Curiously selinuxswig.i #include's all (or at least many) of the selinux 
> headers in its %module selinux, whereas selinuxswig_python.i only 
> includes selinux.h as you note. I'm unclear on the history here. It 
> seems like a bug, but breaking API wouldn't be good either.

Sorry, I looked at the wrong thing (#include vs %include); selinuxswig.i 
%include's all of the headers, and selinuxswig_python.i %include's 
selinuxswig.i, so it pulls them all in.  So we are generating python 
bindings for all the interfaces but not generating exception handlers 
for them all.  That does seem to be a bug.

> 
> I also have doubts that it is a good idea to be exposing all of the 
> libselinux (or libsemanage) interfaces to python rather than a manually 
> curated list.  But pruning that back now would also be difficult.  We 
> could at least freeze the interface going forward and only add new 
> interfaces explicitly as needed/desired perhaps.
> 

