Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CCCC432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 18:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC02075C
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 18:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EiR0Dyyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKZS1r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:27:47 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:37044 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKZS1r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 13:27:47 -0500
X-EEMSG-check-017: 54815687|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="54815687"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Nov 2019 18:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574792859; x=1606328859;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Va5Mh/XuUVYNd3CXgntbKH8d9V5T6SlI55cvrlW7wqc=;
  b=EiR0Dyyzf9ziYEnVGcAP2A1hIu07OurgSYCdvBGrM5jAymxdJXPkR4F4
   wCO9ZsEF5WJNjyLALZwyc9rtyQAaG4kUeATUKARY29YpSPJpNJzkemxoi
   zejNJB/MKn5KEnzfVnNXyUKOZVRT6sc+fmo9IOVqmjMjVotXoDE1wqwuE
   iRaW8Ki0scPkuk58sVDwaM2i2toRd2Xr+B8YH+5SLJwkRXP7zr+EGIYsH
   3WNea0LUNI/JjlsMpL30GwJibNLDwbZ/EXzYMYbNkvXWgm2AqsTnQBbw6
   WwT6eLHbjEB9iar64bkI9VCA33q825HbVoQVyc6/U1c6qqXMtDFbXGr/s
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="36043283"
IronPort-PHdr: =?us-ascii?q?9a23=3AuICNqhE3ae/3yDIF6ANWFZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zoMmwAkXT6L1XgUPTWs2DsrQY0rGQ6v67EjVZvd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu8gYjIdtN6o91x?=
 =?us-ascii?q?TEqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk/m7XkMhwh79FrhynqRJ03orYbJiVOfd6e6/Qe84RS2?=
 =?us-ascii?q?hcUcZLTyFPH52yb4UPAeQCM+hXoYbyqFkSohWxHgSsGOHixyVUinPq06A30e?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZosjpNKgMSeC1zLfHzTPeZP1L3Dfy8ozIchQ/rvCMQL?=
 =?us-ascii?q?l9dtHRxlQ0Fw7eklWRqZDqPzOS1ugXtWib9PBvWfigi24gtQF8uz6izdovhI?=
 =?us-ascii?q?nRno8Z11/J+CpjzIs1ONG0UlB3bNG6HJdKqi2XMZZ9TNk4TGFyoik6z6ULuZ?=
 =?us-ascii?q?u8fCcX1psq3wXfa/mbc4iQ5RLjSfqRLS94hH17fLK/gA6/8VS6xe3mV8m0zU?=
 =?us-ascii?q?1KojBEktnKuHAN0AfT5dabRfdn4keg2SqA1wDU6u1eJ0A7ibHbJII7zr41l5?=
 =?us-ascii?q?oTtVzPHi7wmErokK+bblgo9+en5uj9Yrjqu4WQO5F7hw3gKKgih9SzAeEiPQ?=
 =?us-ascii?q?gPW2ib9/681Lrm/UDhW7VFk+Y2n7LFsJHaOcsbpqm5DxVT0oY48RmzFTim0N?=
 =?us-ascii?q?MGnXUfNlJKZAqHj5T1O1HJOP34Fumwg1CtkDdt2vDHMabsAovCLnfdirftZ7?=
 =?us-ascii?q?V95FBGyAo1099f44hYCrYbIPL8QkXxrsDXDgclMwyoxObqEMhy2ZkCVm6VBa?=
 =?us-ascii?q?+ZLr3dsUWS5uIuPuaDepQYuDn4K/c/5v7uiWU1lkMafamsjtMrbyWjE/BnJV?=
 =?us-ascii?q?iJSWTjj81HEmoQuAc6CuvwhxnKfTlWZnCzVKF0ySs6Bp7uWYvKTcaqnrGbxi?=
 =?us-ascii?q?a3E7VZY2lHDhaHFnK+JKueXPJZUz6fOs9slHQ/ULGlT4IwnUW1uBTS16tsLu?=
 =?us-ascii?q?2S/DYR853kyo4mtKXoiRgu+GksXIym2GaXQjQxwzIF?=
