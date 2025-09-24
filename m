Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB941FDD
	for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738734; cv=none; b=HIEw0qsyn5Uevio08+5fbmZXeOREUcccMn7KDjWUjrw8PxDJKlCsKLGmMNbZhkQafBpHW9kyN1mF2wZP1VuJo1ttzZQszyvPODjYIL7ZKLKvXH9ljPOcXrlb82DQya+rAhhLsgIxkMA5wYyHBkZOwP8lR7zXR2M7GgXU6s4FJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738734; c=relaxed/simple;
	bh=Lb4q+lVPZphOzuD6MOvDiQNQpslhZLsZL8V9AQaBLhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8RU9+O6/3GFZYBVxvWZWyPzgqWCWDykI9aQ93yDVXtzmjGWtODwDr7CHd3gpoER2MrnL9RXc365OxZaTwYNhNRh9TTB401M9vNzLnORQSxApAeqmtqJyDs7cOXgRxJ67pWsrelBKvTjsw5ppoJlh19XZxkz31/zkLDjvbTURpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MaryB8GE; arc=none smtp.client-ip=66.163.184.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MaryB8GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758738725; bh=+NUBtN0Xnl93f5fxCIE1YYj5P8zbT4cUyq3B3IZmlxI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MaryB8GEmHuqK938PBRhGEc9iJf0BKbmFHEWb1fweSdP0rhwQFm/aQY3VQgAMwodGi3zV3Y/kLwrD32+XHsC80As+taH8/ATenxBVunoDY90ikWhpv1PlIA1mSYDavumDrIrWrK3Od7dBMNWMmKMS4o54b+dw8Fzmq3p2wjHldhW204sLsmSUGfrY2qTyzcewLpNOcUILf4ifs0G03+YZI/Frrv4vaBB/iCY6P2QQCuJ4d5aYiZduiRPSAolX5f4Qk6U0bhv3E6jP/w3aoAZiLeuRgDsOM2I4fZsRM1EcMo6+b0sgPLepRLCf1tL6SKaBKgUSA+6YbJpYULgiZdK2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758738725; bh=yHr0RjeaSsFYBCdYmnMyNMbMX5G6eJV6G4OZUtMswt9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=B13aWQcPl8w3c8tBMQv8ld/ficesXaP+6rXjdWTC/9JgtDA6cJL37pCmp3LpBd+TYi5YKwKEQn7ZFSMqws1eTEvsdg31l4u06zUCupVskgDRbODyFlMuUJKN6HoP8xwIH8sqPl4vVwbV9wAOI+47gglC6/jfKymxBcVUHsKvV7wGgF9Y1TQ32Crv1CEY9xIb7G351bgKXMf9MFgTo/++Il3dvNsUuywSgjG7wihb/XAoxtWlLx66CAa79NxUFjJz0qRZX1WqBiAGeB5qs+YjyXdv6q9Ti69776wITPCP44T/p8SfkhAM4/XNV7JpSQAX1nqMdYCV6JOrQEttDePNVQ==
