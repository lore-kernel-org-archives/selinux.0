Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0853BC04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DCF20672
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3MjhhDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DCF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbeLDSAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:00:35 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:41964 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDSAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 13:00:35 -0500
Received: by mail-qk1-f178.google.com with SMTP id 189so10162485qkj.8
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAMY3UdKrzTFmjeyW/kY00s2e3Ui2CCWkIqb3VBRe2s=;
        b=X3MjhhDVzG2mNrKpH7udLZUUlA7NNQmHynAPoungiWW/3LdFke2a1EUcvJXPUDUwtm
         4Tm/zOzzET4sUfmzlqMMp6s56/DSrP9h8ayAeMaYkH8bI2LBZVnkLAczD3599xB67RBD
         W6bic1OHf47dSOTDCfYAmJ7TJKPC3n6tZkj9wxYQ7mCoz1uCLwxoENCAIfIPk/gfes+0
         F/f336My78L3s21mBBHaQhlDuMtXvRFCGvXzzwkdHc7s0YHq14GF+Qlg4Ri+5H8Wc9XX
         cGOWusiwYTbekz1DXbEysILdB6jRwasug+zVObvptMwUOFNzjsqLxFaMtFjfElqc3TCb
         kbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAMY3UdKrzTFmjeyW/kY00s2e3Ui2CCWkIqb3VBRe2s=;
        b=LeCyB9eXVklpHIIoYTTWtx7w3ufQSTrEHI9Len8TF6085Ej5LlNrdR/iSnzYoAxYpb
         Wy0c+L7DUHwJoipAXf303L18WcVRUK1gz1GNNoXjmotdhPiOdRYIG2jZk4g9QlOjyGi6
         CqhAPJ2Pus1O+8A9TeLWDCw0e4cudiApmfisIFs2q7ZuLRDJUIKhe2pFM0TmfViLnZAw
         n0ARZFMU397T6xmzJlLlf1l1ZSl07ug0u8HynRwj+LCcU59vjYVDBhzWzVuYOQrroBPn
         6DqWKjr4sptVoATP5PKrQz9Ed8UkodDRl+FT9pBXsiHbccEWfm1rfTM5JKINfv4F1Oax
         DRmg==
X-Gm-Message-State: AA+aEWaaC8iFdtJHKBK092SjLvAQhKh/sYvSryWeAxuoe23COtz53HgR
        60zbBJbaZkYfi0On4iAzQaH8CpaAgXSFhPrewyU4zVTK
X-Google-Smtp-Source: AFSGD/VfNETkyZ4aauKu9vYVS8K+9a9YMogeCagwpMPGiReBZ5LP5b49PH/HU7+oFYx3jcRI6fyeZEbXTmjDNNJ3AcY=
X-Received: by 2002:a37:7003:: with SMTP id l3mr20263215qkc.80.1543946434178;
 Tue, 04 Dec 2018 10:00:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFSQBhHFcRxUivx+wYRLyD4Z=6sZ4-3VsgtjRiG=+9crtOyTXA@mail.gmail.com>
 <01635e21-f143-d940-ceb1-b95079ddf23b@tycho.nsa.gov> <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
In-Reply-To: <67ce07aa-d88a-5e1d-fa7d-66491ced1714@tycho.nsa.gov>
From:   BMK <bmktuwien@gmail.com>
Date:   Tue, 4 Dec 2018 19:00:23 +0100
Message-ID: <CAFSQBhHMG9cgda3KAo1y6pNWinkKvRAuwTNn6+d3j43Dphozew@mail.gmail.com>
Subject: Re: SELinux logging problem
To:     sds@tycho.nsa.gov
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 5:50 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 12/4/18 11:38 AM, Stephen Smalley wrote:
> > On 12/4/18 11:03 AM, BMK wrote:
> >> Hello,
> >>
> >> I am currently struggling with a strange SELinux problem,
> >> for which I am not able to find an answer by reading the documentation
> >> and researching online.
> >>
> >> The problem is, that some AVC denial log entries seem to get lost in
> >> permissive mode,
> >> in other words, they are not logged...
> >> I've already deactivated all dont audit rules and I know for sure that
> >> the denial actually occurs, because I can trace it via strace...
> >> Although I can't see a corresponding entry in the audit.log.
> >> By the way, in enforcing mode I can see suddenly the missing denial
> >> entry...
> >> If the permissive mode lacks/drops some denials which we can only see
> >> in enforcing mode,
> >> then this would be truly terrible for the policy writers...
> >> Otherwise I am out of ideas, what other things could cause the loss of
> >> SELinux denials...
> >>
> >> I hope you can point me to right direction with this matter and
> >> I thank you in advance for your help.
> >
> > Permissive mode only logs the first instance of a denial by design to
> > avoid flooding the logs with repeated instances of the same denial.  So
> > if you triggered the denial a while ago and repeat the operation, you
> > might not see the denial again.  To be precise, in permissive mode, upon
> > the first denial of a permission, the permission is audited and then
> > added to the AVC entry so that subsequent denials using that cache entry
> > won't keep producing a denial. You can flush the cache to force denials
> > to re-appear by reloading policy (load_policy) or by switching back and
> > forth between permissive and enforcing mode (setenforce 1 && setenforce 0).
>
> NB Any semodule operation will also trigger a policy reload (unless you
> specify -n or are acting on a policy other than the active one), so
> semodule -DB would also have flushed the cache for you when it removed
> all dontaudit rules.
>
> >
> > If that doesn't explain the behavior you are seeing, then we can't
> > really help without more information about the problem, e.g. the denial
> > message you say is visible in enforcing mode but not permissive mode,
> > your kernel version, possibly the strace output, a reproducer if you
> > have one, what distro / policy you are using, etc.
> >
> > There are cases where the audit system could drop records due to OOM
> > conditions, its ratelimit, or its backlog limit.  In those cases, you
> > should have a audit: message logged indicating that messages were lost.
> >   Check your dmesg or journalctl logs for such messages from the audit
> > system.  Those are audit system issues rather than SELinux.  You can
> > configure the limits via auditctl and/or the audit configuration.  But
> > generally those only apply when the audit system is under heavy load
> > from many denials (or many other audit messages) and you should see at
> > least some of them.
>

Thank you for your quick reply!

Let me give you a little bit more details about my setup.
I am working on debian 9.4 release with kernel version 4.9.0-6-amd64.
I have my own custom policy based on the refpolicy version
RELEASE 2 20161023. (it is pretty old but I have to work with that
specific version).
I am currently building a monolithic policy with dontaudit rules disabled.

Now here are the steps to reproduce the logging problem I described above.
Let say, I have a test domain foo_t, which is defined roughly as follows:

type foo_t;
domain_type(foo_t)
corecmd_exec_bin(foo_t)

Then I login as unconfined_u user and run the following command:

runcon -u system_u -r object_r -t foo_t -l s0 mkdir foobar

Note that unconfined_t and foo_t actually need little bit more rules to execute
the runcon command above, but they are irrelevant for my case...

The mkdir binary is selinux aware by which I mean that it loads
the libselinux.so shared library.
The libselinux library executes upon loading the following syscall:
(see https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/init.c#L156)

access(SELINUXCONFIG, F_OK)

This call would need a search dir permission for selinux_config_t and since
the domain foo_t doesn't have the permission I was expecting a denial log entry.
But the AVC denial never shows up in the logs in permissive mode.
I also tried to empty the logging cache by executing
setenforce 1 && setenforce 0, which didn't help.
However in enforcing mode the denial is logged as expected.

Hope this helps to clarify my question a bit further...
