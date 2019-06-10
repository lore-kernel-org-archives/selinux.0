Return-Path: <SRS0=W683=UJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E82C31E41
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6890120859
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Q3nFV2/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbfFJPBa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:01:30 -0400
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:17996 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389841AbfFJPB3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 11:01:29 -0400
X-EEMSG-check-017: 418888916|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jun 2019 15:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560178855; x=1591714855;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3pL4u23PVgJD6VzNoDc7SuqZcGT6BQyCXnvCdUBZ6g0=;
  b=Q3nFV2/CgtwX+EBcezhl9rS++8VyA4MJeBxOhGyE30dpVf1cqZGyGeWW
   +IdOqokLKUbE8bF0sE/FQmjj/XaI5jmGOOOBN4ja+qZb68DPqL0H60XV9
   eB3UoXR49lN+ROOLCXE0agtLhzvsKhklDSnU97vdshNwoAE4GSKoJIbfW
   qBt05kcdMUMlMRJ9IoTM2EyvE47OaJ5ZdecIKvB80FYzisPkcusVGgEaC
   3AEplGIQysWn5zMaIV4Jh/24HNG6zSkpTN98HraBUeEr1BTBq5BlZ8LHl
   9iRi4n0h+/yyJS8uRfW8CuXpLnteBlUfITp5sneZ9Rb3N3b9Snpy5PZTo
   g==;
X-IronPort-AV: E=Sophos;i="5.63,575,1557187200"; 
   d="scan'208";a="28758232"
IronPort-PHdr: =?us-ascii?q?9a23=3Ak/S8dxSMPQFIBE6GXrwyeug8bNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBaGt8tkgFKBZ4jH8fUM07OQ7/m5HzVdu93R6DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajIt8Jqo+yR?=
 =?us-ascii?q?bFvmZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQWyAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvBM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg0zb0GvI?=
 =?us-ascii?q?S0fCkMyJk/wh7fauCHc5KW7R75U+aROzh4iGp+eLO/nBa97VSgyunlWsaq31?=
 =?us-ascii?q?dKti5Fkt7Wtn8TzRzf8M6HReVh/kqnxD2B1BjT5/lZLU07mqfXMZ4szqMqmp?=
 =?us-ascii?q?YNvknPADX6lFjwgaSLbEsr4PKo5P7iYrj+o5+cMJJ7hR/mP6Q1n8y/Hfw4Mg?=
 =?us-ascii?q?8TX2iH4ei81KPs/Un+QLhSkv05iLPZsJHHJcQAvKK5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?gXnWIbI15ffRKHjozpN0nPIPD+E/i/n0yhnCpkyv3JJLHsAojBImLdnLruY7?=
 =?us-ascii?q?px8VNQxBI2zd9F5pJUDr8BIOj0Wk/0rNHYFQI2Mxevzub7CNRyyoMeWWWVDq?=
 =?us-ascii?q?+fK6Pdq0WE5u0oI+mSfIMVoiryK+A55/7yin80gUISfKez0psTc3C4Hu9rI1?=
 =?us-ascii?q?+HbnXxgtcOC3sKshAiQ+ztjV2ISSRTaGqqX6Ig+jE7D5qrDYLCRoCxmryMxz?=
 =?us-ascii?q?27EYNLaWBGEF+MDW3keJmDW/cJcCiSONNukiQYVbi9TI8szQquuxH+y7pmKO?=
 =?us-ascii?q?rU5yIZuIn91Nh6+eLTjws+9T9qAMSH1WGCUWV0knkPRz8s06As6XB6n1uc2K?=
 =?us-ascii?q?xjg9RCGNBT7u8PWQA/cdb5zuh9ENT7REr9ZNKAQx7yR9S6GxkrQ94xysNIaE?=
 =?us-ascii?q?F4TZHqlR3H3iy3E5cLmLGRQp856KTR2z72Pcku5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGgvB?=
 =?us-ascii?q?LP?=
X-IPAS-Result: =?us-ascii?q?A2AzBAAvb/5c/wHyM5BmHAEBAQQBAQcEAQGBZYFnKmpSM?=
 =?us-ascii?q?iiEFZJzTAEBAQEBAQaBNX6IU48jgWcJAQEBAQEBAQEBKwkBAgEBhEACgnQjO?=
 =?us-ascii?q?BMBAwEBAQQBAQEBAwEBbBwMgjopAYJmAQEBAQIBIwQLAQVRCQIYAgImAgJXB?=
 =?us-ascii?q?gEMCAEBglMMPwGBdgUPD4tRm2p+M4VHgx+BRoEMKItdF3iBB4ERJ4I2By4+g?=
 =?us-ascii?q?kgZBBiBFAEMBgGDKYJYBKknCYIRghuEKYx4BhuCJYZ8hASJdo0TgSmFapE1I?=
 =?us-ascii?q?WdxKwgCGAghDzuCbQiCEheBAgEOhxU7hVsjAzABgQUBAYxKDheCLAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jun 2019 15:00:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5AF0rP0011939;
        Mon, 10 Jun 2019 11:00:54 -0400
