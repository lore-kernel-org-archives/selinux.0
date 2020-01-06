Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EFC33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F9A208C4
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Bf+4uuLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgAFSmp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:42:45 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:2563 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSmp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 13:42:45 -0500
X-EEMSG-check-017: 41514492|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="41514492"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 18:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578336164; x=1609872164;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0beYwzKriaMxN5mTG1vGWjMJR7xDHfGBoTS08vJtiGc=;
  b=Bf+4uuLHeP8jRm3nuaYzuJnvDatdBPHYlWgowCM84tB1rs3pYpVGo22f
   QbO9MwB9ptXyz/j68Qq2FaepSwE2g8ez4hpw72V4Um8KRMOrqbYgaY1DP
   L3Mj/hbeUMoTsWoFxp45nz0DdnlI86ixYNwwroJnuUv32c/mHTo//32uV
   /VAoxzwvU1uv09y+O2TwQ+Y4KRUYtXkbE94ZxHcrEc2nlu07B2ge2B3ZX
   5PSi7aS0Hggs/nVdBwoIp8bBWl0uwNx8OEh+fWoYh10hZmYMDAgjLms/7
   WRgX+GvcRK2wCHDmPZoY15tEFt61DmvoBQTUdyOURIMIQhSTjhlPAbNkn
   A==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="37397355"
IronPort-PHdr: =?us-ascii?q?9a23=3APaAcpxJKQCCAAus1HdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLv36rarrMEGX3/hxlliBBdydt6sfzbCL6+u5ADFIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQjRqsUajpZuJrsxxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBuzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2L8wlp?=
 =?us-ascii?q?wdsUTEBS/5hln5gLWKdkQk5ueo6+Pnbq/gppCALI97lhvyMqEvmsy7Geg4Mw?=
 =?us-ascii?q?4OUHaH+emkybHu8kL0TK9Kg/EriKXVrp/XKdoBqqKkGwNV15ws6xe7Dzeoyt?=
 =?us-ascii?q?QYmnwHIUpeeB2alIjkIE3OIfDkAve/hFSgijFrx+vcMbH7DZXNKWbDnK/7fb?=
 =?us-ascii?q?lh805c1BYzzddH6pJPD7EOPOzzV1Ttu9zfCh85Nxa7zP3gCNVnzIwSQ36AAq?=
 =?us-ascii?q?icMKnKq1+H+vovI/WQZI8SoDvyN+Iq5+Xwgn45glIdZrWm3ZsNZ3ClEPRmJ1?=
 =?us-ascii?q?uWYWD1jtgdC2gGpBYxTOvviFeaSz5ce26yX74g5jE8EI+pEZ3MRpuzj72Bxi?=
 =?us-ascii?q?u7BYFZZmBcBVCRH3foc5uLW+0XZSKTJM9hjiILVby7R4A90hGusRfwy6B7Ie?=
 =?us-ascii?q?rM5i0YqZXj2cB35+3WkhEy7yZ0D8WG02yWSWF7hGYISCE33Kxlpkx90FiD27?=
 =?us-ascii?q?Big/NEDdxT++9JUgAiOJ7Yzux6Dc3yWw3YcteSVlmpXsimASswTtItw94Cek?=
 =?us-ascii?q?N9G9K/gRDe2yqlHaQYl6KEBJMq6KLQxXvxKNhny3bAyqYhi0MqQsxVNW2pnq?=
 =?us-ascii?q?R/7RTcB5bVk0WFkKanbb8c0zDJ9GeCy2qOoU5ZXRVuUaXKQ38ffFHardfn6U?=
 =?us-ascii?q?PYSb+hF7AnPhFGyc6YJatAcsfpgkleRPf/JNTeZHq8m2SuChmW3bODcI3qe2?=
 =?us-ascii?q?Ie3CjGFEcEkxoT/XGDNQg/GyehpnjSDDt0FVLge0ns6/VxqGunTk8oyAGHd0?=
 =?us-ascii?q?9h1721+h4Tn/CcSfQT3rIetycnsDV7AlC90snKBNWaoQphe6NcYdIh71hd0W?=
 =?us-ascii?q?LVrRByPpulL6p6nF4Rbxx3v1/y1xVwEohAidYlrHUlzApvKKKY1kpNdzCG0p?=
 =?us-ascii?q?DqPL3YNG3y8Quua6LP3lHe18iW9bkV5PQjsVrjvxypFlA4/Hl91dlazWGQ5p?=
 =?us-ascii?q?fSDAAKS5L+Tl439wRmp7HdeiQ9/5nb1WBoMaSvqj/Nwc8pBO88xhaleNdfN7?=
 =?us-ascii?q?mEGxHoH8IGAMiuLb9ip1/8VRMBO+Ya0aUKPt+6dvbOjLWuN/hIlzWiiW1N55?=
 =?us-ascii?q?p0lEmL8nwvZPTP2sM+3/yA3gaBHwz5hVOlv9G/zZtIfhkOD2G/zm7iH4cXaa?=
 =?us-ascii?q?psK9VYQVyyKtG6k40tz6XmXGRVoRv6WgIL?=