X-YMail-OSG: AfuQRXUVM1nbm1Tezfpl5G_I6KgWpAeFrVczwhHwTqsH7AIrImKGeetvaFL.Ygj
 sTK1468b0xCx4KgVNugvHbUmk91fzQQ4kmLnMvIPTFn8jEXzdNIjRRuATR_hBitJZK7rI6yPX66M
 Ohw0kf1jgeul2tSwzOrAq2rfFEwUU3CD6TVs_2S21NsEE7nHZZr2REQMS3vInX_rfavhBdSeQZ5c
 hgQUkD85FYrX7sDbUSmrs0oXgiOxrf4Q4jfWL5GhO4ytJ17TJjt3pojywF8zZYUAYYU_pRHY440Z
 oPiVCxd7KoGQ8xbVo_bYqGy9g54LL_zWOSVqaU9rFdH65TMQMUGSpAnPeF1CKwdQ3r5gneeW304p
 lf8iQqAi.8_N4r._rhfZCZ3uCJEkED944b6k1eNws8h1VyMCQ6YHytpxhsGWTVTS7HF8P.gXodQS
 LKB0TIM.3G.nprS.qvnQPGCdqKz5zmRX.9PpXXfq.QnYis8wXqRppcoM3HYEHflZWkMGcE1nfRbh
 WmCcaR46YozmvRgmL97UYjCrAe8GGJpO5Vm5k486ycs_XY_yfJmBisFGE6va.D8Yj1vtnCcYp8nx
 rydLm37F19.PKDFLXYZd.sL69Nc_R5h1RoG8UrG9k4EXTQfnvbVZuDXmqO6nFM49OUfbLUpSG2U0
 _GW0rtpv_MmoibLmulMgngnKHqJ3qRFqYia5cE5HitPll9tZ.zkGXwEK.pjoxRJangsPppQnEkd0
 VV70t.IOPvMVuPIlGb1sVYgTjVlLNIFwoID1vi3uk9umpWStIwN9PSMZbbs1x_FuXzmay71TZONc
 pZrwxio7wIwrQ6dbbUI1td3XaFRIH1UC3asH9stF4ezLgE5W1NfxtEkCHa7Mino1u3nSoYwiCXrp
 L7w9rJQJDn.HNVDX_bBw9lxbJtlo5LEkNi8Tku9zPMFGmFzfmWNbWqIer3s9E2_OmcwAh2_P0egy
 7BGs9zdLXLgKVsTfMxGQkKTZz.FkTNjoCxaM4orvnyZMvKCsM63IErfTrcAz_j8kXiXckLW8n1Ow
 Uc1fZzwL8Peg7nX6UZ9L41w5cvs8e8MOa_9IhpQVCbVuR4tdmUKesK7WFdI.1UbJkARi95Fwq.BC
 RRoPGdkOIjkwyLG6tHMUODLC_HcYgSR8pxe4J3Z14TuvwxhcJC6JrpTs8p.gJjKrR6Opf_FlX0C7
 oKM0pY9Yk7aIMi69FuqvGXBevIjgT6QtLp8TrmfGRodnu6FjHP9hl39oOvn2hVzxNF1suoR56Gb5
 sNq_4CpCL8OIGfE_uiJVpBXekYW25nuhsmYtTmxkLWnaGHO3u4eoUYpM5T9gPd2qUBq24kzS2Zcf
 tZ.ZX5tjykB_gt82ohqoXSbyZFJ.O0RypNLCMXaFW4akHenep4VPkvqvUOwFy4Q7UTvCWl5hjwB9
 V9p306h_NohnaOIgpuv2Toq01uhbjfuR2ojVdilC2kmMJyBhN2bFb6tQf.fCBsGM0FIX5Dq8Ketg
 0Dk6hLtpVVeXKyCl4mo0rOkSGTmlg6ufnAjnHEwqxPc.TwO22NgL_H4Uwd6I3.KnFtjYzXLNZHiX
 Fkrl4jm.HIaY.EQxdv04zKxDg5VmYMZToPF4xBA_d2hmI1XnjkWw.a0iXLiXmiyl741h7snG6EML
 t7jLSBkGZpddCR7qymsqVXkDydiDMgvc6op4WxTyc6WWeG0MBSgoxbcWSvoyy8XRy1nGw6cDE7Lu
 igwkeGU9Fm8CuVbD4xfBBqb5ilwc3ZzFHhu_r8vaXd_t85PptRFaMdgS0OTI6miszizxLi6QDJtT
 ra493yjlZOg779JQ9qOCK04dy_3Xc1Zz9DoEKzgdm14EWbyXmmG3sbpU58YsM6Mu5Su7mORJR9by
 CwlO6VeKES1dRhw2f.tdCBOso6Hhxvjfg1M1xlz0J44Q4NO6T0vcvxk44L_8aE6vBgiHmf8GHT4v
 nR3ihc6y.ntZHvY2_TQI75uu6rzk_hoXUF5skuhplcorHzd7h02hU26KMw0Ztqzuwli06B0xS9Ky
 XGmroUT7wjIJ4joCkZlXh5sifiXHj_BiF1lKuc3D_sKeNYdbLMoA4.VAMLzZ8Hd1QhBuZPE4ZWF0
 JycAY86etDhQAxRgcjWr3usIyYTNi1lJDDdMBY2azR6hxApeVzdqMJGl597WpDLtyuoToWEn2Kkw
 Afwsz5XDvPkmP9GrY4zi7JZM_tF3PuGINf0ozcnq0p20K_fKKMS_2l1IdpXYKsEGpFYG2w9MNqbC
 sgJqBvPh3WW6HuD5XVfqPEdmdjz1apenmteXjgSPOjxp1.Lu8DJHm.QiiqrBtCCUSO2iVswi8pAG
 hcKEa_Ab7._FAVNk46ojWVg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7dd892ba-8a0d-4f72-b3ff-b20eec388a20
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Sep 2025 18:32:05 +0000
Received: by hermes--production-gq1-6f9f7cb74b-f2wdk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fd1bd4b5e458fcf0f01d726c0b00a304;
          Wed, 24 Sep 2025 18:11:47 +0000 (UTC)