X-IPAS-Result: =?us-ascii?q?A2D0AAC4bd1d/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEoRViQOGUwEBAQEBAQaBEiWJaY9dgWcJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgho4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJvAQUjFVELGAICJgICVwYBD?=
 =?us-ascii?q?AgBAYJfP4JTJbMggTKFT4M/gUiBDiiBEoseeIEHgREnDAOCXT6EMYMogl4Ej?=
 =?us-ascii?q?QRUiQpGh1uOQm+CNoI5kxcGG5EGiReOSJcPhRQigVgrCAIYCCEPgyhPERSVL?=
 =?us-ascii?q?CMDkB8BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Nov 2019 18:27:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAQIRZCU197947;
        Tue, 26 Nov 2019 13:27:36 -0500
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>
References: <20191123144245.3079306-1-dac.override@gmail.com>
 <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
 <20191125141035.GB441967@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fe0d0ffe-a96a-9438-76f2-7759a41b823c@tycho.nsa.gov>
Date:   Tue, 26 Nov 2019 13:27:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125141035.GB441967@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/25/19 9:10 AM, Dominick Grift wrote:
> On Mon, Nov 25, 2019 at 08:24:21AM -0500, Stephen Smalley wrote:
>> On 11/23/19 9:42 AM, Dominick Grift wrote:
>>> In 2008 support for UserPrefix was removed from Reference policy.
>>> The code to support this functionality in libsepol and libsemanage however remained albeit slightly modified.
>>> I am not sure why it was not fully removed.
>>>
>>> DefaultRole replaces UserPrefix functionality but the code in libsepol and libsemanage was only slighty adjusted to accomodate my use-case.
>>> This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016).
>>> I do not use semanage and I do not mind using the old UserPrefix statement, but there is some confusion.
>>> For example there was a report recently about how semanage does not document UserPrefix.
>>> The documentation was likely removed from view because UserPrefix is no longer supported as such.
>>>
>>> I want to make the situation better and this proposal is the next phase.
>>> This proposal causes some disruption as Reference policy based policy often calls the gen_user() macro with the "user" prefix.
>>>
>>> Example: gen_user(user_u, user, user_r, s0, s0)
>>>
>>> This will no longer be valid, and the userprefix parameter in gen_user() can be left empty (or needs a valid role if RBACSEP DefaultRole is leveraged).
>>>
>>> Example: gen_user(user_u,, user_r, s0, s0)
>>>
>>> UserPrefix will now default to object_r. This should not affect common policy implementations.
>>>
>>> The next phases will be:
>>>
>>> Renaming the UserPrefix statement to UserRBACSEPRole, and renaming references to (user)?prefix to (user)?rbacseprole.
>>> Adjusting semanage to expose UserRBACSEPRole.
>>> Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from libsemanage.
>>>
>>> After this the UserPrefix to UserRBACSEPRole transition should be completed.
>>>
>>> This should get us by until someone decides to rewrite libsemanage to take advantage of CIL, simplify the code, and to make the code more robust.
>>
>> I guess my only question with regard to this phase and the next ones is with
>> regard to backward compatibility.  Even if no one is using this facility, we
>> have to make sure we do not break existing installs upon upgrade.
> 
> Maybe we can duplicate the code instead. That way we would not have to touch the existing, but dead userprefix code.
> That should address any compatibility issues.

At a minimum, we must avoid breaking existing installs upon upgrade, and 
we must avoid breaking compilation of existing policy modules (both 
refpolicy and CIL).

A simple test would be ensuring that if you upgrade the userspace and 
run semodule -B with your previously installed policy (including its 
existing userprefix statements), there are no errors and you get the 
same file_contexts.homedirs as you had before.

That should be relatively easy to ensure for targeted policy.  Might be 
more complicated with your policy, the CLIP policy, or perhaps others.

> 
>>
>>>
>>> Dominick Grift (3):
>>>     libsemanage: fall back to valid "object_r" role instead of "user"
>>>       prefix string
>>>     semanage: do not default prefix to "user"
>>>     cil: qualify roles from symtable when resolving userprefix
>>>
>>>    libsemanage/src/genhomedircon.c    |  2 +-
>>>    libsemanage/src/user_record.c      |  4 ++--
>>>    libsepol/cil/src/cil.c             |  7 +++++--
>>>    libsepol/cil/src/cil_internal.h    |  1 +
>>>    libsepol/cil/src/cil_resolve_ast.c | 10 ++++------
>>>    python/semanage/semanage           |  2 +-
>>>    6 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>
> 

