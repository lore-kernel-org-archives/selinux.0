Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C29BC2D0B1
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079DF20838
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OiAF4nt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgBFOvu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:51:50 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:2883 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBFOvu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 09:51:50 -0500
X-EEMSG-check-017: 55775190|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55775190"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 14:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581000707; x=1612536707;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DhOPJyG1FgtLw9ghch9GTov1HbihhUrcZbnaj+W4rWw=;
  b=OiAF4nt0Yw1mKu6E4xvB2nbB3g/lucai4uS6FP/XzF/cYrhJ4rtMjOxF
   aFKklRKkpjFAWCaRS1i1uk3H40YPhKXhywz+L7U80qrrxH4MgWy8dY251
   CPFO3J2kGi30BliZWQtX6rZp0UaM/ULw2uggQOKwqJu07u5/IlAvJPGN1
   WIyDjP0u2ntFAduLb+0zlCPvr9e4w/o/Ni9i/W6QaH6PpGzRovmmY7erV
   eQJrDfoFXAqx79g78whDPkeHRl7rvNnU/Arl6m0R5+M/61B8Xq0eWXCcN
   PAGrE4qLTuHAHYMvfgzYtIL5lOsNYecGBqldEG/cc7wl9ai67FjO1za0n
   w==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="32759252"
IronPort-PHdr: =?us-ascii?q?9a23=3ACnin8R+ROA7qrf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21e0cTK2v8tzYMVDF4r011RmVBNmdtqkP1bSe8/i5HzBZutDZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMWjIZsJao8yx?=
 =?us-ascii?q?rEqWZMd+hK2G9kP12ekwvy68uq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USn?=
 =?us-ascii?q?RdUcZQTyxBA52zb40TD+oaIO1Uq5Dxq0YSoReiAAWhAu3gyiVMhnTrw6M01e?=
 =?us-ascii?q?ovGhzC0AA5H98DtHHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9Y7XmoJGcN4hvig7gLqsigNC/AOQkPQ?=
 =?us-ascii?q?gOWGiX4+K826H4/ULlWrlKi/w2kq3BvJDbI8QUuLK5DhdI3oss5BuzFTer3M?=
 =?us-ascii?q?kCkXUZI19JZgiLg5XxN1HLOv/4DPO/g1q2kDdswvDLJqbhDYjWLnXYjLfgfa?=
 =?us-ascii?q?py605byAYpy9Bf/IhbBqsOIPL0RE/9rMbYAQMhMwyo3+bnD81w1oQbWWKIGa?=
 =?us-ascii?q?+ZNrndvkOW6e80OemDepIauDbnJPg5/fLhkXg5mVoFd6mzwZQXcGy4HuhhI0?=
 =?us-ascii?q?iBenrjnNMBEWYMvgojQ+3nk0OCUTFNaHaoRa485S80CJigDYjdQoChmruB3D?=
 =?us-ascii?q?20HpdOfGBJFkiMEWv0d4WDQ/oMcCaSLdV8kjwYT7iuUJUu2Aq0tADk1rVnLv?=
 =?us-ascii?q?Db+jECuZ3/09h14r6bqRZn0jp4Fcmfm0SKVGd9lW4LD2sx2adkp0V2x3+Z3K?=
 =?us-ascii?q?R4iuAeHttWsaBnSAA/YKXAwvR6Bta6YQfIetOEWR7yWdm9KS0gRdI2hdkVag?=
 =?us-ascii?q?ByHMv03UOL5DajH7JAz+/DP5cz6K+JmiGsdss=3D?=
X-IPAS-Result: =?us-ascii?q?A2ABBACxJzxe/wHyM5BmHQEBAQkBEQUFAYF7gX2BbCESK?=
 =?us-ascii?q?oQViQOGZQEBAQaBN4lwkUsJAQEBAQEBAQEBNwEBhEACgmE4EwIQAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFQ4I7KQGDAQEBAQECASMVQQULCw4KAgImAgJXBg0GAgEBgmM/g?=
 =?us-ascii?q?lcFIKsGdYEyhUqDXYE+gQ4qjD15gQeBEScPgl0+hDyDH4JeBJc+RpdngkSCT?=
 =?us-ascii?q?pNyBhuCSJhDkC2baSKBWCsIAhgIIQ+DJ1AYDZ0BIwMwjAmCQQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Feb 2020 14:51:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016EotoJ080466;
        Thu, 6 Feb 2020 09:50:55 -0500
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command
 line
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
 <20200206131253.535302-3-omosnace@redhat.com>
 <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
 <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5714f2b9-2dc1-feaf-1f73-2a50a464101b@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 09:52:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvkvuP2qVna2uj3zPPJC5rgJuOei7rF9=gLUo6QUxyvZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 9:19 AM, Ondrej Mosnacek wrote:
> On Thu, Feb 6, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 2/6/20 8:12 AM, Ondrej Mosnacek wrote:
>>> When using semodule for building a distribution policy package (as
>>> Fedora does), the environment might not have selinuxfs available and
>>> provide no way to modify semanage.conf. When we want to build a policy
>>> with version X (because our kernel doesn't support X+1 and above yet),
>>> but our libsepol already has support for X+1, then we currently have no
>>> way to do so.
>>
>> Not fundamentally opposed, but unclear on the motivation.  The current
>> approach is to generate the highest policy version supported by our
>> libsepol at build time, then libselinux selinux_mkload_policy() uses
>> libsepol functions (sepol_policydb_set_vers(),
>> sepol_policydb_to_image()) to automatically downgrade the policy in
>> memory to whatever version is supported by the kernel before writing it
>> to the kernel.  This works as long as one uses the same or newer
>> libsepol at load time as at build time and as long as policydb_write()
>> supports writing older policy versions (generally discarding newer
>> features).
> 
> The problem is that:
> 1. selinux-policy expects that the generated /etc/selinux/.../policy.X
> file will be generated with a specific (hard-coded) value X, so if the
> userspace is updated in buildroot, the selinux-policy build fails.
> 2. If we fix the above by expecting any value X and ship that, then
> the build passes in such case, but if a user updates selinux-policy
> without updating userspace and reboots, the system will not boot. So
> even if we stop incrementing the expected policy version manually, we
> would still need to manually increment the minimum required userspace
> version each time the policy is rebuilt with userspace that has
> incremented its max policyvers.

Seems like you could just have selinux-policy depend on the version of 
libsepol used to build it.

The problem with both your current approach and your proposed one is 
that it means that if a user or package does a semodule -B (or any other 
semodule/semanage command) on their system, that will generate the 
latest policy.N version supported by their libsepol, and libselinux will 
give precedence to that policy at load time.  So if they then later 
update their selinux-policy package, and it only installs a prebuilt 
policy.(N-1), that won't actually get loaded - libselinux 
selinux_mkload_policy() will keep using the policy.N file (which may be 
older).  Unless I'm missing something.

> With these patches we can call semodule -V %{POLICYVER} ... and new
> rebuilds of selinux-policy wouldn't be disrupted by userspace
> upgrades. The only downside is that we would need to remember to
> increment the specfile versions from time to time.
> 
> OTOH, maybe the build failure is actually a good thing in that it
> serves as a reminder to bump all the hard-coded versions whenever
> userspace bumps max policyvers...
