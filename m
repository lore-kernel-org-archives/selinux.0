Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3FEC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 15:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0EF21655
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 15:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XxNLG1Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSPAQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:00:16 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:29209 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSPAP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 10:00:15 -0500
X-EEMSG-check-017: 62521956|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="62521956"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2019 15:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576767612; x=1608303612;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/Ffh1AJ9LOJWy99fR3IJpAT44/PQk6jsOKYgrHPx2j8=;
  b=XxNLG1MaDxAKHe00erGEdVmnsyQ+0TUneDbkK9gz5aAkcIVbWAf4i6xc
   HpWkdSkepTxfUS8fDA4VW4vG6Rz896Uv2gRo+mE/+/TWn3mMIgxnqW4S7
   SWIyuj7qA6Vjm2f9/v37HCOje/OheMKde5c9D6kp4EvDXMHVAWsBNT2ED
   Xt4jIVyquBvqXxzC3OEzQebae73iiDy++LyoV1HZC3WHHNRlqXH0vyFI/
   jZoRqaq4AMcD5PXxG8Yx3Fu2UAVf2F0ocg1Tjh+ZCyiPuPLQcLpFfCZnj
   WUg/Y0PoTVUivrIhd8hUuy9185qUtWoveodBzIf3oPjNjm0YiFBdjP15a
   w==;
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="36965890"
IronPort-PHdr: =?us-ascii?q?9a23=3AKOM0FhRe/eR132p7Eqv7dFJsytpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBSPt8tkgFKBZ4jH8fUM07OQ7/m7HzZZuN3f4TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZZ/Jqo+yx?=
 =?us-ascii?q?bEpmZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0gw+EdIAs3raotv6O6gQXu+pw6fF1inDYvBM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqoBIPfvVU/vr9HXEhg5Mwiww+n9E9p90ZkeVniVDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuA56PH0ln82h18ccLKy3ZQLaHC3BOlmI0?=
 =?us-ascii?q?udYXXymNcNCHsFsRAkQOP2j12CVCZZZ2yuUKIk+jE7FIWmAJ/fSY+3m7yOwi?=
 =?us-ascii?q?e6EodNZm9aClCDC2rod4uAW/gSciKfOc5hkjoYVbe/T48tzw2htAj/y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTlxQy9TtuD8SH0mGNVHp5nmUSSD8zwq9/oFZxylCZ0a?=
 =?us-ascii?q?h3m/ZYD8Bc5+tVUgcmMp7R1+h6C9H0WgLccdaFUU2mTcu6DjEsVNIxwsMOYk?=
 =?us-ascii?q?ZkF9WniRDMwjeqA7sLmLGQGpw0/bzT32LrK8Z+1XnGzq8hgEciQsdVMm2mnK?=
 =?us-ascii?q?F//RDJB4HVi0WZi7qqdaME0S7W6miDyWuOvEdFUA9/SqjFQ38faVXMrdjj5U?=
 =?us-ascii?q?PNUaWuCbI5PQtF08KCLbFKatLxh1VcWPjjIMjeY362m2qoBhaH2K2DbJH2dG?=
 =?us-ascii?q?Ua2yXdC1MJnBwT/XacMgg+Ayaho3/bDDB0ElLveUzs+/FkqHynVk800x2Kb0?=
 =?us-ascii?q?p52rq3/R4VhfqcR+kR3rIDuCcusTN0HE2j0NLQENePuxBufKNbYdM74VdIyX?=
 =?us-ascii?q?jWtwhnMpO8KKBig0YUcx5rsEP2yxV3FoJAnNAyrHw0ygpyJr+Y0FJHdz+B3p?=
 =?us-ascii?q?D/JKfXKm/s8xCrcKPW20jS0NKR+qcR9vs0sU7jsxuqFko/6XVoycNZ032C6Z?=
 =?us-ascii?q?nQDgoSSYr7Ulwr+Bhiu7Hafi496pvM1XJ2LKm0tiTP28ozC+s4zhasZtJfMK?=
 =?us-ascii?q?SDFA/oDcIWHdShKOsvmwvhUhVRB+FX86h8GsiYduea2aPjaP1llyyOhmND5I?=
 =?us-ascii?q?l31ViFsSF7T7ib8YwCxqSjwgafVzr6xGyku8TzlJEMMSoeBUKj2CPkA8hXfa?=
 =?us-ascii?q?Q0coEVXzT9a/arz8lz0sa+E0VT80SuUhZfhZ6k?=
