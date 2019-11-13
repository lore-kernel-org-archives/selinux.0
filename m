Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C8C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF06222C9
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="KpB0ZM9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfKMOxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:53:50 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:16890 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfKMOxu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 09:53:50 -0500
X-EEMSG-check-017: 50110776|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="50110776"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Nov 2019 14:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573656808; x=1605192808;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=S5D0m4CkEibctYYHI0fbY3CgEtJ5O7V76lwDEqai90E=;
  b=KpB0ZM9VZZCI+XD+jD8BS8YtQdVdniyrhLiLGhO/Qzg5xVVTfBrNHW8+
   u4jlbVGr7UMj0eBN4sb5oLUIjqZFRJ6EpVPEJErqNgqEA7KqydwWpN8+7
   yA2c/rKiaexxdU/5fLivltuOD6G7YiDIYgxGnSpwaar2gSgdAi3VaWVbO
   YmHsUlqvZo2KEykNxs14jOhSWsBefU5Q1aASiEZ4HoiJ95O3g9pGrDmNN
   byDmn4E6mLfcIQMbjjyUCgTcTo3JjR0Mfo4zYnfHPwzWBwDtyDJ9//8ZT
   /6qR02gJTswzKUWJKwQVhQAaXluk3wcJ3wmZwMQ6r0M49dOmRTk4unKZD
   w==;
X-IronPort-AV: E=Sophos;i="5.68,300,1569283200"; 
   d="scan'208";a="35453168"
IronPort-PHdr: =?us-ascii?q?9a23=3AdOouOB+ZplThXv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+sUIJqq85mqBkHD//Il1AaPAdyArasf0qGI4ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRuroQnet8QbhZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumarHK58u3r4wlp?=
 =?us-ascii?q?0JvUTFAiD2g1n5gLWTdkUl/uik8+XnYrP4qZ+AL4J4lw7zP6s0lsG/HOg0KB?=
 =?us-ascii?q?YCUmeF9eimybHv5Uj5T69Ljv0ynKnZqpfaJcEDq66iHgBVyZ0u6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFReeB2dlYTpNFbOIO7gAfeln1usiCtrx+zBPrD5BJXNL2TMkLDlfb?=
 =?us-ascii?q?ln8E5Q0gszzddY55JPEbEMO/fzV0D+tdDCCR85KQO0yf79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPJr1CI4uMvI++RZI4aozv9Nfcl6OD0jXMjml8SY7Op3Z0JZ3C8BPhmJF?=
 =?us-ascii?q?+ZYXX0iNcbDWgKphY+TPDtiFCaVD5TZnWyULwn6z4hDIKmEYPDRoGrgLyc0y?=
 =?us-ascii?q?a3BJpWZnpJClqUC3fna52EW+sQaCKVOsJhijgEWqK8S489zxGhrxX1xqF9Lu?=
 =?us-ascii?q?XK5yIYtYjs1MRv6+LPkhEy8G88M8PI9WCGSGV9hSspQDgtx+grp012zVOKyu?=
 =?us-ascii?q?55hPtDDvRWu+MPVR01Y9qU9MF+CtbvSkrFf8yVAAK9T9GnBywhZsw+zsVIYE?=
 =?us-ascii?q?tnHdimyBfZ0Hz5LaUSkumwGJEs8q/al0P0LsJ5xmeOgLItlHE6U8BPMiugna?=
 =?us-ascii?q?c5+A/NUd2a236FnrqnIPxPlBXG832OmC/X5xBV?=
X-IPAS-Result: =?us-ascii?q?A2CKAgDNFsxd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CxsVAEyKoQpj14GgTaJZoofhyQJAQEBAQEBAQEBIxEBAgEBhEACgiAkOBMCD?=
 =?us-ascii?q?gEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFUEQCxgCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYJSJbAfgTKFToM/gUiBDiiMFBh4gQeBOII2NT6BF4Y+gl4EjR+JMkWWE?=
 =?us-ascii?q?QZogjKCNoRhjioGG4Mwlk4tjhqcDSKBWCsIAhgIIQ87gmwJRxEUm16EICMDM?=
 =?us-ascii?q?IEFAQGQXAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Nov 2019 14:53:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xADErOM5001942;
        Wed, 13 Nov 2019 09:53:24 -0500
Subject: Re: [PATCH 2/3] libselinux, libsemanage: fix python_exception.i
 dependencies
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Michael Shigorin <mike@altlinux.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
 <20191111115315.1173097-2-nicolas.iooss@m4x.org>
 <bdf62121-254c-884c-f318-6f7f530cc006@tycho.nsa.gov>
 <CAJfZ7=nuaL0bcb3gWqtZF1ChxpPJjajAP98U73iym0zjiwM0QQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <38df93c8-c552-d4bc-29cb-6bcbc3de3840@tycho.nsa.gov>
Date:   Wed, 13 Nov 2019 09:53:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nuaL0bcb3gWqtZF1ChxpPJjajAP98U73iym0zjiwM0QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 3:30 AM, Nicolas Iooss wrote:
> On Tue, Nov 12, 2019 at 4:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 11/11/19 6:53 AM, Nicolas Iooss wrote:
>>> selinuxswig_python_exception.i and semanageswig_python_exception.i need
>>> to be regenerated when either an input header file changes or
>>> exception.sh changes. Add the missing items to the respective Makefiles.
>>>
>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>
>> Wondering if we ought to be passing the dependencies as arguments to
>> exception.sh and having it use them rather than a hardcoded header file
>> path, but regardless:
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> I merged my three patches. Thanks for your review.
> 
> In my humble opinion, I find it simpler not to pass any argument to
> the script, users can regenerate the files by running exception.sh
> directly.
> 
> Nevertheless, when I wrote this patch, there is something that
> surprised me. In libselinux, only functions in selinux.h are
> considered when adding glue code to raise OSError from errno when a
> function returns a negative value. Contrary to semanage.h, selinux.h
> does not include every other libselinux headers. More precisely, "grep
> '^extern int ' libselinux/include/selinux/*.h" shows some functions in
> avc.h, label.h and restorecon.h that are not handled. For example
> avc_netlink_open() documented in its manpage to return -1 and set
> errno when an error occurs, but is not present in
> selinuxswig_python_exception.i. Is this a bug?
> If yes, fixing it requires changing the API of selinux Python module,
> which could break some applications (a function would raise an
> exception instead of returning -1).

Curiously selinuxswig.i #include's all (or at least many) of the selinux 
headers in its %module selinux, whereas selinuxswig_python.i only 
includes selinux.h as you note. I'm unclear on the history here. It 
seems like a bug, but breaking API wouldn't be good either.

I also have doubts that it is a good idea to be exposing all of the 
libselinux (or libsemanage) interfaces to python rather than a manually 
curated list.  But pruning that back now would also be difficult.  We 
could at least freeze the interface going forward and only add new 
interfaces explicitly as needed/desired perhaps.

