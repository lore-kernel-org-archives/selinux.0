Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B0CC352A3
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A2020658
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HCbMbV4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgBJOyb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:54:31 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:16319 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgBJOya (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 09:54:30 -0500
X-EEMSG-check-017: 57248205|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="57248205"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 14:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581346457; x=1612882457;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KItMVGvIkhmwOqj+aZj5/vi6VPwanmq2sf40gPdGNXc=;
  b=HCbMbV4SH4AgdyUT4zrn+3UbsVfkGmfkChm072Za/r7rQU9bAwucDrf3
   yKoN6OtdGEGt2yEq9CqyNSyPXHAeynrV3diYpIxmV9mrVoLUA1B1h5sYo
   ew86laMy3rBsRzTHFCIhe2tRl+MOjUvW0dmgsXeUGHo02g7HVP3AW7NQQ
   B33827UUamnUMWFJasSfI3JaSBFRItRQFQYDCY4TnNQo88HSnyLwW7olO
   QUIHUTEYVow1HZ+fqOHozoF70m+yMO97OWQaWXujiqjsydbqducG0NAR3
   45Zj+49KXVBne1JalNCmQulhH8jk5vsczT3dhauRHM0xPekGf2bDKDvdB
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="38886210"
IronPort-PHdr: =?us-ascii?q?9a23=3A+OHq8hTaCuNDwaVYAM3lfyuSX9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBOGt8tkgFKBZ4jH8fUM07OQ7/m8HzJZqsjc+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTo3ZEZutayGJoKFmOmxrw+tq88IRs/ihNtf8t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LacfXOSwwKTO0D7Nbe5Z2S3l5YbVch4vv/+MU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PD6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXxreLW6hxmo8EigzPXxVtOv0F?=
 =?us-ascii?q?ZWtCZFid7Mu3YQ3BLQ8siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt37g9nY?=
 =?us-ascii?q?cJv0vZBC/5gkD2gbeTdkUj5+en9fzqYq7jpp+AL490jRz+Mrg2lsy/H+s4Ng?=
 =?us-ascii?q?8OUnCH+eumzr3j/FD5QK5Qgv03lKnZvpfaJd8FqaGlGQNVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2UILElZdx6diojpOlXOLOj5Dfe5nVusjC9my+3JM7DuGJnALmXPnK3/cb?=
 =?us-ascii?q?ty9UJQ0hc/wcha551OC7EBJPzzWlX2tNzdFhI5KBG7w/38BdVh1oIRRWKPAq?=
 =?us-ascii?q?iDPKPUql+H/PgjI+aLZI8LoDr9MeQq5+byjX8lnl8QZbKp3Z4LZ3CmBflpP0?=
 =?us-ascii?q?KZYX7ogtgbCmgKuRA+Q/bwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5ixj7Obxy?=
 =?us-ascii?q?e0AJ1Xa3tdCl+QEXfnbZiEW/kIaC2MOM9tiyALWqK7R4A90hGusRfwy6B7Ie?=
 =?us-ascii?q?rM5i0YqZXj2cBp6OLJjhE96zx1A96G026RT2F7hH4IRzEy3K9hu0xw0VaD0a?=
 =?us-ascii?q?5kg/NGEdxf/e9GUgA/NZTE1ex1F8jyWh7dfteOUFumQNCmATYrTtIrwt8OeF?=
 =?us-ascii?q?1wG9O4gRDGwSWqAqUZl7uRBJw76qjcxWT+J95hy3ba06ksl10mQspJNW27ia?=
 =?us-ascii?q?9z7hPTCJDVnEWEjaaqdLgc3S7U+GeGymqBoVxYUApuXqjeQ3AfaVXZrc7j6k?=
 =?us-ascii?q?PBUbCuE7InPRVFycKYLatKcNLph01cRPj/INTef36xm2CoCBaT2LyMaIvqe2?=
 =?us-ascii?q?MA3CTSE0UEjQ8T8micNQQkBSeuvXjeDDpwGlLreU/s9vN+qHyjRE8u0w6Kd1?=
 =?us-ascii?q?Fh16ay+hMNhvyTVe0c3qkYtycmrDV0H02w0M7WC9qaoApheaRcYc444Ftd0m?=
 =?us-ascii?q?LZrQN9NIS6L69+nl4ebxh3v0T22hV1DYVAkc4qoGkozAp1KaKXylVBdyiG0p?=
 =?us-ascii?q?D2IbDYNnP9/Baoa67Q21HRzMyZ+qMV5PskrFXjuRmjFlA+/HV/z9lVz3yc64?=
 =?us-ascii?q?3SDAUMV5LxXVs39xl8p73DYSky+ZnU1XtyPqmwqTLC2sslBO8iyha+YdhTKr?=
 =?us-ascii?q?iEGxXxE80HHcihMvYmm163YR4ePuBS7LY+P9m6ePuexK6rIOFgkSq+jWtd/Y?=
 =?us-ascii?q?B91lmB9zJmRe7V25YJ2vSY3gyAVzfmklitqNz4mYdBZWJaIm3q8inhA4gZQ6?=
 =?us-ascii?q?ZMfJoXCGrmd9ayzctWjJnpX3dS80SqQVgB3Zn6VwCVagnGwQBI1UkR6UeikC?=
 =?us-ascii?q?+8wi08xyoltYKDzSfOxKLkbxNBNWlVEjoxxWzwKJS52ohJFHOjaBIkwV78uB?=
 =?us-ascii?q?f3?=
X-IPAS-Result: =?us-ascii?q?A2DiAgD+bUFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBKEP4kDhmYBAQEGgTeJcJFLCQEBAQEBAQEBATcBAYRAAoJqOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgwEBAQEBAgEjBAsBBUEQCQIYAgImAgJXBg0IA?=
 =?us-ascii?q?QGCYz+CVwUgjBebBHV/M4hwgT6BDiqMPXmBB4E4D4Fffj6HW4JeBJgIl2qCR?=
 =?us-ascii?q?IJOk3gGG5sPrBoigVgrCAIYCCEPgyhPGA2OJhqOQSMDjxgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Feb 2020 14:54:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01AErDVt002547;
        Mon, 10 Feb 2020 09:53:15 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Simon McVittie <smcv@collabora.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
 <20200210115611.GA13930@horizon>
 <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
Message-ID: <04442c9f-430e-c922-b078-7cff8f36a45f@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 09:55:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <94aaf6c8-cc69-5804-2d45-3b8c96689331@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 8:25 AM, Stephen Smalley wrote:
> On 2/10/20 6:56 AM, Simon McVittie wrote:
>> On Mon, 03 Feb 2020 at 13:54:45 -0500, Stephen Smalley wrote:
>>> The printable ASCII bit is based on what the dbus maintainer 
>>> requested in
>>> previous discussions.
>>
>> I thought in previous discussions, we had come to the conclusion that
>> I can't assume it's 7-bit ASCII. (If I *can* assume that for this new
>> API, that's even better.)
>>
>> To be clear, when I say ASCII I mean a sequence of bytes != '\0' with
>> their high bit unset (x & 0x7f == x) and the obvious mapping to/from
>> Unicode (bytes '\1' to '\x7f' represent codepoints U+0001 to U+007F). Is
>> that the same thing you mean?
> 
> I mean the subset of 7-bit ASCII that satisfies isprint() using the "C" 
> locale.  That is already true for SELinux with the existing interfaces. 
> I can't necessarily speak for the others.

Looks like Smack labels are similarly restricted, per 
Documentation/admin-guide/LSM/Smack.rst.  So I guess the only one that 
is perhaps unclear is AppArmor, since its labels are typically derived 
from pathnames?  Can an AppArmor label returned via its getprocattr() 
hook be any legal pathname?

>> I thought the conclusion we had come to in previous conversations was
>> that the LSM context is what GLib calls a "bytestring", the same as
>> filenames and environment variables - an opaque sequence of bytes != 
>> '\0',
>> with no further guarantees, and no specified encoding or mapping to/from
>> Unicode (most likely some superset of ASCII like UTF-8 or Latin-1,
>> but nobody knows which one, and they could equally well be some binary
>> encoding with no Unicode meaning, as long as it avoids '\0').
>>
>> If I can safely assume that a new kernel <-> user-space API is 
>> constrained
>> to UTF-8 or a UTF-8 subset like ASCII, then I can provide more friendly
>> APIs for user-space features built over it. If that isn't possible, the
>> next best thing is a "bytestring" like filenames, environment variables,
>> and most kernel <-> user-space strings in general.
>>
>>      smcv
>>
> 