X-IPAS-Result: =?us-ascii?q?A2B9AgBMj/td/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXyBd?=
 =?us-ascii?q?oFsASAShDCJA4ZcBoESJYEBiGuRRQkBAQEBAQEBAQE3AQGEQAKCQDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIw8BBTYLEAkCGAICJgICVwYNC?=
 =?us-ascii?q?AEBFYJKP4JTBSCRBJp/dYEyiRKBPYEOKIwzeYEHgREnDAOCKDU+h1mCXgSNH?=
 =?us-ascii?q?lOJZJc2gj6CRIopiSUGAhmaUS2rBiKBWCsIAhgIIQ87gm1PGA2NGwIBF45BI?=
 =?us-ascii?q?wORRgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Dec 2019 15:00:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBJExgpa149777;
        Thu, 19 Dec 2019 09:59:44 -0500
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
From:   Stephen Smalley <sds@tycho.nsa.gov>
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
 <55b5c889-ff38-38c4-578e-ec4211b837a4@tycho.nsa.gov>
Message-ID: <93912039-e64e-cc56-20fc-095accf6c4dd@tycho.nsa.gov>
Date:   Thu, 19 Dec 2019 10:00:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <55b5c889-ff38-38c4-578e-ec4211b837a4@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/19 8:47 AM, Stephen Smalley wrote:
> On 12/19/19 7:19 AM, Simon McVittie wrote:
>> On Wed, 18 Dec 2019 at 15:50:45 -0500, Stephen Smalley wrote:
>>> Ok, this seems to be a lack of support in AppArmor for saving the 
>>> peer info
>>> for unix/local domain sockets, so not your bug.  Doesn't implement the
>>> necessary hooks.
>>
>> Ubuntu kernels have working getsockopt SO_PEERSEC for AppArmor (which
>> definitely works for D-Bus, or did when I tried it in the past), but it
>> seems to be a downstream patch.
>>
>> Is there a combination of LSMs where this works correctly and shows
>> multiple LSMs' labels, either upstream or with downstream patches? D-Bus
>> ought to be an early consumer of this information, but that's going to
>> be difficult if there's nowhere I can test it. If there was a pair of
>> in-tree or out-of-tree test LSMs that automatically labelled process
>> 12345 and all sockets that it created with something like (pseudocode)
>>
>> {
>>    "labeltest1": "labeltest1process12345",
>>    "labeltest2": "labeltest2process12345"
>> }
>>
>> then that would make testing straightforward.
> 
> AFAICT, you can't yet stack Smack+SELinux, and AppArmor requires 
> out-of-tree patches to support SO_PEERSEC so there is no in-tree 
> combination that will demonstrate the new SO_PEERCONTEXT for multiple lsms.
> 
>>  From my user-space developer perspective, I'd really like the kernel
>> to have at least brief documentation of the assumptions that can be
>> made about the compound format, to avoid people like me having to
>> ask the linux-security-module mailing list and use the answers as our
>> documentation:
>>
>> - Can I assume that the LSM names (conceptually, keys in the associative
>>    array) are printable ASCII? If not, can I at least assume that they 
>> are
>>    printable UTF-8, or that LSMs whose names are not printable UTF-8 are
>>    too weird to be worth supporting in user-space APIs?
>>
>>    If this decision hasn't been made yet, I would like to request ASCII,
>>    or UTF-8 if a wider character repertoire is desired - that would make
>>    user-space APIs a lot easier to write.
> 
> ASCII works for me.
> 
>>
>> - What can I assume about the format of the labels (values in the
>>    associative array)?
>>
>>    From previous conversations on linux-security-module it seems the
>>    answer is: they are intended to be printable strings; their encoding
>>    is unspecified (could be ASCII or UTF-8, but equally could be Latin-1
>>    or anything else); there are no reserved or disallowed characters
>>    except '\0'; individual LSMs like SELinux and AppArmor might impose
>>    tighter restrictions, but LSM-agnostic code can't assume those
>>    restrictions are present.
>>
>>    Even if the format is conceptually an unspecified encoding with every
>>    nonzero byte allowed, if LSM and security policy authors establish a
>>    convention that the labels are ASCII or UTF-8 without control 
>> characters
>>    such as newlines, that would make user-space a lot easier to deal 
>> with.
> 
> I believe there is existing userspace code that seems to presume that 
> they are NUL-terminated strings printable using %s format specifiers to 
> printf-like functions in output and log messages _without_ any escaping. 
>   Not just the LSM-specific libraries. systemd (for SO_PEERSEC), 
> procps-ng (for /proc/pid/attr/current), perhaps others.  I think we can 
> rely on that remaining true since the world would break.