X-IPAS-Result: =?us-ascii?q?A2CwAABwfhNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWsEA?=
 =?us-ascii?q?QELAYF8gWwBIBKEM4kDhmMBAQQGgRIliW6RSAkBAQEBAQEBAQE3AQGEQAKCD?=
 =?us-ascii?q?TcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIxVBEAsYAgImAgJXBg0IA?=
 =?us-ascii?q?QGCXz+CUyWtd4EyhU+DJ4E9gQ4oAYwyeYEHgTgMA4JdPodZgl4EjXiJHkaWS?=
 =?us-ascii?q?HWCQIJFk08GG4JGh32QGC2rDyOBWCsIAhgIIQ+DKE8YDY0eF45BIwOPFwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Jan 2020 18:42:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006IftVE034846;
        Mon, 6 Jan 2020 13:41:58 -0500
Subject: Re: [PATCH v13 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Simon McVittie <smcv@collabora.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-24-casey@schaufler-ca.com>
 <cce57d59-8c68-8ef0-b887-0597492e1833@tycho.nsa.gov>
 <20200106172949.GA80652@horizon>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dd1687da-5105-33aa-d1b8-300c4738654c@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 13:43:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106172949.GA80652@horizon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/6/20 12:29 PM, Simon McVittie wrote:
> On Mon, 06 Jan 2020 at 12:15:57 -0500, Stephen Smalley wrote:
>> On 12/24/19 6:59 PM, Casey Schaufler wrote:
>>> The getsockopt SO_PEERSEC provides the LSM based security
>>> information for a single module, but for reasons of backward
>>> compatibility cannot include the information for multiple
>>> modules. A new option SO_PEERCONTEXT is added to report the
>>> security "context" of multiple modules using a "compound" format
>>>
>>>           lsm1\0value\0lsm2\0value\0
>>>
>>> This is expected to be used by system services, including dbus-daemon.
>>> The exact format of a compound context has been the subject of
>>> considerable debate. This format was suggested by Simon McVittie,
>>> a dbus maintainer with a significant stake in the format being
>>> usable.
>>
>> Since upstream AA does not currently ever set the peer label info, there is
>> no need for this support for stacking upstream AA today, and there is no way
>> to test this functionality with more than one module present currently in an
>> upstream kernel.  Either fix AA to actually implement the functionality so
>> it can be tested properly, or drop it from this series please.  I don't
>> understand why AA continues to keep this kind of basic and longstanding
>> downstream functionality out of tree.
> 
> Alternatively, a pair of tiny in-tree or out-of-tree stackable LSMs
> that don't make any security decisions, and label every labellable
> process/socket/thing with something predictable, would make it really
> easy for both kernel and user-space developers to test this and the
> user-space code that uses it (D-Bus and others).
> 
> For example, they could label process 1234 and all sockets created by
> process 1234 with "contexttest1\0pid1234\0contexttest2\0process1234" or
> something like that.
> 
> I'd love to see AppArmor in upstream kernels support SO_PEERSEC and
> SO_PEERCONTEXT, but setting up a development machine to stack AppArmor
> and SELinux (and still be able to boot, without one or the other LSM
> forbidding something important) seems likely to be harder than setting
> it up to load some toy LSMs.

AA+SELinux with these patches boots fine for me with Fedora; it doesn't 
load any policy for AA but you still get a compound context from 
/proc/pid/attr/context.  Should be similar for booting with a distro 
that only enables AA by default; you'll get "kernel" for the SELinux 
part of the compound label in the absence of any policy loaded.


