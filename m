Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EA9ECAAA1
	for <selinux@archiver.kernel.org>; Fri,  9 Sep 2022 11:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIILdD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Sep 2022 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIILdC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Sep 2022 07:33:02 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B513B550
        for <selinux@vger.kernel.org>; Fri,  9 Sep 2022 04:32:59 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 289BWvna016068;
        Fri, 9 Sep 2022 20:32:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Fri, 09 Sep 2022 20:32:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 289BWv38016063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Sep 2022 20:32:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <854c05ad-888e-b882-bb97-65f4ca289bc6@I-love.SAKURA.ne.jp>
Date:   Fri, 9 Sep 2022 20:32:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
 <CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/09/09 3:52, Paul Moore wrote:
> At least one of those, Landlock, has been merged upstream and is now
> available in modern released Linux Kernels.  As far as the other LSMs
> are concerned, I don't recall there ever being significant interest
> among other developers or users to warrant their inclusion upstream.
> If the authors believe that has changed, or is simply not true, they
> are always welcome to post their patches again for discussion, review,
> and potential upstreaming.  However, I will caution that it is
> becoming increasingly difficult for people to find time to review
> potential new LSMs so it may a while to attract sufficient comments
> and feedback.

Inclusion into upstream is far from the goal.

> As has been discussed before, this isn't so much an issue with the
> __ro_after_init change, it's really more of an issue of running
> out-of-tree kernel code on pre-built distribution kernels, with
> "pre-built" being the most important part.  It is my understanding
> that if the user/developer built their own patched kernel this would
> not likely be an issue as the out-of-tree LSM could be patched into
> the kernel source.

There always is LSM module which is not enabled in pre-built distribution kernels.
https://bugzilla.redhat.com/show_bug.cgi?id=542986

Even if source code is already available in distribution kernels, as long as
distribution refuses to include into pre-built distribution kernels, it is no
different from the out-of-tree LSM.

The user/developer has to rebuild the whole distribution kernels is an unacceptable
barrier.

>                     The problem comes when the user/developer wants to
> dynamically load their out-of-tree LSM into a pre-built distribution
> kernel, presumably to preserve a level of distribution support.

Not only for preserving the level of distribution support. But also for
allowing immediate updates whenever distribution kernels are updated, and
allowing out of kernel modules (e.g. from AntiVirus, hardware vendors) to be
loaded into pre-built distribution kernels (instead of user/developer rebuilt
distribution kernels).

> Unfortunately, to the best of my knowledge, none of the major
> enterprise Linux distributions will provide support for arbitrary
> third-party kernel modules (it may work, but if something fails the
> user is on their own to triage and resolve).

I know it, especially Red Hat is strict regarding that. Red Hat does not provide
support for rebuilt kernels even with zero changes (e.g. same kernel source code,
same kernel configuration).

Some hardware vendors provide support for their device drivers when used with
RHEL kernel but does not provide support when used with CentOS kernel (not
CentOS Stream), despite there is effectively no difference. Being able to
continue using pre-built distribution kernels is a fatal requirement for users.

> 
> Beyond the support issue, there are likely to be other problems as
> well since the kernel interfaces, including the LSM hooks themselves,
> are not guaranteed to be stable across kernel releases.

That's not a big problem. Loadable LSM modules will be updated as the kernel
interfaces change.

But the combination of "the kernel interfaces does not legally allow loadable LSM modules"
and "distributors do not enable LSMs already available in upstream kernels" and "it is
becoming increasingly difficult for people to find time to review potential new LSMs" and
"it is difficult for users/developers to continue rebuilding distributor kernels only for
enabling LSMs" indicates there is no space for LSMs which are not enabled in pre-built
distribution kernels to survive; it is tantamount to a death sentence.
Legally allowing loadable LSM modules is an answer to current situation.



> 
>> Last 10 years, my involvement with Linux kernel is "fixing bugs" rather than
>> "developing security mechanisms". Changes what I found in the past 10 years are:
>>
>>   As far as I'm aware, more than 99% of systems still disable SELinux.
> 
> I would challenge you to support that claim with data.

Unfortunately, that's an impossible request for me. I worked at a support center
for three years, and I found (from e.g. sosreport) that no system enabled SELinux.
Since I already left the support center, I'm no longer in a position who can
collect statistic data.

>                                                         Granted, we
> are coming from very different LSM backgrounds, but I find that number
> very suspect.  It has been several years since I last looked, but I
> believe the latest published Android numbers would give some support
> to the idea that more than 1% of SELinux based systems are running in
> enforcing (or permissive) mode.  Significantly more.

In know-how manuals developed by the support center, disabling SELinux is the
first action after installation, and people using the support center follow it.
(I personally feel that using SELinux with targeted policy is possible. But
they hate troubles caused by unwanted functionality. And they can't afford
keeping SELinux enabled because nobody can adjust policy for their servers.
If troubles caused by SELinux happen, even I won't be able to provide support
because I'm not in a position to understand and manage the details/usage of
their servers.)

You might wonder how they are protecting their servers without SELinux.
It is a mystery.

But I if recall the days at the support center, I seldom saw servers which
directly face the Internet. Maybe they are using security appliance for servers
facing the Internet, and using RHEL for servers in already secured environment.

Then, the need to enable SELinux remains still low sounds realistic.
For example, telnet and ftp are used even nowadays in some systems.
https://bugzilla.redhat.com/show_bug.cgi?id=1853102
https://bugzilla.redhat.com/show_bug.cgi?id=1914536

But again, I'm not in a position for collecting statistic data.

> 
>>   People use RHEL,
>>   but the reason to choose RHEL is not because RHEL supports SELinux.
> 
> Once again, if you are going to make strong claims such as this,
> please provide data.  I know of several RHEL users that are only able
> to run SELinux based systems as it is the only LSM which meets their
> security requirements.

Sure, there are systems where SELinux is the only choice.
But surely there are systems where SELinux is not the only choice.

> I would caution against confusing the security policy driven access
> controls provided by many in-tree LSMs with out-of-tree antivirus
> software.  They have different goals, different use cases, and
> different user groups (markets).

But due to the above-mentioned death sentence, we currently can't allow
users/developers to use different LSMs which have different goals,
different use cases, and different user groups (markets). Very bad...