Subject: Re: New Container vulnerability could potentially use an SELinux fix.
To:     dwalsh@redhat.com, Miloslav Trmac <mitr@redhat.com>,
        selinux@vger.kernel.org
References: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
 <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
 <d07bdda3-264b-daf4-5896-6e7a7c68f63a@redhat.com>
 <75f00b22-390a-8f7b-5f84-15c64d17eb89@tycho.nsa.gov>
 <3957e38f-e62b-9800-da58-33ccb351a849@redhat.com>
 <53479d32-a04d-2217-c4dd-9ce34bbba8ef@tycho.nsa.gov>
 <e8b8b026-0409-098b-bd2a-20ed43c4d10b@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <df0e048f-ef5f-8a43-81cb-3d3f6cf10230@tycho.nsa.gov>
Date:   Mon, 10 Jun 2019 11:00:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e8b8b026-0409-098b-bd2a-20ed43c4d10b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/10/19 10:37 AM, Daniel Walsh wrote:
> On 6/10/19 10:08 AM, Stephen Smalley wrote:
>> On 6/8/19 10:08 AM, Daniel Walsh wrote:
>>> On 6/7/19 5:26 PM, Stephen Smalley wrote:
>>>> On 6/7/19 5:06 PM, Daniel Walsh wrote:
>>>>> On 6/7/19 12:44 PM, Stephen Smalley wrote:
>>>>>> On 6/7/19 11:42 AM, Daniel Walsh wrote:
>>>>>>> We have periodic vulnerablities around bad container images having
>>>>>>> symbolic link attacks against the host.
>>>>>>>
>>>>>>> One came out last week about doing a `podman cp`
>>>>>>>
>>>>>>> Which would copy content from the host into the container.  The
>>>>>>> issue
>>>>>>> was that if the container was running, it could trick the processes
>>>>>>> copying content into it to follow a symbolic link to external of the
>>>>>>> container image.
>>>>>>>
>>>>>>> The question came up, is there a way to use SELinux to prevent
>>>>>>> this. And
>>>>>>> sadly the answer right now is no, because we have no way to know
>>>>>>> what
>>>>>>> the label of the process attempting to update the container file
>>>>>>> system
>>>>>>> is running as.  Usually it will be running as unconfined_t.
>>>>>>>
>>>>>>> One idea would be to add a rule to policy that control the
>>>>>>> following of
>>>>>>> symbolic links to only those specified in policy.
>>>>>>>
>>>>>>>
>>>>>>> Something like
>>>>>>>
>>>>>>> SPECIALRESTRICTED TYPE container_file_t
>>>>>>>
>>>>>>> allow container_file_t container_file_t:symlink follow;
>>>>>>>
>>>>>>> Then if a process attempted to copy content onto a symbolic link
>>>>>>> from
>>>>>>> container_file_t to a non container_file_t type, the kernel would
>>>>>>> deny
>>>>>>> access.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>
>>>>>> SELinux would prevent it if you didn't allow unconfined_t (or other
>>>>>> privileged domains) to follow untrustworthy symlinks (e.g. don't
>>>>>> allow
>>>>>> unconfined_t container_file_t:lnk_file read; in the first place).
>>>>>> That's the right way to prevent it.
>>>>>>
>>>>>> Trying to apply a check between symlink and its target as you suggest
>>>>>> is problematic; we don't generally have them both at the same point.
>>>>>> If we are allowed to follow the symlink, we read its contents and
>>>>>> perform a path walk on that, and that could be a multi-component
>>>>>> pathname lookup that itself spans further symlinks, mount points,
>>>>>> etc.  I think that would be challenging to support in the kernel,
>>>>>> subject to races, and certainly would require changes outside of just
>>>>>> SELinux.
>>>>>>
>>>>>> If you truly cannot impose such restrictions on unconfined_t, then
>>>>>> maybe podman should run in its own domain.
>>>>>>
>>>>> This is not an issue with just podman.  Podman can mount the image and
>>>>> the tools can just read/write content into the mountpoint.
>>>>>
>>>>> I thought I recalled a LSM that prefented symlink attacks when users
>>>>> would link a file in the homedir against /etc/shadow and then
>>>>> attempt to
>>>>> get the admin to modify the file in his homedir?
>>>>>
>>>>> I was thinking that if that existed we could build more controls on it
>>>>> based on Labels rather then just UIDs matching.
>>>>
>>>> Not sure if you are thinking of symlink attacks or hard link attacks.
>>>> SELinux supports preventing the former by restricting the ability to
>>>> follow symlinks based on lnk_file read permission, so you can prevent
>>>> trusted processes from following untrustworthy symlinks.  SELinux
>>>> supports preventing the latter by restricting the ability to create
>>>> hard links to unauthorized files.  But you need to write your policies
>>>> in a manner that leverages that support, and a fully unconfined domain
>>>> isn't going to be protected via SELinux by definition; ideally you'd
>>>> be phasing out unconfined altogether like Android did.  Modern kernels
>>>> also have the /proc/sys/fs/protected_hardlinks and
>>>> /proc/sys/fs/protected_symlinks settings, which restrict based on UID,
>>>> but the symlink checks aren't based on the target of the symlink
>>>> either.
>>>
>>> Android does not have an Admin, so it is a lot easier for them.  But not
>>> going to get into that now.  I obviously understand how SELinux works.
>>> But perhaps I am looking for something differntly.
>>>
>>> This link defines pretty close to what I would want, but extended for
>>> labels rather then just UIDS.
>>>
>>> https://sysctl-explorer.net/fs/protected_symlinks/
>>>
>>>
>>>> A long-standing class of security issues is the symlink-based
>>>> time-of-check-time-of-use race, most commonly seen in world-writable
>>>> directories like /tmp. The common method of exploitation of this flaw
>>>> is to cross privilege boundaries when following a given symlink (i.e.
>>>> a **PRIVILEGED** process follows a symlink belonging **PROVIDED BY
>>>> OTHERS**). For a likely incomplete list of hundreds of examples across
>>>> the years, please see:
>>>> http://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
>>>>
>>>> When set to “0”, symlink following behavior is unrestricted.
>>>>
>>>> When set to “1” symlinks are permitted to be followed only when
>>>> outside a sticky world-writable directory **WE COULD POTENTIALLY SET
>>>> THIS OR SOME OTHER FLAG**, or when the **LABEL** of the symlink and
>>>> follower match, or when the directory **LABEL** matches the symlink’s
>>>> **LABEL**.
>>>>
>>>> This protection is based on the restrictions in Openwall and
>>>> grsecurity.
>>>>
>>
>> That's the /proc/sys/fs/protected_symlinks feature I mentioned in my
>> email above.  It isn't based on the target of the symlink; it is only
>> based on the attributes of the follower process (e.g. root), the
>> attributes of the parent directory containing the symlink (e.g. /tmp),
>> and the attributes of the symlink file (e.g. /tmp/foo -> /etc/shadow).
>> At no point is it checking anything about the target of the symlink,
>> e.g. /etc/shadow.  If dwalsh creates a symlink under /tmp (ln -s
>> /etc/shadow /tmp/foo) and root tries to follow /tmp/foo, then that
>> will fail because 1) the process fsuid (root) != the /tmp/foo symlink
>> owner (dwalsh), and 2) /tmp is a sticky and world-writable directory,
>> and 3) the /tmp directory owner (root) != the /tmp/foo symlink owner
>> (dwalsh). Note that conditions (2) and (3) render the check useless
>> for your use case, since you want to prevent following any symlinks
>> writable by container processes in any directory within the container
>> filesystem, so the directory need not be world-writable/sticky and the
>> parent directory UID/label might be identical to the symlink UID/label.
> We we are mounting the file system (Most of the time), So we could add a
> flag to indicate that this is a protected file system.

