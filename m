Return-Path: <SRS0=W683=UJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10B4C31E43
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C7720859
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 17:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFJRB1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:01:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfFJRB1 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 10 Jun 2019 13:01:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8A38C057EC6;
        Mon, 10 Jun 2019 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-64.rdu2.redhat.com [10.10.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D25D819C59;
        Mon, 10 Jun 2019 17:01:22 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: New Container vulnerability could potentially use an SELinux fix.
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Miloslav Trmac <mitr@redhat.com>, selinux@vger.kernel.org
References: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
 <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
 <d07bdda3-264b-daf4-5896-6e7a7c68f63a@redhat.com>
 <75f00b22-390a-8f7b-5f84-15c64d17eb89@tycho.nsa.gov>
 <3957e38f-e62b-9800-da58-33ccb351a849@redhat.com>
 <53479d32-a04d-2217-c4dd-9ce34bbba8ef@tycho.nsa.gov>
 <e8b8b026-0409-098b-bd2a-20ed43c4d10b@redhat.com>
 <df0e048f-ef5f-8a43-81cb-3d3f6cf10230@tycho.nsa.gov>
From:   Daniel Walsh <dwalsh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dwalsh@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFsaqOEBCADBSnZCZpi262vX8m7iL/OdHKP9G9dhS28FR60cjd8nMPqHDNhQJBjLMZra
 66L2cCIEhc4HEItail7KU1BckrMc4laFaxL8tLoVTKHZwb74n2OcAJ4FtgzkNNlB1XJvSwC/
 909uwt7cpDqwXpJvyP3t17iuklB1OY0EEjTDt9aU4+0QjHzV18L4Cpd9iQ4ksu+EHT+pjlBk
 DdQB+hKoAjxPl11Eh6pZfrAcrNWpYBBk0A3XE9Jb6ghbmHWltNgVOsCa9GcswJHUEeFiOup6
 J5DTv6Xzwt0t6QB8nIs+wDJH+VxqAXcrxscnAhViIfGGS2AtxzjnVOz/J+UZPaauIGXTABEB
 AAG0LERhbmllbCBKIFdhbHNoIChGb3IgR2l0KSA8ZHdhbHNoQHJlZGhhdC5jb20+iQE4BBMB
 AgAiBQJbGqjhAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCi35Adq+LAKHuJB/98
 nZB5RmNjMWua4Ms8q5a1R9XWlDAb3mrST6JeL+uV/M0fa18e2Aw4/hi/WZHjAjoypLmcuaRx
 GeCbC8iYdpfRDUG79Y956Qq+Vs8c6VfNDMY1mvtfb00eeTaYoOCu0Aa9LDeR9iLKh2g0RI+N
 Zr3EU45RxZdacIs1v6mU8pGpyUq/FvuTGK9GzR9d1YeVCuSpQKN4ckHNZHJUXyk0vOZft1oO
 nSgLqM9EDWA+yz1JLmRYwbNsim7IvfVOav5mCgnKzHcL2mLv8qCnMFZjoQV8aGny/W739Z3a
 YJo1CdOg6zSu5SOvmq9idYrBRkwEtyLXss2oceTVBs0MxqQ/9mLPuQENBFsaqOEBCADDl2hl
 bUpqJGgwt2eQvs0Z0DCx/7nn0hlLfEn4WAv2HqP25AjIRXUX31Mzu68C4QnsvNtY4zN+FGRC
 EfUpYsjiL7vBYlRePhIohyMYU4RLp5eXFQKahHO/9Xlhe8mwueQNwYxNBPfMQ65U2AuqxpcS
 scx4s5w208mhqHoKz6IB2LuKeflhYfH5Y1FNAtVGHfhg22xlcAdupPPcxGuS4fBEW6PD/SDf
 Y4HT5iUHsyksQKjM0IFalqZ7YuLfXBl07OD2zU7WI9c3W0dwkvwIRjt3aD4iAah544uOLff+
 BzfxWghXeo80S2a1WCL0S/2qR0NVct/ExaDWboYr/bKpTa/1ABEBAAGJAR8EGAECAAkFAlsa
 qOECGwwACgkQot+QHaviwCi2hgf/XRvrt+VBmp1ZFxQAR9E6S7AtRT8KSytjFiqEC7TpOx3r
 2OZ4gZ3ZiW4TMW8hS7aYRgF1uYpLzl7BbrCfCHfAWEcXZ+uG8vayg8G/mLAcNlLY+JE76ATs
 53ziEY9R2Vb/wLMFd2nNBdqfwGcRH9N9VOej9vP76nCP01ZolY8Nms2hE383/+1Quxp5EedU
 BN5W5l7x9riBJyqCA63hr4u8wNsTuQgrDyhm/U1IvYeLtMopgotjnIR3KiTKOElbppLeXW3w
 EO/sQTPk+vQ4vcsJYY9Dnf1NlvHE4klj60GHjtjitsBEHzdE7s+J9FOxPmt8l+gMogGumKpN
 Y4lO0pfTyg==
Organization: Red Hat
Message-ID: <ccbba464-da3b-e10b-a5b4-65adf9126d4c@redhat.com>
Date:   Mon, 10 Jun 2019 13:01:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <df0e048f-ef5f-8a43-81cb-3d3f6cf10230@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 10 Jun 2019 17:01:25 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/10/19 11:00 AM, Stephen Smalley wrote:
> On 6/10/19 10:37 AM, Daniel Walsh wrote:
>> On 6/10/19 10:08 AM, Stephen Smalley wrote:
>>> On 6/8/19 10:08 AM, Daniel Walsh wrote:
>>>> On 6/7/19 5:26 PM, Stephen Smalley wrote:
>>>>> On 6/7/19 5:06 PM, Daniel Walsh wrote:
>>>>>> On 6/7/19 12:44 PM, Stephen Smalley wrote:
>>>>>>> On 6/7/19 11:42 AM, Daniel Walsh wrote:
>>>>>>>> We have periodic vulnerablities around bad container images having
>>>>>>>> symbolic link attacks against the host.
>>>>>>>>
>>>>>>>> One came out last week about doing a `podman cp`
>>>>>>>>
>>>>>>>> Which would copy content from the host into the container.  The
>>>>>>>> issue
>>>>>>>> was that if the container was running, it could trick the
>>>>>>>> processes
>>>>>>>> copying content into it to follow a symbolic link to external
>>>>>>>> of the
>>>>>>>> container image.
>>>>>>>>
>>>>>>>> The question came up, is there a way to use SELinux to prevent
>>>>>>>> this. And
>>>>>>>> sadly the answer right now is no, because we have no way to know
>>>>>>>> what
>>>>>>>> the label of the process attempting to update the container file
>>>>>>>> system
>>>>>>>> is running as.  Usually it will be running as unconfined_t.
>>>>>>>>
>>>>>>>> One idea would be to add a rule to policy that control the
>>>>>>>> following of
>>>>>>>> symbolic links to only those specified in policy.
>>>>>>>>
>>>>>>>>
>>>>>>>> Something like
>>>>>>>>
>>>>>>>> SPECIALRESTRICTED TYPE container_file_t
>>>>>>>>
>>>>>>>> allow container_file_t container_file_t:symlink follow;
>>>>>>>>
>>>>>>>> Then if a process attempted to copy content onto a symbolic link
>>>>>>>> from
>>>>>>>> container_file_t to a non container_file_t type, the kernel would
>>>>>>>> deny
>>>>>>>> access.
>>>>>>>>
>>>>>>>> Thoughts?
>>>>>>>
>>>>>>> SELinux would prevent it if you didn't allow unconfined_t (or other
>>>>>>> privileged domains) to follow untrustworthy symlinks (e.g. don't
>>>>>>> allow
>>>>>>> unconfined_t container_file_t:lnk_file read; in the first place).
>>>>>>> That's the right way to prevent it.
>>>>>>>
>>>>>>> Trying to apply a check between symlink and its target as you
>>>>>>> suggest
>>>>>>> is problematic; we don't generally have them both at the same
>>>>>>> point.
>>>>>>> If we are allowed to follow the symlink, we read its contents and
>>>>>>> perform a path walk on that, and that could be a multi-component
>>>>>>> pathname lookup that itself spans further symlinks, mount points,
>>>>>>> etc.  I think that would be challenging to support in the kernel,
>>>>>>> subject to races, and certainly would require changes outside of
>>>>>>> just
>>>>>>> SELinux.
>>>>>>>
>>>>>>> If you truly cannot impose such restrictions on unconfined_t, then
>>>>>>> maybe podman should run in its own domain.
>>>>>>>
>>>>>> This is not an issue with just podman.  Podman can mount the
>>>>>> image and
>>>>>> the tools can just read/write content into the mountpoint.
>>>>>>
>>>>>> I thought I recalled a LSM that prefented symlink attacks when users
>>>>>> would link a file in the homedir against /etc/shadow and then
>>>>>> attempt to
>>>>>> get the admin to modify the file in his homedir?
>>>>>>
>>>>>> I was thinking that if that existed we could build more controls
>>>>>> on it
>>>>>> based on Labels rather then just UIDs matching.
>>>>>
>>>>> Not sure if you are thinking of symlink attacks or hard link attacks.
>>>>> SELinux supports preventing the former by restricting the ability to
>>>>> follow symlinks based on lnk_file read permission, so you can prevent
>>>>> trusted processes from following untrustworthy symlinks.  SELinux
>>>>> supports preventing the latter by restricting the ability to create
>>>>> hard links to unauthorized files.  But you need to write your
>>>>> policies
>>>>> in a manner that leverages that support, and a fully unconfined
>>>>> domain
>>>>> isn't going to be protected via SELinux by definition; ideally you'd
>>>>> be phasing out unconfined altogether like Android did.  Modern
>>>>> kernels
>>>>> also have the /proc/sys/fs/protected_hardlinks and
>>>>> /proc/sys/fs/protected_symlinks settings, which restrict based on
>>>>> UID,
>>>>> but the symlink checks aren't based on the target of the symlink
>>>>> either.
>>>>
>>>> Android does not have an Admin, so it is a lot easier for them. 
>>>> But not
>>>> going to get into that now.  I obviously understand how SELinux works.
>>>> But perhaps I am looking for something differntly.
>>>>
>>>> This link defines pretty close to what I would want, but extended for
>>>> labels rather then just UIDS.
>>>>
>>>> https://sysctl-explorer.net/fs/protected_symlinks/
>>>>
>>>>
>>>>> A long-standing class of security issues is the symlink-based
>>>>> time-of-check-time-of-use race, most commonly seen in world-writable
>>>>> directories like /tmp. The common method of exploitation of this flaw
>>>>> is to cross privilege boundaries when following a given symlink (i.e.
>>>>> a **PRIVILEGED** process follows a symlink belonging **PROVIDED BY
>>>>> OTHERS**). For a likely incomplete list of hundreds of examples
>>>>> across
>>>>> the years, please see:
>>>>> http://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
>>>>>
>>>>> When set to “0”, symlink following behavior is unrestricted.
>>>>>
>>>>> When set to “1” symlinks are permitted to be followed only when
>>>>> outside a sticky world-writable directory **WE COULD POTENTIALLY SET
>>>>> THIS OR SOME OTHER FLAG**, or when the **LABEL** of the symlink and
>>>>> follower match, or when the directory **LABEL** matches the symlink’s
>>>>> **LABEL**.
>>>>>
>>>>> This protection is based on the restrictions in Openwall and
>>>>> grsecurity.
>>>>>
>>>
>>> That's the /proc/sys/fs/protected_symlinks feature I mentioned in my
>>> email above.  It isn't based on the target of the symlink; it is only
>>> based on the attributes of the follower process (e.g. root), the
>>> attributes of the parent directory containing the symlink (e.g. /tmp),
>>> and the attributes of the symlink file (e.g. /tmp/foo -> /etc/shadow).
>>> At no point is it checking anything about the target of the symlink,
>>> e.g. /etc/shadow.  If dwalsh creates a symlink under /tmp (ln -s
>>> /etc/shadow /tmp/foo) and root tries to follow /tmp/foo, then that
>>> will fail because 1) the process fsuid (root) != the /tmp/foo symlink
>>> owner (dwalsh), and 2) /tmp is a sticky and world-writable directory,
>>> and 3) the /tmp directory owner (root) != the /tmp/foo symlink owner
>>> (dwalsh). Note that conditions (2) and (3) render the check useless
>>> for your use case, since you want to prevent following any symlinks
>>> writable by container processes in any directory within the container
>>> filesystem, so the directory need not be world-writable/sticky and the
>>> parent directory UID/label might be identical to the symlink UID/label.
>> We we are mounting the file system (Most of the time), So we could add a
>> flag to indicate that this is a protected file system.
>
> You are effectively already doing that by mounting with a context
> mount that assigns container_file_t or whatever type to the
> filesystem.  You don't need something new there.
>
>>>
>>>
>>> The existing SELinux lnk_file read permission check enables you to
>>> apply stronger label-based controls to all symlinks within the
>>> container filesystem, not just ones in /tmp-like directories.  Don't
>>> allow unconfined_t or any other privileged domain read permission to
>>> container_file_t:lnk_file (or preferably to any file type for which
>>> :lnk_file create is allowed to container process domains), and you'll
>>> never have to worry about them following a symlink writable by a
>>> container process.  This of course assumes that the container
>>> filesystem is always labeled with a type that is untrusted, whether
>>> via mount contexts or actual labels.
>>
>> But we want to allow domains to follow container_file_t links that point
>> to container_file_t objects.  Just not follow them if they point to
>> other types.  This means there is no Protection that I could write to a
>> domain like unconfined_t to say only follow links when the types match.
>> Or the types have allow rules.
>
> You really don't want programs on the host OS that are acting on a
> container filesystem to ever follow any symlinks within it.  It just
> isn't a good idea; even if you limit it to intra-container symlinks,
> then an attacker could use the host process to overwrite some file
> within the container that wasn't directly writable by him.
>
> In any event, I don't know how one would implement a check between the
> symlink and its target; you'd have to save the symlink information
> until you reach the final target and then call a hook with both of
> them.  And what if there are multiple symlinks in that path?  Symlinks
> to symlinks?
>
>
>
>
I would think we would only have to check the source and the final check. 

The problem is lots of processes like dnf, cp, install all deal with
following legitimate symbolic links.  Most of the times processes
outside of the container dealing with the container content, are
installing software.  Having this software fail anytime their is a
symbolic link, is not going to work.

