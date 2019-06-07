Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F29C2BCA1
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD97208C3
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 21:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DCVtp0j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfFGV0f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:26:35 -0400
Received: from usfb19pa16.eemsg.mail.mil ([214.24.26.87]:21965 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfFGV0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Jun 2019 17:26:35 -0400
X-EEMSG-check-017: 203440842|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jun 2019 21:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559942793; x=1591478793;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=jcOj736KeCWjRx1kTzLvb9gEQOw6wBqqK3/jvuJVuWo=;
  b=DCVtp0j5KkSgnMDsQsXbUotB443U4Pr5bbp9ok82W08bLSsQfzCGrxt1
   1u7OFb/SvvRrmNSbZvO/c0Pj1QId55Xqx8TtRE/k/sqxisd+esAVNehQh
   YwcBbPefk56KSfexTeMnbOeLVf4xQ6xlvk/H3S6dRz+5FDBjUTKOI4Qm9
   Va4BRIqvbUoZ+8AmEyQ07cfL01lPbZTJYMMhC20RC9C6OdpMad0Udc/ia
   oLpdRmPyAB28SDCgUyUbAY/gevbGcUyInQzxRxIx3/jVhU3bjpFfXeBoi
   FtU/eigJ1a5qkTnqe8zIfnUfxdi1yh3hqwHi2J8EkFZe5VNom4sD8RsIi
   A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557187200"; 
   d="scan'208";a="28718042"
IronPort-PHdr: =?us-ascii?q?9a23=3Ao/dKfxYfcRxIzs2TgjPZuUP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsiybnLW6fgltlLVR4KTs6sC17OP9fm8BydZvMfJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQi6oR/MusQZgIZuJbs9xx?=
 =?us-ascii?q?vNr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAmhCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbP5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jI?=
 =?us-ascii?q?YTsETfES/2n0X6lqmWeVk/+ue08ejnZ7TmppuEO491jAHxLLgul9SiDek3PQ?=
 =?us-ascii?q?UCRWiW9fmm2LH98kD1Xq9GguAunqncqp/aJMAbpqCjAw9S14Yu8w2/ACq90N?=
 =?us-ascii?q?kDgXkGLE5KeBKAj4TzPVHOO+r3Ae2wg1Srjjdn3+rGMaH5ApXRMnjDl6/scq?=
 =?us-ascii?q?tz6kFGzAoz1tBf6olOCr4fPf3zWlX+tMDCAhAlNAy0xv7tCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvXsV+J+uIvOfKBZJULtzngK/gq/eLugWUlll8aeKmjxYEXZ2ygHvR6P0?=
 =?us-ascii?q?WZZmLhgswfHmcOvwo+SvHqiVKZXD5NaHa9Qbg86is4CI24F4fDQJ6igLib0C?=
 =?us-ascii?q?e8BJ1WaTMONlfZHWjhc56Ec+0BZCKbPolqlTlAHZ2gT4g60Riw/DPgzrNsZr?=
 =?us-ascii?q?7R+zECnYju2Nh8+6vYkhRksXRvAsCc1XydZ397k3lORDIs2q1750tnxQSty6?=
 =?us-ascii?q?991sdEGMRT6vUBaQIzMZrR3qQuENzpch7QddeODlC9S5OpBi9nHYF5+MMHf0?=
 =?us-ascii?q?soQ4bqtRvExSf/RuZIxrE=3D?=
X-IPAS-Result: =?us-ascii?q?A2D1BAAp1vpc/wHyM5BmHQEBBQEHBQGBZYFnKoE7ATKEP?=
 =?us-ascii?q?ZJzTAEBAQEBAQaBNYlRkQkJAQEBAQEBAQEBNAECAQGEQAKCaiM4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEDAQFsKII6KQGCZwEFIw8BBVELGAICJgICVwYBDAgBAYJfP4F3FKgpg?=
 =?us-ascii?q?TGFR4MmgUaBDCiLWxd4gQeBOII2By4+h06CWASpJAmCEIIbkSAGG4IkinyJc?=
 =?us-ascii?q?Y0PgSmXGyGBWCsIAhgIIQ+DKIIaF448IwOBNgEBjy0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Jun 2019 21:26:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x57LQMx1014506;
        Fri, 7 Jun 2019 17:26:22 -0400
Subject: Re: New Container vulnerability could potentially use an SELinux fix.
To:     dwalsh@redhat.com, Miloslav Trmac <mitr@redhat.com>,
        selinux@vger.kernel.org
References: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
 <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
 <d07bdda3-264b-daf4-5896-6e7a7c68f63a@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <75f00b22-390a-8f7b-5f84-15c64d17eb89@tycho.nsa.gov>
Date:   Fri, 7 Jun 2019 17:26:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d07bdda3-264b-daf4-5896-6e7a7c68f63a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/7/19 5:06 PM, Daniel Walsh wrote:
> On 6/7/19 12:44 PM, Stephen Smalley wrote:
>> On 6/7/19 11:42 AM, Daniel Walsh wrote:
>>> We have periodic vulnerablities around bad container images having
>>> symbolic link attacks against the host.
>>>
>>> One came out last week about doing a `podman cp`
>>>
>>> Which would copy content from the host into the container.  The issue
>>> was that if the container was running, it could trick the processes
>>> copying content into it to follow a symbolic link to external of the
>>> container image.
>>>
>>> The question came up, is there a way to use SELinux to prevent this. And
>>> sadly the answer right now is no, because we have no way to know what
>>> the label of the process attempting to update the container file system
>>> is running as.  Usually it will be running as unconfined_t.
>>>
>>> One idea would be to add a rule to policy that control the following of
>>> symbolic links to only those specified in policy.
>>>
>>>
>>> Something like
>>>
>>> SPECIALRESTRICTED TYPE container_file_t
>>>
>>> allow container_file_t container_file_t:symlink follow;
>>>
>>> Then if a process attempted to copy content onto a symbolic link from
>>> container_file_t to a non container_file_t type, the kernel would deny
>>> access.
>>>
>>> Thoughts?
>>
>> SELinux would prevent it if you didn't allow unconfined_t (or other
>> privileged domains) to follow untrustworthy symlinks (e.g. don't allow
>> unconfined_t container_file_t:lnk_file read; in the first place).
>> That's the right way to prevent it.
>>
>> Trying to apply a check between symlink and its target as you suggest
>> is problematic; we don't generally have them both at the same point.
>> If we are allowed to follow the symlink, we read its contents and
>> perform a path walk on that, and that could be a multi-component
>> pathname lookup that itself spans further symlinks, mount points,
>> etc.  I think that would be challenging to support in the kernel,
>> subject to races, and certainly would require changes outside of just
>> SELinux.
>>
>> If you truly cannot impose such restrictions on unconfined_t, then
>> maybe podman should run in its own domain.
>>
> This is not an issue with just podman.  Podman can mount the image and
> the tools can just read/write content into the mountpoint.
> 
> I thought I recalled a LSM that prefented symlink attacks when users
> would link a file in the homedir against /etc/shadow and then attempt to
> get the admin to modify the file in his homedir?
> 
> I was thinking that if that existed we could build more controls on it
> based on Labels rather then just UIDs matching.

Not sure if you are thinking of symlink attacks or hard link attacks. 
SELinux supports preventing the former by restricting the ability to 
follow symlinks based on lnk_file read permission, so you can prevent 
trusted processes from following untrustworthy symlinks.  SELinux 
supports preventing the latter by restricting the ability to create hard 
links to unauthorized files.  But you need to write your policies in a 
manner that leverages that support, and a fully unconfined domain isn't 
going to be protected via SELinux by definition; ideally you'd be 
phasing out unconfined altogether like Android did.  Modern kernels also 
have the /proc/sys/fs/protected_hardlinks and 
/proc/sys/fs/protected_symlinks settings, which restrict based on UID, 
but the symlink checks aren't based on the target of the symlink either.
