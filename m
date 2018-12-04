Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE0AC04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE00206B6
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE00206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLDQfx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:35:53 -0500
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:30817 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeLDQfx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 11:35:53 -0500
X-EEMSG-check-008: 799539617|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="799539617"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 16:35:51 +0000
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="18407340"
IronPort-PHdr: =?us-ascii?q?9a23=3ATdedkRDjynwcsyKGCfp8UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT+o8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs7Vy?=
 =?us-ascii?q?6i76N2QxH2jikJOSMy/GXOhsBukK5XpRSsrAF9zYHJeoGYLOdwcL3Tfd0aRm?=
 =?us-ascii?q?RPUMheWCNDDYygYIUCFPYBMORCooXhu1cDoxmzCA+xD+3v0D9IgXr20LUn3e?=
 =?us-ascii?q?Q9Dw7GxAwgEMwIsH/Jsdv1Mb0dUeSxzKbWzTTIcvRb2Szg54jTaR0hvfGNUq?=
 =?us-ascii?q?5wccrW00UvERjFgU+KpYzqODOVyP0Avm6G5ORuUuKvjnQoqwB3ojW3wscsjY?=
 =?us-ascii?q?bJipgOxVHE8yhy3YU7JcWgRUJmbtOpH4FcuiGHO4dsXM8vTH9ktDwnxrAApJ?=
 =?us-ascii?q?W1ZjIFyI49yB7ac/GHdo+I7Q/9W+uJOjd4gW5leKq4hxav7Uis0u38Wdew0F?=
 =?us-ascii?q?ZNtidFjsPDtmoM1xzO8ciLUOd9/0e91jaP0ADf8OdELlwvlaXHMZIhx78wlp?=
 =?us-ascii?q?4LvUTCGC/5hln2gbeLekgr9eWk8eTqbqj8qpOCOIJ4lBvyPrk2lsy6G+s4Mw?=
 =?us-ascii?q?wOX2aB+eS70b3u5Vb5T6hRjvAtjqnYsIzVJcQcpqKjBQ9VyZws5wywDzehzt?=
 =?us-ascii?q?QUhWMHI05deBKbk4jpPEnDL+v9Dfe8n1SsjTlqx/HYMb3nGZjNIX3Dn63gfb?=
 =?us-ascii?q?Z58UJT1A0zzdVH7ZJOFr4BOO7zWlP2tNHAFR82LQi0w+fhCNVg2YITQnyPAq?=
 =?us-ascii?q?CHP6PIq1OI5fwgI/OKZIALvDbxMf8l5+ThjSxxpVhIV4yKlc8dbXOkA+tnLk?=
 =?us-ascii?q?Oxbn/lg9NHGmAP6E52V+HuiVufQRZNaHuoGaEx/Dc2DMShF4iQaJqqhem6wC?=
 =?us-ascii?q?qjHpBQLltDA1SIHGagI56IQN8QeSmSJYlniTVCWr+/HdxynSqyvRP3nuI0Zt?=
 =?us-ascii?q?Hf/TcV4Ne5jNU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BDAABKrAZc/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYFohCCUdAEBAQEBAQaBCC2JH5AkOAGEQAKDCiI3Bg0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCNiSCYwEFIxVRCxgCAiYCAlcGAQwIAQGCXj+BdQ2lC4EvgXiDSIRxg?=
 =?us-ascii?q?QuLExd4gQeBOIJrhFuDKoJXAokNhms3kBoJiBWJJgYYkSaJBo0chDEigVUrC?=
 =?us-ascii?q?AIYCCEPgyiQeCEDgTUBAYgWgkwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2018 16:35:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4GZohq005020;
        Tue, 4 Dec 2018 11:35:50 -0500
Subject: Re: SELinux logging problem
To:     BMK <bmktuwien@gmail.com>, selinux@vger.kernel.org
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 11:38:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 11:03 AM, BMK wrote:
> Hello,
> 
> I am currently struggling with a strange SELinux problem,
> for which I am not able to find an answer by reading the documentation
> and researching online.
> 
> The problem is, that some AVC denial log entries seem to get lost in
> permissive mode,
> in other words, they are not logged...
> I've already deactivated all dont audit rules and I know for sure that
> the denial actually occurs, because I can trace it via strace...
> Although I can't see a corresponding entry in the audit.log.
> By the way, in enforcing mode I can see suddenly the missing denial entry...
> If the permissive mode lacks/drops some denials which we can only see
> in enforcing mode,
> then this would be truly terrible for the policy writers...
> Otherwise I am out of ideas, what other things could cause the loss of
> SELinux denials...
> 
> I hope you can point me to right direction with this matter and
> I thank you in advance for your help.

Permissive mode only logs the first instance of a denial by design to 
avoid flooding the logs with repeated instances of the same denial.  So 
if you triggered the denial a while ago and repeat the operation, you 
might not see the denial again.  To be precise, in permissive mode, upon 
the first denial of a permission, the permission is audited and then 
added to the AVC entry so that subsequent denials using that cache entry 
won't keep producing a denial. You can flush the cache to force denials 
to re-appear by reloading policy (load_policy) or by switching back and 
forth between permissive and enforcing mode (setenforce 1 && setenforce 0).

If that doesn't explain the behavior you are seeing, then we can't 
really help without more information about the problem, e.g. the denial 
message you say is visible in enforcing mode but not permissive mode, 
your kernel version, possibly the strace output, a reproducer if you 
have one, what distro / policy you are using, etc.

There are cases where the audit system could drop records due to OOM 
conditions, its ratelimit, or its backlog limit.  In those cases, you 
should have a audit: message logged indicating that messages were lost. 
  Check your dmesg or journalctl logs for such messages from the audit 
system.  Those are audit system issues rather than SELinux.  You can 
configure the limits via auditctl and/or the audit configuration.  But 
generally those only apply when the audit system is under heavy load 
from many denials (or many other audit messages) and you should see at 
least some of them.