Message-ID: <7cb1818a-72ab-4e03-90c9-6195ccf5f249@schaufler-ca.com>
Date: Wed, 24 Sep 2025 11:11:44 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire
 it up for SELinux
To: "Dr. Greg" <greg@enjellic.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 paul@paul-moore.com, omosnace@redhat.com, john.johansen@canonical.com,
 serge@hallyn.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
 <20250924080840.GA16185@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250924080840.GA16185@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24485 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/24/2025 1:08 AM, Dr. Greg wrote:
> On Thu, Sep 18, 2025 at 09:59:05AM -0400, Stephen Smalley wrote:
>
> Good morning, I hope the week is going well for everyone.
>
>> RFC-only, will ultimately split the LSM-only changes to their own
>> patch for submission. I have now tested this with the corresponding
>> selinux userspace change that you can find at
>> https://lore.kernel.org/selinux/20250918135118.9896-2-stephen.smalley.work@gmail.com/
>> and also verified that my modified systemd-nspawn still works when
>> starting containers with their own SELinux namespace.
>>
>> This defines a new LSM_ATTR_UNSHARE attribute for the
>> lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
>> the underlying function for unsharing the SELinux namespace. As with
>> the selinuxfs interface, this immediately unshares the SELinux
>> namespace of the current process just like an unshare(2) system call
>> would do for other namespaces. I have not yet explored the
>> alternatives of deferring the unshare to the next unshare(2),
>> clone(2), or execve(2) call and would want to first confirm that doing
>> so does not introduce any issues in the kernel or make it harder to
>> integrate with existing container runtimes.
>>
>> Differences between this syscall interface and the selinuxfs interface
>> that need discussion before moving forward:
>>
>> 1. The syscall interface does not currently check any Linux capability
>> or DAC permissions, whereas the selinuxfs interface can only be set by
>> uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
>> capability or DAC check should apply to this syscall interface and if
>> any, add the checks to either the LSM framework code or to the SELinux
>> hook function.
>>
>> Pros: Checking a capability or DAC permissions prevents misuse of this
>> interface by unprivileged processes, particularly on systems with
>> policies that do not yet define any of the new SELinux permissions
>> introduced for controlling this operation. This is a potential concern
>> on Linux distributions that do not tightly coordinate kernel updates
>> with policy updates (or where users may choose to deploy upstream
>> kernels on their own), but not on Android.
>>
>> Cons: Checking a capability or DAC permissions requires any process
>> that uses this facility to have the corresponding capability or
>> permissions, which might otherwise be unnecessary and create
>> additional risks. This is less likely if we use a capability already
>> required by container runtimes and similar components that might
>> leverage this facility for unsharing SELinux namespaces.
>>
>> 2. The syscall interface checks a new SELinux unshare_selinuxns
>> permission in the process2 class between the task SID and itself,
>> similar to other checks for setting process attributes. This means
>> that:
>>     allow domain self:process2 *; -or-
>>     allow domain self:process2 ~anything-other-than-unshare_selinuxns; -or-
>>     allow domain self:process2 unshare_selinuxns;
>> would allow a process to unshare its SELinux namespace.
>>
>> The selinuxfs interface checks a new unshare permission in the
>> security class between the task SID and the security initial SID,
>> likewise similar to other checks for setting selinuxfs attributes.
>> This means that:
>>     allow domain security_t:security *; -or-
>>     allow domain security_t:security ~anything-other-than-unshare; -or-
>>     allow domain security_t:security unshare;
>> would allow a process to unshare its SELinux namespace.
>>
>> Technically, the selinuxfs interface also currently requires open and
>> write access to the selinuxfs node; hence:
>>     allow domain security_t:file { open write };
>> is also required for the selinuxfs interface.
>>
>> We need to decide what we want the SELinux check(s) to be for the
>> syscall and whether it should be more like the former (process
>> attributes) or more like the latter (security policy settings). Note
>> that the permission name itself is unimportant here and only differs
>> because it seemed less evident in the process2 class that we are
>> talking about a SELinux namespace otherwise.
>>
>> Regardless, either form of allow rule can be prohibited in policies
>> via neverallow rules on systems that enforce their usage
>> (e.g. Android, not necessarily on Linux distributions).
>>
>> 3. The selinuxfs interface currently offers more functionality than I
>> have implemented here for the sycall interface, including:
>>
>> a) the ability to read the selinuxfs node to see if your namespace has
>> been unshared, which should be easily implementable via
>> lsm_get_self_attr(2).  However, questions remain as to when that
>> should return 1 versus 0 (currently returns 1 whenever your namespace
>> is NOT the initial SELinux namespace, useful for the testsuite to
>> detect it is in a child, but could instead be reset to 0 by a
>> subsequent policy load to indicate completion of the setup of the
>> namespace, thus hiding from child processes that they are in a child
>> namespace once its policy has been loaded).
>>
>> b) the abilities to get and set the maximum number of SELinux
>> namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
>> maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
>> node). These could be left in selinuxfs or migrated to some other LSM
>> management APIs since they are global in scope, not per-process
>> attributes.
> We had a number of exchanges regarding LSM namespacing in the thread
> that Paul Moore started on this issue:
>
> https://lore.kernel.org/linux-security-module/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/
>
> The one issue that seemed to achieve universal consensus was that
> every LSM was going to have different requirements for namespacing.
>
> At the risk of playing devil's advocate, this seems to raise the
> question as to whether or not there is a need to have a common API for
> requesting security namespace separation or leave the issue to LSM
> specific implementations.

