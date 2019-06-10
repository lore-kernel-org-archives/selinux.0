Return-Path: <SRS0=W683=UJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068EC28CC7
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 14:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F26207E0
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 14:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="j/dkUley"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbfFJOIm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:08:42 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:41729 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390707AbfFJOIl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 10:08:41 -0400
X-EEMSG-check-017: 861616175|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,575,1557187200"; 
   d="scan'208";a="861616175"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jun 2019 14:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560175710; x=1591711710;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=g1WnUDAt0iC6rrpP3w9EliCbaRsd7Dir84bHKcn9sws=;
  b=j/dkUleyTyucTnpIbJp+7DDtS2IE2AYoo8aW1+vbVHC+EZgprZp245WQ
   gRuASf7rlMEIWBUzRsI80Yd5nZSAkY4kJeCXyUnLQ2UUlZNLttFLQ+iM2
   DH2AgUioJOaTo2tLxrhQ6/s4dLDP3GtXc47gQFyoYJg1awPUSvB5qCxse
   JQiO/eStcchXNUGzPuz6e+Oi0Qlt+e+kJ6Bmi26eFD5KWFA++15sGMl4+
   k8kZsTVR+GBqM+hgdWZOKbNtzwFepI6WhgaZXvdqG2PXtAKam0WmWyBAr
   bSjehJcoYqswMVlJ/9lkgCzzwdQg4QZkG/mWnWwNokFHslqi75UZX2IGg
   w==;
X-IronPort-AV: E=Sophos;i="5.63,575,1557187200"; 
   d="scan'208";a="28754124"
IronPort-PHdr: =?us-ascii?q?9a23=3AeJQN1hDgxLPt/7w51RdAUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pc2wAkXT6L1XgUPTWs2DsrQY0rOQ6v26EjNZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5vIBmssAncttcajYRgJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoQW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAPyJQm2x7fceKIf5KP4hL5W+adOSx4hXJ+eL2jmxay9VGsxfPzV8ms1F?=
 =?us-ascii?q?ZKqTBFncfWtnwX0Rzc9NSHR/1g9UmiwTaCzx3f5+5LLEwulafXNoQtzqA/m5?=
 =?us-ascii?q?YNq0jPAyn7k1jsgqCMbEUr4O2o5vziYrXhu5CTKZd5ihr7MqQygsy/Bvk4Mh?=
 =?us-ascii?q?QWU2ib5+u80Lrj8FXlQLpQlP02k7TZsIvAKcQHpq+2Hw9V0oE55xa5Ezimy8?=
 =?us-ascii?q?gXkWMCLFJEfBKLl4npO1fQL/DkFfqznluhnThxy/3GI7HtGIvBI3fdnLv7YL?=
 =?us-ascii?q?px80tcxxAyzdBb6ZJUELYBIPfrV0/qqdPYFQQ0MxC0wun7CNV90ZkSWWSUAq?=
 =?us-ascii?q?CDKq/SvliI5vw3L+mWeIAVoCr9K+Qi5/P2kHA4l0USfa2y3ZsXc324BOppLF?=
 =?us-ascii?q?iZYXX2ntcNC3sFvg07TObykl2NTSZTZ2quX6I7/jw7DYOmDZvZRo22mryOwj?=
 =?us-ascii?q?q0Hp1MaWBaEFyDDXDod4CcUfcWdC2SOtNhkiADVbW5UI8uyxWutA78y7p6Ie?=
 =?us-ascii?q?vZ4TMYtZ3929hv/eHTlg899SZyD8uD12GBVWZ0nnkHR2x+4KcqrVN0zkyD+b?=
 =?us-ascii?q?J1j/xRCZpY4PYNGiI7MZnHy+VkQ+zoXwvKNoOMSUq8as+rDTE4UpQ6xNpYJw?=
 =?us-ascii?q?5mFtGjiA3T9zSlDqVTlLGRApEwtKXG0CvfPcF4nk3a2bEhgl9uec5GMWmrl+?=
 =?us-ascii?q?Yr7ATIL5LYmEWe0aCxfOIT2zCbpzTL9naHoEwNCF04aq7CR31KIxKM/Nk=3D?=