You are effectively already doing that by mounting with a context mount 
that assigns container_file_t or whatever type to the filesystem.  You 
don't need something new there.

>>
>>
>> The existing SELinux lnk_file read permission check enables you to
>> apply stronger label-based controls to all symlinks within the
>> container filesystem, not just ones in /tmp-like directories.  Don't
>> allow unconfined_t or any other privileged domain read permission to
>> container_file_t:lnk_file (or preferably to any file type for which
>> :lnk_file create is allowed to container process domains), and you'll
>> never have to worry about them following a symlink writable by a
>> container process.  This of course assumes that the container
>> filesystem is always labeled with a type that is untrusted, whether
>> via mount contexts or actual labels.
> 
> But we want to allow domains to follow container_file_t links that point
> to container_file_t objects.  Just not follow them if they point to
> other types.  This means there is no Protection that I could write to a
> domain like unconfined_t to say only follow links when the types match.
> Or the types have allow rules.

You really don't want programs on the host OS that are acting on a 
container filesystem to ever follow any symlinks within it.  It just 
isn't a good idea; even if you limit it to intra-container symlinks, 
then an attacker could use the host process to overwrite some file 
within the container that wasn't directly writable by him.

In any event, I don't know how one would implement a check between the 
symlink and its target; you'd have to save the symlink information until 
you reach the final target and then call a hook with both of them.  And 
what if there are multiple symlinks in that path?  Symlinks to symlinks?




