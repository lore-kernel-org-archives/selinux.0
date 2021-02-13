Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77517C433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C37364E35
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 20:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMUkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 15:40:06 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:60382 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBMUkG (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 13 Feb 2021 15:40:06 -0500
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 5FE202A12B1;
        Sat, 13 Feb 2021 21:39:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 5FE202A12B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1613248764;
        bh=KLNzIemgvkULMK5h3Gf/LAlCrcpJuCVJo3Jt4/itapw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Qx1qxlXOyFxuTyJOVULiV5nSZuvRF84LuLbDcxo2QEShSbHRGPQiosxVibQ+02vmm
         Q2KsyCJ4IVHmpYRH5DxRPqm0X73qSuZIY3XK+AzMKzivkGFZjXQSzfbQA/1+sumMKF
         7/ldwC0QPqTaRahoaA9tkPzA212AKdAs8ERXdYkI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
        <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
        <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
        <ypjl35y1ot14.fsf@defensec.nl>
        <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
        <ypjlv9awo2iy.fsf@defensec.nl>
        <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
        <ypjlmtw8ne46.fsf@defensec.nl>
        <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
        <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
Date:   Sat, 13 Feb 2021 21:39:21 +0100
In-Reply-To: <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
        (Peter Whittaker's message of "Sat, 13 Feb 2021 15:26:05 -0500")
Message-ID: <ypjlim6vog7a.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:

> On Sat, Feb 13, 2021 at 1:08 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>> On 13.2.2021 18.09, Dominick Grift wrote:
>> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> >>      1. Of the changes I have applied over the last 1-3 days,
>> >>          what is the minimum set required to achieve this? My
>> >>          immediate future includes bisection.
>> >
>> > Yes i guess work your way back and see...
>
> Well, this turned out to be more difficult than I had hoped. I made a
> stupid decision when I was committing changes, amending previous
> commits instead of letting them pile on. I did it to avoid excessive
> commit history and that was a stupid choice - I cannot bisect what I
> do not have - I won't do that again.
>
> I decided to take a different tack, and that has some interesting
> results: I have two user types that must be able to connect to the
> box, auditors and transfer initiators; my results so far have involved
> transfer initiators, which work at the local console but not over SSH,
> so I decided to duplicate what I have for transfer initiators and see
> if I could get auditors to work.
>
> Long story short, I cannot: The key point seems to be that only some
> of the contexts that become valid for
> CDTml_high2local_u/xferHigh2Local_t (transfer initiators) become valid
> for CDTml_auditor_u/xferAudit_t. I'll point that out below in the
> journalctl extracts....
>
>> >>       2. Why doesn't it work with SSH, when it does work with
>> >>            the console (yes, the ssh_sysadm_login is on)?
>> >
>> > see if the ssh daemon runs with the expected:
>> > system_u:system_r:sshd_t:s0 context (ps auxZ | grep ssh)
>
> It does: See the shell output, below. Everything else checks out too, AFAICT.
>
>>> genconlist
>>> getdefaultcon
>> There's also `sedta` (Debian: setools package) which AFAICT walks
>> through the login process (except for the part that tries to find out
>> the default context for the user):
>
> The sedta utility is not available in my setools, which are still back
> at version 3; I could build it, but I am worried about the overall
> SELinux installation getting too far ahead of the version I need to
> work with (long story, customer related). The same
> limitations/concerns prevent me from doing much with
> getconlist/getdefaultcon.
>
> I am going to have to bite the bullet and do most/all of my
> development/test on very recent Fedora, then rebuild on the older RHEL
> I have to work with. I'm not up for that this weekend, I'll look at
> this for Monday. Which is a holiday. Sigh.
>
> In the meantime, I've run some comparisons with interesting results.
> Apologies for the excess quantities of logs, etc., it seemed relevant.
>
> Remember that transfer users can login at the console and get the
> right context, but do not get the correct context via SSH (though they
> can login), while auditors can log in on both and get bogus contexts
> on both. There are clues in the journalctl output, but I cannot
> interpret them.
>
> WRT all of what follows, I've attached the current CDTml.te; yes, it
> misses the domain type, but at this point, I want to identify why the
> two different types of users are treated differently. This is all
> under permissive mode.
>
> Shell commands to compare the two types of users, their policies, and
> to verity that things are installed and labelled as expected:
>
> % seinfo -xuCDTml_high2local_u
>    CDTml_high2local_u
>       default level: s0
>       range: s0
>       roles:
>          object_r
>          CDTml_high2local_r
>
> % seinfo -xuCDTml_auditor_u
>    CDTml_auditor_u
>       default level: s0
>       range: s0
>       roles:
>          object_r
>          CDTml_auditor_r
>
> % seinfo -xrCDTml_high2local_r
>    CDTml_high2local_r
>       Dominated Roles:
>          CDTml_high2local_r
>       Types:
>          xferHigh2Local_t
>          xferHigh2Local_exec_t
>
> % seinfo -xrCDTml_auditor_r
>    CDTml_auditor_r
>       Dominated Roles:
>          CDTml_auditor_r
>       Types:
>          xferAudit_t
>          xferAudit_exec_t
>
> % seinfo -xtxferHigh2Local_t
>    xferHigh2Local_t
>       CDTml_types
>       process_user_target
>       userdomain
>
> % seinfo -xtxferAudit_t
>    xferAudit_t
>       CDTml_types
>       process_user_target
>       userdomain

Where is "domain"?

>
> % semanage user -l (trimmed to just these two)
> CDTml_auditor_u user       s0         s0
> CDTml_auditor_r
> CDTml_high2local_u user       s0         s0
>  CDTml_high2local_r
>
> % semanage login -l (trimmed to just these two)
> %CDTml_high2local    CDTml_high2local_u   s0                   *
> %xferAuditGroup      CDTml_auditor_u      s0                   *
>
> % ps auxZ |grep sshd
> system_u:system_r:sshd_t:s0     root       1939  0.0  0.2 156816  5588
> ?        Ss   13:25   0:00 sshd: pww [priv]
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pww 1942 0.0
> 0.1 156816 2512 ? S 13:25   0:00 sshd: pww@pts/0
> system_u:system_r:sshd_t:s0     root       2071  0.0  0.3 156816  5592
> ?        Ss   13:30   0:00 sshd: pww [priv]
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pww 2074 0.0
> 0.1 156816 2512 ? S 13:30   0:00 sshd: pww@pts/1
> system_u:system_r:sshd_t:s0     root      58459  0.0  0.2 112936  4292
> ?        Ss   14:10   0:00 /usr/sbin/sshd -D
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 61323 0.0
> 0.0 112808 952 pts/0 S+ 14:50   0:00 grep sshd
>
> % ls -lZ /etc/selinux/targeted/contexts/users/CDTml_auditor_u
> -rw-r--r--. root root system_u:object_r:default_context_t:s0
> /etc/selinux/targeted/contexts/users/CDTml_auditor_u
>
> % ls -lZ /etc/selinux/targeted/contexts/users/CDTml_high2local_u
> -rw-r--r--. root root system_u:object_r:default_context_t:s0
> /etc/selinux/targeted/contexts/users/CDTml_high2local_u
>
> % cat /etc/selinux/targeted/contexts/users/CDTml_auditor_u
> system_r:crond_t:s0                              CDTml_audit_r:xferAudit_t:s0
> system_r:initrc_su_t:s0                          CDTml_audit_r:xferAudit_t:s0
> system_r:local_login_t:s0                        CDTml_audit_r:xferAudit_t:s0
> system_r:remote_login_t:s0                       CDTml_audit_r:xferAudit_t:s0
> system_r:sshd_t:s0                               CDTml_audit_r:xferAudit_t:s0
> CDTml_audit_r:xferAudit_t:s0                     CDTml_audit_r:xferAudit_t:s0
>
> % cat /etc/selinux/targeted/contexts/users/CDTml_high2local_u
> system_r:crond_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
> system_r:initrc_su_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
> system_r:local_login_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
> system_r:remote_login_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
> system_r:sshd_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
> CDTml_high2local_r:xferHigh2Local_t:s0
>
> So far, everything compares cleanly: All file contents and contexts
> are correct and, as far as the commands above are concerned, the two
> user types and roles have similar properties.
>
> journalctl is where things are interesting; I'll add commentary to the
> journalctl results IN CAPS (annoying but easy to pick out:
>
> THIS STARTS WITH MY INSTALLATION SCRIPT, which runs semodule to
> install the PP and semanage to set up users and mappings; it also
> creates the first Linux user of each type.
>
> INSTALLING THE RPM: Base groups are created
> Feb 13 14:09:53 localhost.localdomain groupadd[57256]: group added to
> /etc/group: name=CDTml_high2local, GID=2105
> Feb 13 14:09:53 localhost.localdomain groupadd[57256]: group added to
> /etc/gshadow: name=CDTml_high2local
> Feb 13 14:09:53 localhost.localdomain groupadd[57256]: new group:
> name=CDTml_high2local, GID=2105
> Feb 13 14:09:53 localhost.localdomain groupadd[57261]: group added to
> /etc/group: name=xferAuditGroup, GID=2200
> Feb 13 14:09:53 localhost.localdomain groupadd[57261]: group added to
> /etc/gshadow: name=xferAuditGroup
> Feb 13 14:09:53 localhost.localdomain groupadd[57261]: new group:
> name=xferAuditGroup, GID=2200
>
> CONTEXTS BECOMING VALID AS SEMODULE PROCESSES CDTml.pp:
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:system_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:system_r:xferAudit_t:s0-s0:c0.c1023 became valid (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:system_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:system_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:unconfined_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:unconfined_r:xferAudit_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:unconfined_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> system_u:unconfined_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became
> valid (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:system_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:system_r:xferAudit_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:system_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:system_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became
> valid (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:unconfined_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:unconfined_r:xferAudit_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:unconfined_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
> (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> unconfined_u:unconfined_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became
> valid (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> system_u:object_r:xferAudit_t:s0 became valid (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> system_u:object_r:xferAudit_exec_t:s0 became valid (mapped).
> Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
> system_u:object_r:xferHigh2Local_exec_t:s0 became valid (mapped).
>
> CONTEXTS BECOMING VALID AS A RESULT OF SEMANAGE USER/LOGIN
> Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 became valid
> (mapped).
> Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_exec_t:s0 became
> valid (mapped).
> Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
> CDTml_high2local_u:object_r:tty_device_t:s0 became valid (mapped).
> Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
> CDTml_high2local_u:object_r:cache_home_t:s0 became valid (mapped).
> Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
> CDTml_high2local_u:object_r:config_home_t:s0 became valid (mapped).
> Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
> CDTml_high2local_u:object_r:user_home_t:s0 became valid (mapped).
> Feb 13 14:11:03 localhost.localdomain kernel: SELinux:  Context
> CDTml_auditor_u:CDTml_auditor_r:xferAudit_t:s0 became valid (mapped).
> Feb 13 14:11:03 localhost.localdomain kernel: SELinux:  Context
> CDTml_auditor_u:CDTml_auditor_r:xferAudit_exec_t:s0 became valid
> (mapped).
> NOTE NOTE NOTE ^^^^ THERE ARE ONLY TWO CONTEXTS FOR auditors, VERSUS
> SIX FOR transfer initiators. WHAT CAUSES THE MISS?
>
> USERS LOGGING IN - NOTE THE SSH REJECTION OF AN OTHERWISE CORRECT
> CONTEXT FOR icmc01
> Feb 13 14:13:41 localhost.localdomain sshd[58993]:
> pam_selinux(sshd:session): Username= icmc01 SELinux User=
> CDTml_high2local_u Level= s0
> Feb 13 14:13:41 localhost.localdomain sshd[58993]:
> pam_selinux(sshd:session): Selected Security Context
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
> Feb 13 14:13:41 localhost.localdomain sshd[58993]:
> pam_selinux(sshd:session): Checking if
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 mls range
> valid for  CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
> Feb 13 14:13:41 localhost.localdomain sshd[58993]:
> pam_selinux(sshd:session): Security context
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 is not
> allowed for CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
> WHAT? ^^^ WHY NOT?
>
> Feb 13 14:14:08 localhost.localdomain sshd[59060]:
> pam_selinux(sshd:session): Username= audit01 SELinux User=
> CDTml_auditor_u Level= s0
> Feb 13 14:14:23 localhost.localdomain login[1936]:
> pam_selinux(login:session): Username= icmc01 SELinux User=
> CDTml_high2local_u Level= s0
> Feb 13 14:14:23 localhost.localdomain login[1936]:
> pam_selinux(login:session): Set file context of tty /dev/tty1:
> [system_u:object_r:tty_device_t:s0] ->
> [CDTml_high2local_u:object_r:tty_device_t:s0]
> Feb 13 14:14:23 localhost.localdomain login[1936]:
> pam_selinux(login:session): Set executable context: [] ->
> [CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0]
> Feb 13 14:14:23 localhost.localdomain login[1936]:
> pam_selinux(login:session): Security Context
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 Assigned
> Feb 13 14:14:23 localhost.localdomain login[1936]:
> pam_selinux(login:session): Set key creation context to
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
> Feb 13 14:14:23 localhost.localdomain login[1936]:
> pam_selinux(login:session): Key Creation Context
> CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 Assigned
> Feb 13 14:14:28 localhost.localdomain login[1936]:
> pam_selinux(login:session): Restore file context of tty /dev/tty1:
> [CDTml_high2local_u:object_r:tty_device_t:s0] ->
> [system_u:object_r:tty_device_t:s0]
> Feb 13 14:14:28 localhost.localdomain login[1936]:
> pam_selinux(login:session): Restore executable context:
> [CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0] -> []
> Feb 13 14:14:33 localhost.localdomain login[59190]:
> pam_selinux(login:session): Username= audit01 SELinux User=
> CDTml_auditor_u Level= s0
>
> At this point, I think audit01 fails to get their context because of
> the six "missing" mappings, but I do not understand why SSHD is
> rejecting the context for icmc01 that local login happily accepts.
>
> Thoughts?
>
> Thanks,
>
> P
>
>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