X-IPAS-Result: =?us-ascii?q?A2AzBABXY/5c/wHyM5BlHAEBAQQBAQcEAQGBZYFnKmpSM?=
 =?us-ascii?q?iiEFZJzTAEBAQEBAQaBECV+iFOPI4FnCQEBAQEBAQEBASsJAQIBAYRAAoJ0I?=
 =?us-ascii?q?zgTAQMBAQEEAQEBAQMBAWwcDII6KQGCZwEFIwQLAQVRCQIYAgImAgJXBgEMC?=
 =?us-ascii?q?AEBgl8/AYF2FA+LPptqfjOFR4MegUaBDCiLXRd4gQeBEScMgioHLj6CSBkEG?=
 =?us-ascii?q?IEUgz2CWASpJwmCEYIbhCmMeAYbgiWGfIQEiXaNE4EphWqRNSFncSsIAhgII?=
 =?us-ascii?q?Q87gm0IghIXgQIBDocVO4VbIwMwAYEFAQGPGwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jun 2019 14:08:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5AE8TiR024707;
        Mon, 10 Jun 2019 10:08:29 -0400
Subject: Re: New Container vulnerability could potentially use an SELinux fix.
To:     dwalsh@redhat.com, Miloslav Trmac <mitr@redhat.com>,
        selinux@vger.kernel.org
References: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
 <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
 <d07bdda3-264b-daf4-5896-6e7a7c68f63a@redhat.com>
 <75f00b22-390a-8f7b-5f84-15c64d17eb89@tycho.nsa.gov>
 <3957e38f-e62b-9800-da58-33ccb351a849@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <53479d32-a04d-2217-c4dd-9ce34bbba8ef@tycho.nsa.gov>
