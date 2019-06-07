Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3EAC2BCA1
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88102208C0
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfFGVGo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:06:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbfFGVGn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 7 Jun 2019 17:06:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 202B581DEB;
        Fri,  7 Jun 2019 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 787565D9C6;
        Fri,  7 Jun 2019 21:06:39 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: New Container vulnerability could potentially use an SELinux fix.
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Miloslav Trmac <mitr@redhat.com>, selinux@vger.kernel.org
References: <7ca438c7-4a41-4daa-fc3f-a46a2e0af945@redhat.com>
 <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
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
Message-ID: <d07bdda3-264b-daf4-5896-6e7a7c68f63a@redhat.com>
Date:   Fri, 7 Jun 2019 17:06:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9313f92a-46cf-c65c-6cfb-1373917de02b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 07 Jun 2019 21:06:43 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/7/19 12:44 PM, Stephen Smalley wrote:
> On 6/7/19 11:42 AM, Daniel Walsh wrote:
>> We have periodic vulnerablities around bad container images having
>> symbolic link attacks against the host.
>>
>> One came out last week about doing a `podman cp`
>>
>> Which would copy content from the host into the container.  The issue
>> was that if the container was running, it could trick the processes
>> copying content into it to follow a symbolic link to external of the
>> container image.
>>
>> The question came up, is there a way to use SELinux to prevent this. And
>> sadly the answer right now is no, because we have no way to know what
>> the label of the process attempting to update the container file system
>> is running as.  Usually it will be running as unconfined_t.
>>
>> One idea would be to add a rule to policy that control the following of
>> symbolic links to only those specified in policy.
>>
>>
>> Something like
>>
>> SPECIALRESTRICTED TYPE container_file_t
>>
>> allow container_file_t container_file_t:symlink follow;
>>
>> Then if a process attempted to copy content onto a symbolic link from
>> container_file_t to a non container_file_t type, the kernel would deny
>> access.
>>
>> Thoughts?
>
> SELinux would prevent it if you didn't allow unconfined_t (or other
> privileged domains) to follow untrustworthy symlinks (e.g. don't allow
> unconfined_t container_file_t:lnk_file read; in the first place).
> That's the right way to prevent it.
>
> Trying to apply a check between symlink and its target as you suggest
> is problematic; we don't generally have them both at the same point. 
> If we are allowed to follow the symlink, we read its contents and
> perform a path walk on that, and that could be a multi-component
> pathname lookup that itself spans further symlinks, mount points,
> etc.  I think that would be challenging to support in the kernel,
> subject to races, and certainly would require changes outside of just
> SELinux.
>
> If you truly cannot impose such restrictions on unconfined_t, then
> maybe podman should run in its own domain.
>
This is not an issue with just podman.  Podman can mount the image and
the tools can just read/write content into the mountpoint.

I thought I recalled a LSM that prefented symlink attacks when users
would link a file in the homedir against /etc/shadow and then attempt to
get the admin to modify the file in his homedir?

I was thinking that if that existed we could build more controls on it
based on Labels rather then just UIDs matching.

