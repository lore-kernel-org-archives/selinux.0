Return-Path: <SRS0=ZoZM=PZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCBDC43387
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 20:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A8820855
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfAQUam (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:30:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbfAQUam (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 17 Jan 2019 15:30:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D0398AE79;
        Thu, 17 Jan 2019 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.18.25.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC4005883D;
        Thu, 17 Jan 2019 20:30:39 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
To:     Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
 <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
 <CAFqZXNsxVpxXHQ4qOZQpnpck24O5ofskLgU-B0ahbDK8MgxGCA@mail.gmail.com>
 <64977013-e2a5-809d-7a3f-bffbda9276aa@redhat.com>
 <20190117161521.GA50184@devbig004.ftw2.facebook.com>
 <46abb960-f047-c2eb-96a8-72114cc44c86@tycho.nsa.gov>
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
Message-ID: <2ad98c79-c51b-d8a0-01cc-8e8c7ca8fb53@redhat.com>
Date:   Thu, 17 Jan 2019 15:30:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <46abb960-f047-c2eb-96a8-72114cc44c86@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 17 Jan 2019 20:30:42 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/19 11:39 AM, Stephen Smalley wrote:
> On 1/17/19 11:15 AM, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Jan 17, 2019 at 10:01:23AM -0500, Daniel Walsh wrote:
>>> The above comment is correct.  We want to be able to run a container
>>> where we hand it control over a limited subdir of the cgroups hierachy.
>>> We can currently do this and label the content correctly, but when
>>> subdirs of the directory get created by processes inside the container
>>> they do not get the correct label.  For example we add a label like
>>> system_u:object_r:container_file_t:s0 to a directory but when the
>>> process inside of the container creates a fd within this directory the
>>> kernel says the label is the default label for cgroups
>>> system_u:object_r:cgroup_t:s0.  This forces us to write looser policy
>>> that from an SELinux point of view allows a process within the
>>> container
>>> to write anywhere on the cgroup file system, rather then just the
>>> designated directories.
>>
>> Can you please go into a bit more details on why the existing
>> cgroup delegation model isn't enough?
>
> I would hazard a guess that it is because the existing cgroup
> delegation model is based on user IDs and discretionary access control
> (DAC), whereas they are using per-container SELinux security contexts
> and mandatory access control (MAC) to enforce the separation of
> containers irrespective of UID and DAC.  Optimally both would be
> supported by cgroup, as DAC and MAC have different properties and use
> cases.

As Steven said, existing model is DAC.  We have the situation where we
have a "root" process running within a container that is not using User
Namespace.  I want to control that that root process can not write to
anywhere within the cgroup hierarchy based on SELinux controls.   This
is security in depth.  If other mechanisms prevent the process from
writing to other places in cgroups that is great, but I want it also
secured from a MAC Point of view.