Date:   Mon, 10 Jun 2019 10:08:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3957e38f-e62b-9800-da58-33ccb351a849@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/8/19 10:08 AM, Daniel Walsh wrote:
> On 6/7/19 5:26 PM, Stephen Smalley wrote:
>> On 6/7/19 5:06 PM, Daniel Walsh wrote:
>>> On 6/7/19 12:44 PM, Stephen Smalley wrote:
>>>> On 6/7/19 11:42 AM, Daniel Walsh wrote:
>>>>> We have periodic vulnerablities around bad container images having
>>>>> symbolic link attacks against the host.
>>>>>
>>>>> One came out last week about doing a `podman cp`
>>>>>
>>>>> Which would copy content from the host into the container.  The issue
>>>>> was that if the container was running, it could trick the processes
>>>>> copying content into it to follow a symbolic link to external of the
>>>>> container image.
>>>>>
>>>>> The question came up, is there a way to use SELinux to prevent
>>>>> this. And
>>>>> sadly the answer right now is no, because we have no way to know what
>>>>> the label of the process attempting to update the container file
>>>>> system
>>>>> is running as.  Usually it will be running as unconfined_t.
>>>>>
>>>>> One idea would be to add a rule to policy that control the
>>>>> following of
>>>>> symbolic links to only those specified in policy.
>>>>>
>>>>>
>>>>> Something like
>>>>>
>>>>> SPECIALRESTRICTED TYPE container_file_t
>>>>>
>>>>> allow container_file_t container_file_t:symlink follow;
>>>>>
>>>>> Then if a process attempted to copy content onto a symbolic link from
>>>>> container_file_t to a non container_file_t type, the kernel would deny
>>>>> access.
>>>>>
>>>>> Thoughts?
>>>>
>>>> SELinux would prevent it if you didn't allow unconfined_t (or other
>>>> privileged domains) to follow untrustworthy symlinks (e.g. don't allow
>>>> unconfined_t container_file_t:lnk_file read; in the first place).
>>>> That's the right way to prevent it.
>>>>
>>>> Trying to apply a check between symlink and its target as you suggest
>>>> is problematic; we don't generally have them both at the same point.
>>>> If we are allowed to follow the symlink, we read its contents and
>>>> perform a path walk on that, and that could be a multi-component
>>>> pathname lookup that itself spans further symlinks, mount points,
>>>> etc.  I think that would be challenging to support in the kernel,
>>>> subject to races, and certainly would require changes outside of just
>>>> SELinux.
>>>>
>>>> If you truly cannot impose such restrictions on unconfined_t, then
>>>> maybe podman should run in its own domain.
>>>>
>>> This is not an issue with just podman.  Podman can mount the image and
>>> the tools can just read/write content into the mountpoint.
>>>
>>> I thought I recalled a LSM that prefented symlink attacks when users
>>> would link a file in the homedir against /etc/shadow and then attempt to
>>> get the admin to modify the file in his homedir?
>>>
>>> I was thinking that if that existed we could build more controls on it
>>> based on Labels rather then just UIDs matching.
>>
>> Not sure if you are thinking of symlink attacks or hard link attacks.
>> SELinux supports preventing the former by restricting the ability to
>> follow symlinks based on lnk_file read permission, so you can prevent
>> trusted processes from following untrustworthy symlinks.  SELinux
>> supports preventing the latter by restricting the ability to create
>> hard links to unauthorized files.  But you need to write your policies
>> in a manner that leverages that support, and a fully unconfined domain
>> isn't going to be protected via SELinux by definition; ideally you'd
>> be phasing out unconfined altogether like Android did.  Modern kernels
>> also have the /proc/sys/fs/protected_hardlinks and
>> /proc/sys/fs/protected_symlinks settings, which restrict based on UID,
>> but the symlink checks aren't based on the target of the symlink either.
> 
> Android does not have an Admin, so it is a lot easier for them.  But not
> going to get into that now.  I obviously understand how SELinux works.
> But perhaps I am looking for something differntly.
> 
> This link defines pretty close to what I would want, but extended for
> labels rather then just UIDS.
> 
> https://sysctl-explorer.net/fs/protected_symlinks/
> 
> 
>> A long-standing class of security issues is the symlink-based
>> time-of-check-time-of-use race, most commonly seen in world-writable
>> directories like /tmp. The common method of exploitation of this flaw
>> is to cross privilege boundaries when following a given symlink (i.e.
>> a **PRIVILEGED** process follows a symlink belonging **PROVIDED BY
>> OTHERS**). For a likely incomplete list of hundreds of examples across
>> the years, please see:
>> http://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
>>
>> When set to “0”, symlink following behavior is unrestricted.
>>
>> When set to “1” symlinks are permitted to be followed only when
>> outside a sticky world-writable directory **WE COULD POTENTIALLY SET
>> THIS OR SOME OTHER FLAG**, or when the **LABEL** of the symlink and
>> follower match, or when the directory **LABEL** matches the symlink’s
>> **LABEL**.
>>
>> This protection is based on the restrictions in Openwall and grsecurity.
>>

That's the /proc/sys/fs/protected_symlinks feature I mentioned in my 
email above.  It isn't based on the target of the symlink; it is only 
based on the attributes of the follower process (e.g. root), the 
attributes of the parent directory containing the symlink (e.g. /tmp), 
and the attributes of the symlink file (e.g. /tmp/foo -> /etc/shadow). 
At no point is it checking anything about the target of the symlink, 
e.g. /etc/shadow.  If dwalsh creates a symlink under /tmp (ln -s 
/etc/shadow /tmp/foo) and root tries to follow /tmp/foo, then that will 
fail because 1) the process fsuid (root) != the /tmp/foo symlink owner 
(dwalsh), and 2) /tmp is a sticky and world-writable directory, and 3) 
the /tmp directory owner (root) != the /tmp/foo symlink owner (dwalsh). 
Note that conditions (2) and (3) render the check useless for your use 
case, since you want to prevent following any symlinks writable by 
container processes in any directory within the container filesystem, so 
the directory need not be world-writable/sticky and the parent directory 
UID/label might be identical to the symlink UID/label.

The existing SELinux lnk_file read permission check enables you to apply 
stronger label-based controls to all symlinks within the container 
filesystem, not just ones in /tmp-like directories.  Don't allow 
unconfined_t or any other privileged domain read permission to 
container_file_t:lnk_file (or preferably to any file type for which 
:lnk_file create is allowed to container process domains), and you'll 
never have to worry about them following a symlink writable by a 
container process.  This of course assumes that the container filesystem 
is always labeled with a type that is untrusted, whether via mount 
contexts or actual labels.