Looks like userspace is generally forgiving of whether the terminating 
NUL byte is included or omitted by the kernel (with different behaviors 
for SELinux - always included, Smack - omitted by /proc/pid/attr/current 
but included in SO_PEERSEC, and AppArmor - omitted for 
/proc/pid/attr/current but includes a terminating \n, omitted for 
SO_PEERSEC but no terminating \n), and procps-ng explicitly tests for 
printable characters (but truncates on the first unprintable character). 
If we want consistency for /proc/pid/attr/context and SO_PEERCONTEXT, 
we'd need different hooks for one or both of them; the current stacking 
patches just internally use the existing hooks with their current 
behaviors for current and SO_PEERSEC and then compose them.

> 
>> - Can I assume that the names and labels in /proc/$pid/attr/context
>>    correspond exactly (same label <=> same bytes) to the ones in
>>    SO_PEERCONTEXT?
>>
>>    In particular, a design issue in the previous interfaces with
>>    /proc/$pid/attr/current and SO_PEERSEC was that AppArmor puts
>>    "unconfined\n" in /proc/$pid/attr/current, but "unconfined\0" in
>>    SO_PEERSEC, and implementations of protocols like D-Bus can't know
>>    that these are meant to be the same without LSM-specific knowledge
>>    (namely "AppArmor profile names can't contain newlines").
>>
>>    If this new API is an opportunity to declare that LSMs are expected
>>    to put the same canonical form of a label in 
>> /proc/$pid/attr/context and
>>    SO_PEERCONTEXT, possibly with a non-canonical version (adding '\n' or
>>    '\0' or similar) exposed in the older /proc/$pid/attr/current and
>>    SO_PEERSEC interfaces for backwards compatibility, then that would 
>> make
>>    life a lot easier for user-space developers like me.
> 
> I'm all for this but the current implementation reuses the same 
> underlying hooks as SO_PEERSEC, so it gets the same result for the 
> per-lsm values.  We'd need a separate hook if we cannot alter the 
> current AppArmor SO_PEERSEC format.  Technically AppArmor seemingly 
> doesn't truly provide SO_PEERSEC in mainline today even though it 
> implements the hook for returning the result because it never actually 
> sets the peer on Unix domain or INET domain connections AFAICT, so they 
> could change the format upstream without a compatibility break but it 
> may break Ubuntu.  So it might require using a new hook for 
> SO_PEERCONTEXT.  Which is fine with me.
> 
>> - Does the order of the names and values matter? Can I assume anything
>>    about them?
>>
>>    It would make the D-Bus API more straightforward if I can assume that
>>    the order doesn't matter, and represent it as an unordered map
>>    (associative array), like a Perl hash or Python dict.
> 
> IMHO order shouldn't matter.
> 
>> I'm asking all this from the D-Bus perspective, but anything that
>> wants to store or forward LSM contexts in an LSM-agnostic way will
>> have essentially the same requirements - I could imagine X11, Wayland,
>> varlink etc. hitting the same problems D-Bus did.
>>
>> Thanks,
>>      smcv
>>
> 

