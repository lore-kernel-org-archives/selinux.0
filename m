Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F7C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3652146E
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RCb8vO03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSRDp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:03:45 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:5450 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSRDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 12:03:45 -0500
X-EEMSG-check-017: 64310092|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="64310092"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2019 17:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576774950; x=1608310950;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f0M8p+/4HkboNoYVNalBPMjAeVgcX6NSLQDBKjTHl6c=;
  b=RCb8vO03Y4oNRkzntgtjp6AiR8EgirHRqv3UiL/lrQCKnVAtj3dzVa0Y
   I0LV6CxEc/9uigNl1T48ql18BlzcdWjY8oJTSDA+0QS/E31LbP/KjorFw
   BZpKtWHqhX1/tvB5wuDKYNcqZu6T/MlKsKwrqj6Z00MhalBaEpM3zWu4L
   YFWf3KrfvBFIxn5Ton4NIS0PS8krmaRrXNlueqP6uUJQuoECJLCbbhMfl
   YzSr/76ASTCn7KA8xkS6eobYeUflF2TBtjPgiRLkRnEPOQO1dSSQMpZx6
   ZSN8R4AOfcVCS+prgzzVW6jNOL9vairQ1l0m2C4N3dFNovLQCq/njG3Pi
   A==;
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="36978767"
IronPort-PHdr: =?us-ascii?q?9a23=3AC7CrdBTl/NA1AZlbFCZk784TJNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBSPt8tkgFKBZ4jH8fUM07OQ7/m7HzZZuN3R7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZZ/Jqo+yR?=
 =?us-ascii?q?bEoGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvBM1Dvh9ITFfBIsrPeRVr?=
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
X-IPAS-Result: =?us-ascii?q?A2B8AgC2rPtd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXyBd?=
 =?us-ascii?q?oFsASAShDCJA4ZcBoESJYEBiGuRRQkBAQEBAQEBAQE3AQGEQAKCQDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIw8BBUEFCwsYAgImAgJXBg0IA?=
 =?us-ascii?q?QEVgko/glMFIKt3dYEyhU+DTIE9gQ4ojDN5gQeBEScMA4IoNT6HWYJeBJdVl?=
 =?us-ascii?q?zaCPoJEk04GG5pRLasGIoFYKwgCGAghD4MoTxgNjR4XjkEjA5FGAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Dec 2019 17:02:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBJH1vWm207112;
        Thu, 19 Dec 2019 12:01:59 -0500
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
 <55b5c889-ff38-38c4-578e-ec4211b837a4@tycho.nsa.gov>
 <93912039-e64e-cc56-20fc-095accf6c4dd@tycho.nsa.gov>
 <20191219164831.GA1308552@horizon>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <16af7932-a57b-1454-18ca-c2ff6e6b302d@tycho.nsa.gov>
Date:   Thu, 19 Dec 2019 12:02:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219164831.GA1308552@horizon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/19 11:48 AM, Simon McVittie wrote:
> On Thu, 19 Dec 2019 at 10:00:31 -0500, Stephen Smalley wrote:
>> Looks like userspace is generally forgiving of whether the terminating NUL
>> byte is included or omitted by the kernel (with different behaviors for
>> SELinux - always included, Smack - omitted by /proc/pid/attr/current but
>> included in SO_PEERSEC, and AppArmor - omitted for /proc/pid/attr/current
>> but includes a terminating \n, omitted for SO_PEERSEC but no terminating
>> \n), and procps-ng explicitly tests for printable characters (but truncates
>> on the first unprintable character).
> 
> Because LSM people have told me in the past that the '\0' is not
> conceptually part of the label, the D-Bus specification and reference
> implementation already assume that its presence or absence is irrelevant,
> and normalize to a canonical form (which happens to be that it appends a
> '\0' if missing, to be nice to C-like languages, but I could equally
> have chosen to strip the '\0' and rely on an out-of-band length count).
> 
> By design, SO_PEERCONTEXT and /proc/pid/attr/context don't (can't!)
> preserve whether the label originally ended with '\0' or not (because
> they are designed to use '\0' as a terminator for each label), so these
> new kernel interfaces are already a bit closer than the old kernel
> interfaces to how D-Bus represents this information.
> 
> The problematic case is AppArmor's terminating '\n' on
> /proc/pid/attr/current, because when I asked in the past, I was told
> that it would be (unwise but) valid to have a LSM where "foo" and "foo\n"
> are distinct labels.

I don't agree with that stance, but obviously others may differ.

> If that hypothetical LSM would make procps-ng lose information (because
> procps-ng truncates at the first unprintable character), does that change
> the situation any? Would that make it acceptable for other LSM-agnostic
> user-space components, like the reference implementation of D-Bus, to
> assume that stripping a trailing newline from /proc/pid/attr/context
> or from one of the component strings of /proc/pid/attr/current is a
> non-lossy operation?

IMHO, yes.  In fact, looking further, I see that systemd's 
src/libsystemd/sd-bus/bus-creds.c:bus_creds_add_more() reads 
/proc/pid/attr/current with its read_one_line_file() helper which 
ultimately uses read_line_full() and treats EOF, \n, \r, or \0 as 
terminators and truncates on first such occurrence.

> 
>>>>     If this new API is an opportunity to declare that LSMs are expected
>>>>     to put the same canonical form of a label in
>>>> /proc/$pid/attr/context and
>>>>     SO_PEERCONTEXT, possibly with a non-canonical version (adding '\n' or
>>>>     '\0' or similar) exposed in the older /proc/$pid/attr/current and
>>>>     SO_PEERSEC interfaces for backwards compatibility, then that
>>>> would make
>>>>     life a lot easier for user-space developers like me.
>>>
>>> I'm all for this but the current implementation reuses the same
>>> underlying hooks as SO_PEERSEC, so it gets the same result for the
>>> per-lsm values.  We'd need a separate hook if we cannot alter the
>>> current AppArmor SO_PEERSEC format.
> 
> If AppArmor was going to change the format of one of its interfaces
> (or deviate from it when implementing new interfaces), I'd actually
> prefer it to be /proc/pid/attr/current that changed or was superseded,
> because /proc/pid/attr/current is the one that contains a newline that
> consumers are meant to ignore.
> 
> For what it's worth, libapparmor explicitly removes the newline, so this
> only matters to LSM-agnostic readers like D-Bus implementations, and to
> lower-level AppArmor-aware readers that use the kernel interfaces directly
> in preference to using libapparmor.

Deferring to the AA maintainer(s) to speak to this.