It does raise the question. I, for one, would like to see the
LSM infrastructure move toward being a bit more helpful regarding
things that the various LSMs do that can be done commonly. One
example of this is moving blob allocations out of the individual
modules. Another is the introduction of lsm properties
(struct lsm_prop) to replace the SELinux specific secid model.
When there where five LSMs total, only two to be used at a time,
leaving everything to the individual module was mildly tolerable.
Today we see that there's a heap of waste in data management and
duplicate code when even a base Fedora uses eight at a time.

I don't see this as a matter of taste. I see this as a case where
we can make the LSM infrastructure a little less chaotic.

> The primary rationale for some modicum of centralized infrastructure
> would seem to be to have a system call rather than an LSM specific
> pseudo-filesystem interface to control security namespaces.  Since
> creating a system call interface is going to lock the API in stone it
> would seem that we would want to get this right, or at least as
> generic as possibe.

OK.

> So some comments to that end.
>
> If we use the lsm_set_self_attr(2) system call as our approach, the
> namespace separation process needs to be split into two separate
> calls.  One to request the creation of a namespace and a second call
> to request that the process join the new namespace.
>
> This is required in order to support the ability for an orchestration
> process to load a policy or model and have it in place before the new
> namespace is allowed to enforce the policy or model.
>
> So we would need something like an LSM_ATTR_UNSHARE_INIT as well as
> the LSM_ATTR_UNSHARE attribute.

Stephen does not require this in his SELinux implementation.
Nor did the abandoned Smack namespaces. On the other hand, I
can see where a system with a dynamic security configuration
such as yours might indeed need this.

> So the model would be for a process to issue an LSM_ATTR_UNSHARE_INIT
> call to create the new security context namespace.  That namespace
> context can then be configured through either an LSM specific
> pseudo-filesystem interface or alternatively through additional calls
> to lsm_set_self_attr(2).
>
> Once the configuration process is complete, the process would be set
> free in its new namespace with the LSM_ATTR_UNSHARE attribute.
>
> Separating from a security policy namespace to a new namespace will be
> one of the most security sensitive operations that a system can
> execute.  As such it has to be gated by some type of security control.
>
> At a minimum this needs to be uid-0 or posession of CAP_MAC_ADMIN.
> Given the current LSM concept of stacking, there needs to be an LSM
> security hooks assigned, so as to give all of the LSM's an opportunity
> to accept or deny the attribute operations.

You've got paradigm conflict developing here. SELinux (for example)
would prefer to make its own decisions regarding "security relevant"
operations. Landlock, which is "unprivileged", ought to be able to
perform its namespace operations without undue interference. While
I generally think that all LSMs ought to integrate with capabilities,
but I have to admit to the status quo.

> For example, it would seem entirely reasonable that the lockdown LSM
> may want to deny the ability to create any departures from the current
> security configuration.

Bluntly, that's not gonna happen. It would break Smack for one thing.

> Making this generic for any security namespace will require some
> additional plumbing, most notably the ability for any LSM to register
> for the ability to receive namespace event notifications.  If we
> create new security_task_secns_init() and
> security_task_secns_unshare() hooks we could use those as both
> notification and security control mechanisms.
>
> So lots of details to discuss but the above should be about the most
> generic implementation that can be leveraged by all of the LSM's.
>
> Comments/suggestion welcome.
>
> Have a good remainder of the week.

If I must. :)

>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
