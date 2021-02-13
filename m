Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A7C433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D28964E35
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 20:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBMU11 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 15:27:27 -0500
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:60197
        "EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229647AbhBMU1Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Feb 2021 15:27:24 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48])
        by :SMTPAUTH: with ESMTPA
        id B1UulqqnkPVB3B1UwlFYE8; Sat, 13 Feb 2021 13:26:35 -0700
X-CMAE-Analysis: v=2.4 cv=AIWtjDgx c=1 sm=1 tr=0 ts=602835fb
 a=zZ/DyiEhLoMDSERZ33v5aA==:117 a=qa6Q16uM49sA:10 a=pGLkceISAAAA:8
 a=oSqZqoiyAAAA:8 a=XOSI8m_b1Dw2X9fduLQA:9 a=QEXdDO2ut3YA:10
 a=IibcJkwq8RspnWkfeFIA:9 a=d02kYJNF5F4A:10 a=fw9lIXHl4l3rR_lUHM3T:22
X-SECURESERVER-ACCT: peterwhittaker@sphyrnasecurity.com
Received: by mail-wr1-f48.google.com with SMTP id 7so4054621wrz.0
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 12:26:34 -0800 (PST)
X-Gm-Message-State: AOAM533UgPSI2zxM4L+h0f1OCCHJ3C9/L/qYnb4nq3LtiNiXOhDngtwm
        tbGMwWgBnf6D7zRhBmk1//FoFGtYwzPyg6Lm27o1eQ==
X-Google-Smtp-Source: ABdhPJzkkBbwznnZ7UzrG4N5eRW5Yvyi+68s9hYh0JB2xwP/o9cgy1YmMrCfyUCry54nV4Kj54ZOlrrMxKsNAineqkA=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr10430448wrg.362.1613247991810;
 Sat, 13 Feb 2021 12:26:31 -0800 (PST)
MIME-Version: 1.0
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
 <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
 <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
 <ypjl35y1ot14.fsf@defensec.nl> <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
 <ypjlv9awo2iy.fsf@defensec.nl> <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
 <ypjlmtw8ne46.fsf@defensec.nl> <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
In-Reply-To: <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
From:   Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Date:   Sat, 13 Feb 2021 15:26:05 -0500
X-Gmail-Original-Message-ID: <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
Message-ID: <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007d137305bb3d9192"
X-CMAE-Envelope: MS4xfHfJHRDg7dmhnzq0brZa6CdB/aIaM2T1+yuHNqGJoHPDQ4ocUmJ9VNPiqXmv8UyxUsXtFMi9QKr6Aggvb+z8krFaDX1YnyhK8/Bglh/Ets65Cf2W+/DD
 99I3V0vcZCq0DPoHU2HYuToGyHoVV/kY2yuw4qmjR37CREZqB3y7kEMnlO/lFqAQ9Mq5JAa9RAjmC5upX6pcO1fHsQNCOqIdRlfOUJ+/I11yIqcEIGyofT9U
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0000000000007d137305bb3d9192
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 13, 2021 at 1:08 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 13.2.2021 18.09, Dominick Grift wrote:
> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
> >>      1. Of the changes I have applied over the last 1-3 days,
> >>          what is the minimum set required to achieve this? My
> >>          immediate future includes bisection.
> >
> > Yes i guess work your way back and see...

Well, this turned out to be more difficult than I had hoped. I made a
stupid decision when I was committing changes, amending previous
commits instead of letting them pile on. I did it to avoid excessive
commit history and that was a stupid choice - I cannot bisect what I
do not have - I won't do that again.

I decided to take a different tack, and that has some interesting
results: I have two user types that must be able to connect to the
box, auditors and transfer initiators; my results so far have involved
transfer initiators, which work at the local console but not over SSH,
so I decided to duplicate what I have for transfer initiators and see
if I could get auditors to work.

Long story short, I cannot: The key point seems to be that only some
of the contexts that become valid for
CDTml_high2local_u/xferHigh2Local_t (transfer initiators) become valid
for CDTml_auditor_u/xferAudit_t. I'll point that out below in the
journalctl extracts....

> >>       2. Why doesn't it work with SSH, when it does work with
> >>            the console (yes, the ssh_sysadm_login is on)?
> >
> > see if the ssh daemon runs with the expected:
> > system_u:system_r:sshd_t:s0 context (ps auxZ | grep ssh)

It does: See the shell output, below. Everything else checks out too, AFAICT.

>> genconlist
>> getdefaultcon
> There's also `sedta` (Debian: setools package) which AFAICT walks
> through the login process (except for the part that tries to find out
> the default context for the user):

The sedta utility is not available in my setools, which are still back
at version 3; I could build it, but I am worried about the overall
SELinux installation getting too far ahead of the version I need to
work with (long story, customer related). The same
limitations/concerns prevent me from doing much with
getconlist/getdefaultcon.

I am going to have to bite the bullet and do most/all of my
development/test on very recent Fedora, then rebuild on the older RHEL
I have to work with. I'm not up for that this weekend, I'll look at
this for Monday. Which is a holiday. Sigh.

In the meantime, I've run some comparisons with interesting results.
Apologies for the excess quantities of logs, etc., it seemed relevant.

Remember that transfer users can login at the console and get the
right context, but do not get the correct context via SSH (though they
can login), while auditors can log in on both and get bogus contexts
on both. There are clues in the journalctl output, but I cannot
interpret them.

WRT all of what follows, I've attached the current CDTml.te; yes, it
misses the domain type, but at this point, I want to identify why the
two different types of users are treated differently. This is all
under permissive mode.

Shell commands to compare the two types of users, their policies, and
to verity that things are installed and labelled as expected:

% seinfo -xuCDTml_high2local_u
   CDTml_high2local_u
      default level: s0
      range: s0
      roles:
         object_r
         CDTml_high2local_r

% seinfo -xuCDTml_auditor_u
   CDTml_auditor_u
      default level: s0
      range: s0
      roles:
         object_r
         CDTml_auditor_r

% seinfo -xrCDTml_high2local_r
   CDTml_high2local_r
      Dominated Roles:
         CDTml_high2local_r
      Types:
         xferHigh2Local_t
         xferHigh2Local_exec_t

% seinfo -xrCDTml_auditor_r
   CDTml_auditor_r
      Dominated Roles:
         CDTml_auditor_r
      Types:
         xferAudit_t
         xferAudit_exec_t

% seinfo -xtxferHigh2Local_t
   xferHigh2Local_t
      CDTml_types
      process_user_target
      userdomain

% seinfo -xtxferAudit_t
   xferAudit_t
      CDTml_types
      process_user_target
      userdomain

% semanage user -l (trimmed to just these two)
CDTml_auditor_u user       s0         s0
CDTml_auditor_r
CDTml_high2local_u user       s0         s0
 CDTml_high2local_r

% semanage login -l (trimmed to just these two)
%CDTml_high2local    CDTml_high2local_u   s0                   *
%xferAuditGroup      CDTml_auditor_u      s0                   *

% ps auxZ |grep sshd
system_u:system_r:sshd_t:s0     root       1939  0.0  0.2 156816  5588
?        Ss   13:25   0:00 sshd: pww [priv]
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pww 1942 0.0
0.1 156816 2512 ? S 13:25   0:00 sshd: pww@pts/0
system_u:system_r:sshd_t:s0     root       2071  0.0  0.3 156816  5592
?        Ss   13:30   0:00 sshd: pww [priv]
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pww 2074 0.0
0.1 156816 2512 ? S 13:30   0:00 sshd: pww@pts/1
system_u:system_r:sshd_t:s0     root      58459  0.0  0.2 112936  4292
?        Ss   14:10   0:00 /usr/sbin/sshd -D
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 61323 0.0
0.0 112808 952 pts/0 S+ 14:50   0:00 grep sshd

% ls -lZ /etc/selinux/targeted/contexts/users/CDTml_auditor_u
-rw-r--r--. root root system_u:object_r:default_context_t:s0
/etc/selinux/targeted/contexts/users/CDTml_auditor_u

% ls -lZ /etc/selinux/targeted/contexts/users/CDTml_high2local_u
-rw-r--r--. root root system_u:object_r:default_context_t:s0
/etc/selinux/targeted/contexts/users/CDTml_high2local_u

% cat /etc/selinux/targeted/contexts/users/CDTml_auditor_u
system_r:crond_t:s0                              CDTml_audit_r:xferAudit_t:s0
system_r:initrc_su_t:s0                          CDTml_audit_r:xferAudit_t:s0
system_r:local_login_t:s0                        CDTml_audit_r:xferAudit_t:s0
system_r:remote_login_t:s0                       CDTml_audit_r:xferAudit_t:s0
system_r:sshd_t:s0                               CDTml_audit_r:xferAudit_t:s0
CDTml_audit_r:xferAudit_t:s0                     CDTml_audit_r:xferAudit_t:s0

% cat /etc/selinux/targeted/contexts/users/CDTml_high2local_u
system_r:crond_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
system_r:initrc_su_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
system_r:local_login_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
system_r:remote_login_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
system_r:sshd_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0
CDTml_high2local_r:xferHigh2Local_t:s0

So far, everything compares cleanly: All file contents and contexts
are correct and, as far as the commands above are concerned, the two
user types and roles have similar properties.

journalctl is where things are interesting; I'll add commentary to the
journalctl results IN CAPS (annoying but easy to pick out:

THIS STARTS WITH MY INSTALLATION SCRIPT, which runs semodule to
install the PP and semanage to set up users and mappings; it also
creates the first Linux user of each type.

INSTALLING THE RPM: Base groups are created
Feb 13 14:09:53 localhost.localdomain groupadd[57256]: group added to
/etc/group: name=CDTml_high2local, GID=2105
Feb 13 14:09:53 localhost.localdomain groupadd[57256]: group added to
/etc/gshadow: name=CDTml_high2local
Feb 13 14:09:53 localhost.localdomain groupadd[57256]: new group:
name=CDTml_high2local, GID=2105
Feb 13 14:09:53 localhost.localdomain groupadd[57261]: group added to
/etc/group: name=xferAuditGroup, GID=2200
Feb 13 14:09:53 localhost.localdomain groupadd[57261]: group added to
/etc/gshadow: name=xferAuditGroup
Feb 13 14:09:53 localhost.localdomain groupadd[57261]: new group:
name=xferAuditGroup, GID=2200

CONTEXTS BECOMING VALID AS SEMODULE PROCESSES CDTml.pp:
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:system_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:system_r:xferAudit_t:s0-s0:c0.c1023 became valid (mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:system_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:system_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:unconfined_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:unconfined_r:xferAudit_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:unconfined_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
system_u:unconfined_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became
valid (mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
unconfined_u:system_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
unconfined_u:system_r:xferAudit_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
unconfined_u:system_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:39 localhost.localdomain kernel: SELinux:  Context
unconfined_u:system_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became
valid (mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
unconfined_u:unconfined_r:xferHigh2Local_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
unconfined_u:unconfined_r:xferAudit_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
unconfined_u:unconfined_r:xferAudit_exec_t:s0-s0:c0.c1023 became valid
(mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
unconfined_u:unconfined_r:xferHigh2Local_exec_t:s0-s0:c0.c1023 became
valid (mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
system_u:object_r:xferAudit_t:s0 became valid (mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
system_u:object_r:xferAudit_exec_t:s0 became valid (mapped).
Feb 13 14:10:40 localhost.localdomain kernel: SELinux:  Context
system_u:object_r:xferHigh2Local_exec_t:s0 became valid (mapped).

CONTEXTS BECOMING VALID AS A RESULT OF SEMANAGE USER/LOGIN
Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 became valid
(mapped).
Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_exec_t:s0 became
valid (mapped).
Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
CDTml_high2local_u:object_r:tty_device_t:s0 became valid (mapped).
Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
CDTml_high2local_u:object_r:cache_home_t:s0 became valid (mapped).
Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
CDTml_high2local_u:object_r:config_home_t:s0 became valid (mapped).
Feb 13 14:10:53 localhost.localdomain kernel: SELinux:  Context
CDTml_high2local_u:object_r:user_home_t:s0 became valid (mapped).
Feb 13 14:11:03 localhost.localdomain kernel: SELinux:  Context
CDTml_auditor_u:CDTml_auditor_r:xferAudit_t:s0 became valid (mapped).
Feb 13 14:11:03 localhost.localdomain kernel: SELinux:  Context
CDTml_auditor_u:CDTml_auditor_r:xferAudit_exec_t:s0 became valid
(mapped).
NOTE NOTE NOTE ^^^^ THERE ARE ONLY TWO CONTEXTS FOR auditors, VERSUS
SIX FOR transfer initiators. WHAT CAUSES THE MISS?

USERS LOGGING IN - NOTE THE SSH REJECTION OF AN OTHERWISE CORRECT
CONTEXT FOR icmc01
Feb 13 14:13:41 localhost.localdomain sshd[58993]:
pam_selinux(sshd:session): Username= icmc01 SELinux User=
CDTml_high2local_u Level= s0
Feb 13 14:13:41 localhost.localdomain sshd[58993]:
pam_selinux(sshd:session): Selected Security Context
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
Feb 13 14:13:41 localhost.localdomain sshd[58993]:
pam_selinux(sshd:session): Checking if
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 mls range
valid for  CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
Feb 13 14:13:41 localhost.localdomain sshd[58993]:
pam_selinux(sshd:session): Security context
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 is not
allowed for CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
WHAT? ^^^ WHY NOT?

Feb 13 14:14:08 localhost.localdomain sshd[59060]:
pam_selinux(sshd:session): Username= audit01 SELinux User=
CDTml_auditor_u Level= s0
Feb 13 14:14:23 localhost.localdomain login[1936]:
pam_selinux(login:session): Username= icmc01 SELinux User=
CDTml_high2local_u Level= s0
Feb 13 14:14:23 localhost.localdomain login[1936]:
pam_selinux(login:session): Set file context of tty /dev/tty1:
[system_u:object_r:tty_device_t:s0] ->
[CDTml_high2local_u:object_r:tty_device_t:s0]
Feb 13 14:14:23 localhost.localdomain login[1936]:
pam_selinux(login:session): Set executable context: [] ->
[CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0]
Feb 13 14:14:23 localhost.localdomain login[1936]:
pam_selinux(login:session): Security Context
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 Assigned
Feb 13 14:14:23 localhost.localdomain login[1936]:
pam_selinux(login:session): Set key creation context to
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0
Feb 13 14:14:23 localhost.localdomain login[1936]:
pam_selinux(login:session): Key Creation Context
CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0 Assigned
Feb 13 14:14:28 localhost.localdomain login[1936]:
pam_selinux(login:session): Restore file context of tty /dev/tty1:
[CDTml_high2local_u:object_r:tty_device_t:s0] ->
[system_u:object_r:tty_device_t:s0]
Feb 13 14:14:28 localhost.localdomain login[1936]:
pam_selinux(login:session): Restore executable context:
[CDTml_high2local_u:CDTml_high2local_r:xferHigh2Local_t:s0] -> []
Feb 13 14:14:33 localhost.localdomain login[59190]:
pam_selinux(login:session): Username= audit01 SELinux User=
CDTml_auditor_u Level= s0

At this point, I think audit01 fails to get their context because of
the six "missing" mappings, but I do not understand why SSHD is
rejecting the context for icmc01 that local login happily accepts.

Thoughts?

Thanks,

P

--0000000000007d137305bb3d9192
Content-Type: application/octet-stream; name="CDTml.te"
Content-Disposition: attachment; filename="CDTml.te"
Content-Transfer-Encoding: base64
Content-ID: <f_kl4646dz0>
X-Attachment-Id: f_kl4646dz0

bW9kdWxlIENEVG1sIDEuMDsKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMKIyBFeHRlcm5hbCBkZXBlbmRlbmNpZXMuIFdoaWxlIG9u
bHkgc29tZSBvZiB0aGVzZSBhcmUKIyB1c2VkLCB0aGVyZSBpcyBubyBoYXJtIGluIGluY2x1ZGlu
ZyBtb3JlIHRoYW4gaXMKIyByZXF1aXJlZC4gSXQncyBhbiBvZGQgdmFnYXJ5IG9mIFNFTGludXgu
IFRoZXNlIGFyZQojIGRlcml2ZWQgZnJvbSBvdGhlciB3b3JraW5nIGNyb3NzLWRvbWFpbiBzeXN0
ZW1zLgoKcmVxdWlyZSB7CiAgICBhdHRyaWJ1dGUgY2FuX2NoYW5nZV9vYmplY3RfaWRlbnRpdHk7
CiAgICBhdHRyaWJ1dGUgY2FuX3JlYWRfc2hhZG93X3Bhc3N3b3JkczsKICAgIGF0dHJpYnV0ZSBj
YW5fc3lzdGVtX2NoYW5nZTsKICAgIGF0dHJpYnV0ZSBkb21haW47CiAgICBhdHRyaWJ1dGUgZGJ1
c2RfdW5jb25maW5lZDsKICAgIGF0dHJpYnV0ZSBwcm9jZXNzX3VzZXJfdGFyZ2V0OwogICAgYXR0
cmlidXRlIHVzZXJkb21haW47CiAgICBjbGFzcyBjYXBhYmlsaXR5IHsgYXVkaXRfd3JpdGUgY2hv
d24gZGFjX292ZXJyaWRlIGRhY19yZWFkX3NlYXJjaCBmb3duZXIgZnNldGlkIG5ldF9hZG1pbiBu
ZXRfcmF3IHNldGdpZCBzZXR1aWQgc3lzX2Jvb3Qgc3lzX3B0cmFjZSB9OwogICAgY2xhc3MgY2hy
X2ZpbGUgeyBhcHBlbmQgZ2V0YXR0ciBpb2N0bCBvcGVuIHJlYWQgc2V0YXR0ciB3cml0ZSB9Owog
ICAgY2xhc3MgZGJ1cyB7IHNlbmRfbXNnIH07CiAgICBjbGFzcyBkaXIgeyBhZGRfbmFtZSBjcmVh
dGUgZ2V0YXR0ciBvcGVuIHJlYWQgcmVsYWJlbGZyb20gcmVsYWJlbHRvIHJlbW92ZV9uYW1lIHJt
ZGlyIHNlYXJjaCBzZXRhdHRyIHdyaXRlIH07CiAgICBjbGFzcyBmZCB7IHVzZSB9OwogICAgY2xh
c3MgZmlmb19maWxlIHsgZ2V0YXR0ciBjcmVhdGUgaW9jdGwgbWFwIG9wZW4gcmVhZCByZWxhYmVs
dG8gc2V0YXR0ciB3cml0ZSB9OwogICAgY2xhc3MgZmlsZSB7IGFwcGVuZCBjcmVhdGUgZW50cnlw
b2ludCBleGVjdXRlIGV4ZWN1dGVfbm9fdHJhbnMgZ2V0YXR0ciBpb2N0bCBsaW5rIGxvY2sgbWFw
IG9wZW4gcmVhZCByZWxhYmVsZnJvbSByZWxhYmVsdG8gcmVuYW1lIHNldGF0dHIgd3JpdGUgdW5s
aW5rIH07CiAgICBjbGFzcyBmaWxlc3lzdGVtIHsgYXNzb2NpYXRlIGdldGF0dHIgfTsKICAgIGNs
YXNzIGtleSB7IGxpbmsgcmVhZCBzZWFyY2ggdmlldyB3cml0ZSB9OwogICAgY2xhc3MgbG5rX2Zp
bGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB9OwogICAgY2xhc3MgbmV0aWYgeyBlZ3Jlc3MgaW5ncmVz
cyB9OwogICAgY2xhc3MgbmV0bGlua19hdWRpdF9zb2NrZXQgeyBjcmVhdGUgbmxtc2dfcmVsYXkg
cmVhZCB3cml0ZSB9OwogICAgY2xhc3MgbmV0bGlua19yb3V0ZV9zb2NrZXQgeyBiaW5kIGNyZWF0
ZSBnZXRhdHRyIG5sbXNnX3JlYWQgcmVhZCBzZXRvcHQgd3JpdGUgfTsKICAgIGNsYXNzIG5ldGxp
bmtfc2VsaW51eF9zb2NrZXQgeyBiaW5kIGNyZWF0ZSBnZXRhdHRyIG5sbXNnX3JlYWQgcmVhZCBz
ZXRvcHQgd3JpdGUgfTsKICAgIGNsYXNzIHBhc3N3ZCB7IHBhc3N3ZCB9OwogICAgY2xhc3MgcHJv
Y2VzcyB7IGV4ZWNtZW0gZm9yayBnZXRhdHRyIG5vYXRzZWN1cmUgcmxpbWl0aW5oIHNldGZzY3Jl
YXRlIHNldHJsaW1pdCBzZXRzY2hlZCBzaWdpbmggc2lnY2hsZCBzaWdraWxsIHNpZ25hbCBzaWdu
dWxsIHNpZ3N0b3AgdHJhbnNpdGlvbiB9OwogICAgY2xhc3MgcmF3aXBfc29ja2V0IHsgY3JlYXRl
IGdldG9wdCBzZXRvcHQgfTsKICAgIGNsYXNzIHNlY3VyaXR5IHsgY2hlY2tfY29udGV4dCBjb21w
dXRlX2F2IGNvbXB1dGVfY3JlYXRlIH07CiAgICBjbGFzcyBzZXJ2aWNlIHsgZGlzYWJsZSBlbmFi
bGUgc3RhcnQgc3RhdHVzIHN0b3AgfTsKICAgIGNsYXNzIHNvY2tfZmlsZSB7IGNyZWF0ZSByZWFk
IHVubGluayB3cml0ZSB9OwogICAgY2xhc3Mgc3lzdGVtIHsgbW9kdWxlX3JlcXVlc3QgcmVsb2Fk
IHN0YXR1cyB9OwogICAgY2xhc3MgdGNwX3NvY2tldCB7IGNvbm5lY3QgY3JlYXRlIGdldGF0dHIg
Z2V0b3B0IG5hbWVfY29ubmVjdCByZWFkIHNldG9wdCBzaHV0ZG93biB3cml0ZSB9OwogICAgY2xh
c3MgdWRwX3NvY2tldCB7IGJpbmQgY29ubmVjdCBjb25uZWN0dG8gY3JlYXRlIGdldGF0dHIgZ2V0
b3B0IGlvY3RsIG5hbWVfYmluZCBub2RlX2JpbmQgcmVhZCBzZXRvcHQgd3JpdGUgfTsKICAgIGNs
YXNzIHVuaXhfZGdyYW1fc29ja2V0IHsgY29ubmVjdCBjb25uZWN0dG8gY3JlYXRlIGdldGF0dHIg
Z2V0b3B0IGlvY3RsIHJlYWQgc2VuZHRvIHNldG9wdCB3cml0ZSB9OwogICAgY2xhc3MgdW5peF9z
dHJlYW1fc29ja2V0IHsgYWNjZXB0IGFwcGVuZCBiaW5kIGNvbm5lY3QgY29ubmVjdHRvIGNyZWF0
ZSBnZXRhdHRyIGdldG9wdCBpb2N0bCBsaXN0ZW4gcmVhZCBzZXRvcHQgc2h1dGRvd24gd3JpdGUg
fTsKICAgIHJvbGUgb2JqZWN0X3I7CiAgICByb2xlIHN5c3RlbV9yOwogICAgcm9sZSB1bmNvbmZp
bmVkX3I7CiAgICB0eXBlIGFkbWluX2hvbWVfdDsKICAgIHR5cGUgYWJydF90OwogICAgdHlwZSBh
YnJ0X3dhdGNoX2xvZ190OwogICAgdHlwZSBhaWRlX2xvZ190OwogICAgdHlwZSBhaWRlX3Q7CiAg
ICB0eXBlIGF1ZGl0ZF90OwogICAgdHlwZSBhdWRpdGRfbG9nX3Q7CiAgICB0eXBlIGJpbl90Owog
ICAgdHlwZSBib290X3Q7CiAgICB0eXBlIGNlcnRfdDsKICAgIHR5cGUgY2dyb3VwX3Q7CiAgICB0
eXBlIGNoa3B3ZF9leGVjX3Q7CiAgICB0eXBlIGNocm9ueWRfdW5pdF9maWxlX3Q7CiAgICB0eXBl
IGNocm9ueWRfdmFyX2xvZ190OwogICAgdHlwZSBjb25maWdfaG9tZV90OwogICAgdHlwZSBjcmFj
a19kYl90OwogICAgdHlwZSBjcm9uZF90OwogICAgdHlwZSBjcHVfb25saW5lX3Q7CiAgICB0eXBl
IGRhdGFfaG9tZV90OwogICAgdHlwZSBkYnVzZF9ldGNfdDsKICAgIHR5cGUgZGVmYXVsdF90Owog
ICAgdHlwZSBkaGNwY190OwogICAgdHlwZSBkZWZhdWx0X2NvbnRleHRfdDsKICAgIHR5cGUgZGV2
aWNlX3Q7CiAgICB0eXBlIGRldmxvZ190OwogICAgdHlwZSBkZXZwdHNfdDsKICAgIHR5cGUgZGV2
dHR5X3Q7CiAgICB0eXBlIGV0Y19ydW50aW1lX3Q7CiAgICB0eXBlIGV0Y190OwogICAgdHlwZSBm
YWlsbG9nX3Q7CiAgICB0eXBlIGZpbGVfY29udGV4dF90OwogICAgdHlwZSBmaXJld2FsbGRfdDsK
ICAgIHR5cGUgZmlyZXdhbGxkX3VuaXRfZmlsZV90OwogICAgdHlwZSBmc190OwogICAgdHlwZSBm
c2RhZW1vbl90OwogICAgdHlwZSBnZXR0eV90OwogICAgdHlwZSBnY29uZl9ob21lX3Q7CiAgICB0
eXBlIGhvbWVfcm9vdF90OwogICAgdHlwZSBob3N0bmFtZV9ldGNfdDsKICAgIHR5cGUgaG9zdG5h
bWVfZXhlY190OwogICAgdHlwZSBodWdldGxiZnNfdDsKICAgIHR5cGUgaWZjb25maWdfZXhlY190
OwogICAgdHlwZSBpbml0cmNfZXhlY190OwogICAgdHlwZSBpbml0cmNfdDsKICAgIHR5cGUgaW5p
dHJjX3Zhcl9ydW5fdDsKICAgIHR5cGUgaW5pdF90OwogICAgdHlwZSBpbml0X3RtcF90OwogICAg
dHlwZSBpbml0X3Zhcl9ydW5fdDsKICAgIHR5cGUgaXB0YWJsZXNfZXhlY190OwogICAgdHlwZSBp
cHRhYmxlc192YXJfcnVuX3Q7CiAgICB0eXBlIGtlcm5lbF90OwogICAgdHlwZSBrcmI1X2NvbmZf
dDsKICAgIHR5cGUgbGFzdGxvZ190OwogICAgdHlwZSBsZF9zb19jYWNoZV90OwogICAgdHlwZSBs
ZF9zb190OwogICAgdHlwZSBsaWJfdDsKICAgIHR5cGUgbG9hZF9wb2xpY3lfdDsKICAgIHR5cGUg
bG9jYWxlX3Q7CiAgICB0eXBlIGxvY2FsX2xvZ2luX3Q7CiAgICB0eXBlIGxvc3RfZm91bmRfdDsK
ICAgIHR5cGUgbHNtZF90OwogICAgdHlwZSBsdm1fdDsKICAgIHR5cGUgbWFpbF9zcG9vbF90Owog
ICAgdHlwZSBtbnRfdDsKICAgIHR5cGUgbW96aWxsYV9ob21lX3Q7CiAgICB0eXBlIG5ldF9jb25m
X3Q7CiAgICB0eXBlIG5vZGVfdDsKICAgIHR5cGUgbnVsbF9kZXZpY2VfdDsKICAgIHR5cGUgcGFz
c3dkX2V4ZWNfdDsKICAgIHR5cGUgcGFzc3dkX2ZpbGVfdDsKICAgIHR5cGUgcGFzc3dkX3Q7CiAg
ICB0eXBlIHBseW1vdXRoZF92YXJfbG9nX3Q7CiAgICB0eXBlIHBseW1vdXRoX2V4ZWNfdDsKICAg
IHR5cGUgcG9saWN5a2l0X3Q7CiAgICB0eXBlIHByb2NfbmV0X3Q7CiAgICB0eXBlIHByb2NfdDsK
ICAgIHR5cGUgcHRteF90OwogICAgdHlwZSByZWFkYWhlYWRfdDsKICAgIHR5cGUgcmhuc2RfdDsK
ICAgIHR5cGUgcmhzbWNlcnRkX3Q7CiAgICB0eXBlIHJuZ2RfdDsKICAgIHR5cGUgcm9vdF90Owog
ICAgdHlwZSBycGNiaW5kX3Q7CiAgICB0eXBlIHNlY3VyaXR5X3Q7CiAgICB0eXBlIHNlbGludXhf
Y29uZmlnX3Q7CiAgICB0eXBlIHNldGZpbGVzX3Q7CiAgICB0eXBlIHNldGZpbGVzX2V4ZWNfdDsK
ICAgIHR5cGUgc2V0cmFuc192YXJfcnVuX3Q7CiAgICB0eXBlIHNoYWRvd190OwogICAgdHlwZSBz
aGVsbF9leGVjX3Q7CiAgICB0eXBlIHNzaGRfdDsKICAgIHR5cGUgc3NoZF9leGVjX3Q7CiAgICB0
eXBlIHNzaGRfdW5pdF9maWxlX3Q7CiAgICB0eXBlIHNzaF9hZ2VudF9leGVjX3Q7CiAgICB0eXBl
IHNzaF9leGVjX3Q7CiAgICB0eXBlIHNzaF9ob21lX3Q7CiAgICB0eXBlIHNzaF9rZXlnZW5fZXhl
Y190OwogICAgdHlwZSBzc2hfcG9ydF90OwogICAgdHlwZSBzdV9leGVjX3Q7CiAgICB0eXBlIHN5
c2N0bF9jcnlwdG9fdDsKICAgIHR5cGUgc3lzY3RsX2tlcm5lbF90OwogICAgdHlwZSBzeXNjdGxf
bmV0X3Q7CiAgICB0eXBlIHN5c2N0bF90OwogICAgdHlwZSBzeXNmc190OwogICAgdHlwZSBzeXNs
b2dfY29uZl90OwogICAgdHlwZSBzeXNsb2dkX3Q7CiAgICB0eXBlIHN5c3RlbV9jcm9uam9iX3Q7
CiAgICB0eXBlIHN5c3RlbV9kYnVzZF90OwogICAgdHlwZSBzeXN0ZW1fZGJ1c2RfdmFyX2xpYl90
OwogICAgdHlwZSBzeXN0ZW1fZGJ1c2RfdmFyX3J1bl90OwogICAgdHlwZSBzeXN0ZW1kX2hvc3Ru
YW1lZF90OwogICAgdHlwZSBzeXN0ZW1kX2xvZ2luZF90OwogICAgdHlwZSBzeXN0ZW1kX2xvZ2lu
ZF9zZXNzaW9uc190OwogICAgdHlwZSBzeXN0ZW1kX3Bhc3N3ZF9hZ2VudF9leGVjX3Q7CiAgICB0
eXBlIHN5c3RlbWRfcGFzc3dkX3Zhcl9ydW5fdDsKICAgIHR5cGUgc3lzdGVtZF9zeXN0ZW1jdGxf
ZXhlY190OwogICAgdHlwZSBzeXN0ZW1kX3RtcGZpbGVzX3Q7CiAgICB0eXBlIHN5c3RlbWRfdW5p
dF9maWxlX3Q7CiAgICB0eXBlIHRtcGZzX3Q7CiAgICB0eXBlIHRtcF90OwogICAgdHlwZSB0dW5l
ZF90OwogICAgdHlwZSB1ZGV2X3Q7CiAgICB0eXBlIHVuY29uZmluZWRfc2VydmljZV90OwogICAg
dHlwZSB1bmNvbmZpbmVkX3Q7CiAgICB0eXBlIHVucmVzZXJ2ZWRfcG9ydF90OwogICAgdHlwZSB1
cmFuZG9tX2RldmljZV90OwogICAgdHlwZSB1c2VyYWRkX2V4ZWNfdDsKICAgIHR5cGUgdXNlcl9k
ZXZwdHNfdDsKICAgIHR5cGUgdXNlcl9ob21lX2Rpcl90OwogICAgdHlwZSB1c2VyX2hvbWVfdDsK
ICAgIHR5cGUgdXNlcl90bXBfdDsKICAgIHR5cGUgdXNlcl90dHlfZGV2aWNlX3Q7CiAgICB0eXBl
IHVzcl90OwogICAgdHlwZSB2YXJfbGliX3Q7CiAgICB0eXBlIHZhcl9sb2dfdDsKICAgIHR5cGUg
dmFyX3J1bl90OwogICAgdHlwZSB2YXJfc3Bvb2xfdDsKICAgIHR5cGUgdmFyX3Q7CiAgICB0eXBl
IHhzZXJ2ZXJfcG9ydF90Owp9OwojIGZvciBkZXZlbG9wbWVudCBhbmQgdGVzdCBvbiBWTQpvcHRp
b25hbCB7CiAgICByZXF1aXJlIHsKICAgICAgICB0eXBlIHZtdG9vbHNfdDsKICAgIH07CiAgICBh
bGxvdyBDRFRtbF90eXBlcyB2bXRvb2xzX3Q6ZGlyIHsgZ2V0YXR0ciBvcGVuIHNlYXJjaCB9Owog
ICAgYWxsb3cgQ0RUbWxfdHlwZXMgdm10b29sc190OmZpbGUgeyBvcGVuIHJlYWQgfTsKfTsKCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
CiMKIyB0eXBlIGF0dHJpYnV0ZXMgdG8gc2ltcGxpZnkgbWFueSBydWxlcwphdHRyaWJ1dGUgQ0RU
bWxfZXhlYzsKYXR0cmlidXRlIENEVG1sX2NvbmY7CmF0dHJpYnV0ZSBDRFRtbF9maWxlOwphdHRy
aWJ1dGUgQ0RUbWxfc2VydmljZTsKYXR0cmlidXRlIENEVG1sX3R5cGVzOwoKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIENvcmUg
Q0RUbWwgdHlwZXMKdHlwZSBuaWNTaWRlSGlnaF90Owp0eXBlIG5pY1NpZGVMb3dfdDsKCnR5cGUg
eGZlclJvb3RfdCwgQ0RUbWxfdHlwZXM7CnR5cGUgeGZlclJvb3RMMkhfdCwgQ0RUbWxfdHlwZXM7
CnR5cGUgeGZlclJvb3RIMkxfdCwgQ0RUbWxfdHlwZXM7CgojIHByaW1hcmlseSBwcm9jZXNzIHR5
cGVzCiN0eXBlIHhmZXJIaWdoMkxvY2FsX3QsIENEVG1sX3R5cGVzLCBkb21haW4sIHVzZXJkb21h
aW4sIHByb2Nlc3NfdXNlcl90YXJnZXQ7CnR5cGUgeGZlckhpZ2gyTG9jYWxfdCwgQ0RUbWxfdHlw
ZXMsIHVzZXJkb21haW4sIHByb2Nlc3NfdXNlcl90YXJnZXQ7CnR5cGUgeGZlckxvY2FsMkxvd190
LCBDRFRtbF90eXBlcywgQ0RUbWxfc2VydmljZTsKdHlwZSB4ZmVyTG93MkxvY2FsX3QsIENEVG1s
X3R5cGVzLCBDRFRtbF9zZXJ2aWNlOwp0eXBlIHhmZXJMb2NhbDJIaWdoX3QsIENEVG1sX3R5cGVz
LCBDRFRtbF9zZXJ2aWNlOwojIGZpbGUgYW5kIGZvbGRlciB0eXBlcwp0eXBlIHhmZXJMb2NhbDJM
b3dfZGF0YV90LCBDRFRtbF9maWxlOwp0eXBlIHhmZXJMb3cyTG9jYWxfZGF0YV90LCBDRFRtbF9m
aWxlOwp0eXBlIHhmZXJMb2NhbDJIaWdoX2RhdGFfdCwgQ0RUbWxfZmlsZTsKCnR5cGUgeGZlckFk
bWluX3QsIENEVG1sX3R5cGVzLCBjYW5fY2hhbmdlX29iamVjdF9pZGVudGl0eTsKdHlwZSB4ZmVy
QWRtaW5fZXhlY190LCBDRFRtbF90eXBlczsKdHlwZSB4ZmVyX2V0Y190LCBDRFRtbF90eXBlczsK
dHlwZSB4ZmVyVmFyX3QsIENEVG1sX3R5cGVzOwp0eXBlIHhmZXJMaWJfdCwgQ0RUbWxfdHlwZXM7
Cgp0eXBlIHhmZXJBdWRpdF90LCBDRFRtbF90eXBlcywgdXNlcmRvbWFpbiwgcHJvY2Vzc191c2Vy
X3RhcmdldDsKdHlwZSB4ZmVyQXVkaXRfZXhlY190LCBDRFRtbF90eXBlczsKCnR5cGUgeGZlclNF
TGludXhfdCwgQ0RUbWxfdHlwZXM7Cgp0eXBlIHhmZXJGaWx0ZXJfdCwgQ0RUbWxfdHlwZXM7CnR5
cGUgeGZlckFWX3QsIENEVG1sX3R5cGVzOwp0eXBlIHhmZXJBVl9ldGNfdCwgQ0RUbWxfdHlwZXM7
CnR5cGUgeGZlckFWZmFpbF90LCBDRFRtbF90eXBlczsKdHlwZSB4ZmVyRFdDX3QsIENEVG1sX3R5
cGVzOwp0eXBlIHhmZXJEV0NfZGF0YV90LCBDRFRtbF9maWxlOwp0eXBlIHhmZXJEV0NfZXRjX3Qs
IENEVG1sX3R5cGVzOwoKdHlwZSB4ZmVySGlnaDJMb2NhbF9leGVjX3QsIENEVG1sX3R5cGVzLCBD
RFRtbF9leGVjOwp0eXBlIHhmZXJMb2NhbDJMb3dfZXhlY190LCBDRFRtbF90eXBlcywgQ0RUbWxf
ZXhlYzsKdHlwZSB4ZmVyTG93MkxvY2FsX2V4ZWNfdCwgQ0RUbWxfdHlwZXMsIENEVG1sX2V4ZWM7
CnR5cGUgeGZlckxvY2FsMkhpZ2hfZXhlY190LCBDRFRtbF90eXBlcywgQ0RUbWxfZXhlYzsKCnR5
cGUgeGZlckFWX2V4ZWNfdCwgQ0RUbWxfdHlwZXMsIENEVG1sX2V4ZWM7CnR5cGUgeGZlckRXQ19l
eGVjX3QsIENEVG1sX3R5cGVzLCBDRFRtbF9leGVjOwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIEJhc2ljIHN5c3RlbSBhY2Nl
c3NlcyB0byBDRFRtbCB0eXBlcwpyb2xlIG9iamVjdF9yIHR5cGVzIHsKICAgIENEVG1sX3R5cGVz
Cn07CnJvbGUgc3lzdGVtX3IgIHR5cGVzIHsKICAgIENEVG1sX3R5cGVzCn07CnJvbGUgdW5jb25m
aW5lZF9yIHR5cGVzIHsKICAgIENEVG1sX3R5cGVzCn07CgojIGZvciBhaWRlLCBhdCBsZWFzdCB3
aGVuIHJ1biBkdXJpbmcgaW5zdGFsbAojIGNvbW1lbnRlZCBvdXQsIGJlY2F1c2Ugd2Ugc2hvdWxk
IHN0aWxsIGJlIGluIHBlcm1pc3NpdmUgbW9kZQojYWxsb3cgdW5jb25maW5lZF90IENEVG1sX3R5
cGVzOmZpbGUgbWFwOwojYWxsb3cgdW5jb25maW5lZF90IHhmZXJBdWRpdF90OmZpbGUgeyBpb2N0
bCBsb2NrIG1hcCB9OwoKYWxsb3cgewogICAgYWlkZV90CiAgICBwb2xpY3lraXRfdAogICAgcmVh
ZGFoZWFkX3QKICAgIHNldGZpbGVzX3QKfSB7IENEVG1sX2ZpbGUgQ0RUbWxfdHlwZXMgfTpmaWxl
IHsgZ2V0YXR0ciBpb2N0bCBtYXAgb3BlbiByZWFkIH07CgphbGxvdyB7CiAgICBhaWRlX3QKICAg
IHBvbGljeWtpdF90CiAgICBzZXRmaWxlc190Cn0geyBDRFRtbF9maWxlIENEVG1sX3R5cGVzIH06
ZGlyIHsgZ2V0YXR0ciByZWFkIG9wZW4gc2VhcmNoIH07CgphbGxvdyBzZXRmaWxlc190IHsgQ0RU
bWxfZmlsZSBDRFRtbF90eXBlcyB9OmRpciByZWxhYmVsdG87CmFsbG93IHNldGZpbGVzX3QgeyBD
RFRtbF9maWxlIENEVG1sX3R5cGVzIH06ZmlsZSByZWxhYmVsdG87CgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwojCiMgSGF2aW5nIGRl
ZmluZWQgb3VyIHR5cGVzLCBkZWZpbmUgb3VyIHJvbGVzLAojIGFuZCBncmFudCB0aGVtIGFjY2Vz
cyB0byBvdXIgdHlwZXMKcm9sZSBDRFRtbF9sb3cybG9jYWxfcjsKcm9sZSBDRFRtbF9sb2NhbDJo
aWdoX3I7CnJvbGUgQ0RUbWxfaGlnaDJsb2NhbF9yOwpyb2xlIENEVG1sX2xvY2FsMmxvd19yOwpy
b2xlIENEVG1sX2F1ZGl0b3JfcjsKCmFsbG93IHN5c3RlbV9yIHsKICAgIENEVG1sX2xvdzJsb2Nh
bF9yCiAgICBDRFRtbF9sb2NhbDJoaWdoX3IKICAgIENEVG1sX2hpZ2gybG9jYWxfcgogICAgQ0RU
bWxfbG9jYWwybG93X3IKICAgIENEVG1sX2F1ZGl0b3Jfcgp9OwphbGxvdyB1bmNvbmZpbmVkX3Ig
ewogICAgQ0RUbWxfbG93MmxvY2FsX3IKICAgIENEVG1sX2xvY2FsMmhpZ2hfcgogICAgQ0RUbWxf
aGlnaDJsb2NhbF9yCiAgICBDRFRtbF9sb2NhbDJsb3dfcgogICAgQ0RUbWxfYXVkaXRvcl9yCn07
Cgpyb2xlIENEVG1sX2xvdzJsb2NhbF9yIHR5cGVzIHsKICAgIHhmZXJMb3cyTG9jYWxfdAogICAg
eGZlckxvdzJMb2NhbF9leGVjX3QKfTsKcm9sZSBDRFRtbF9sb2NhbDJoaWdoX3IgdHlwZXMgewog
ICAgeGZlckxvY2FsMkhpZ2hfdAogICAgeGZlckxvY2FsMkhpZ2hfZXhlY190Cn07CnJvbGUgQ0RU
bWxfaGlnaDJsb2NhbF9yIHR5cGVzIHsKICAgIHhmZXJIaWdoMkxvY2FsX3QKICAgIHhmZXJIaWdo
MkxvY2FsX2V4ZWNfdAp9Owpyb2xlIENEVG1sX2xvY2FsMmxvd19yIHR5cGVzIHsKICAgIHhmZXJM
b2NhbDJMb3dfdAogICAgeGZlckxvY2FsMkxvd19leGVjX3QKfTsKcm9sZSBDRFRtbF9hdWRpdG9y
X3IgdHlwZXMgewogICAgeGZlckF1ZGl0X3QKICAgIHhmZXJBdWRpdF9leGVjX3QKfTsKCmFsbG93
IHhmZXJIaWdoMkxvY2FsX3QgIHhmZXJEV0NfZGF0YV90OmRpciB7IGFkZF9uYW1lIGdldGF0dHIg
b3BlbiByZWFkIHNlYXJjaCBzZXRhdHRyIHdyaXRlIH07CmFsbG93IHhmZXJIaWdoMkxvY2FsX3Qg
IHhmZXJEV0NfZGF0YV90OmZpbGUgeyBjcmVhdGUgZ2V0YXR0ciBvcGVuIHNldGF0dHIgd3JpdGUg
fTsKYWxsb3cgeGZlckRXQ190ICAgICAgICAgeGZlckRXQ19kYXRhX3Q6ZGlyIHsgZ2V0YXR0ciBv
cGVuIHJlYWQgcmVtb3ZlX25hbWUgc2VhcmNoIHdyaXRlIH07CmFsbG93IHhmZXJEV0NfdCAgICAg
ICAgIHhmZXJEV0NfZGF0YV90OmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB1bmxpbmsgfTsKYWxs
b3cgeGZlckRXQ190ICAgICAgICAgeGZlckxvY2FsMkxvd19kYXRhX3Q6ZGlyIHsgYWRkX25hbWUg
Z2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIHNldGF0dHIgd3JpdGUgfTsKYWxsb3cgeGZlckRXQ190
ICAgICAgICAgeGZlckxvY2FsMkxvd19kYXRhX3Q6ZmlsZSB7IGNyZWF0ZSBnZXRhdHRyIG9wZW4g
cmVhZCBzZXRhdHRyIHdyaXRlIH07CmFsbG93IHhmZXJMb2NhbDJMb3dfdCAgIHhmZXJMb2NhbDJM
b3dfZGF0YV90OmRpciB7IGdldGF0dHIgb3BlbiByZWFkIHJlbW92ZV9uYW1lIHNlYXJjaCB3cml0
ZSB9OwphbGxvdyB4ZmVyTG9jYWwyTG93X3QgICB4ZmVyTG9jYWwyTG93X2RhdGFfdDpmaWxlIHsg
Z2V0YXR0ciByZWFkIHVubGluayB9OwoKIyBwZXJtcyBmb3IgbG93IHRvIGxvY2FsLCB3aXRoIG9y
IHdpdGhvdXQgQVYKYWxsb3cgeGZlckxvdzJMb2NhbF90ICAgeyB4ZmVyTG93MkxvY2FsX2RhdGFf
dCB4ZmVyTG9jYWwySGlnaF9kYXRhX3QgfTpkaXIgeyBhZGRfbmFtZSBnZXRhdHRyIG9wZW4gcmVh
ZCBzZWFyY2ggc2V0YXR0ciB3cml0ZSB9OwphbGxvdyB4ZmVyTG93MkxvY2FsX3QgICB7IHhmZXJM
b3cyTG9jYWxfZGF0YV90IHhmZXJMb2NhbDJIaWdoX2RhdGFfdCB9OmZpbGUgeyBjcmVhdGUgZ2V0
YXR0ciBvcGVuIHNldGF0dHIgd3JpdGUgfTsKYWxsb3cgeyB4ZmVyTG9jYWwySGlnaF90IHhmZXJB
Vl90IH0geGZlckxvdzJMb2NhbF9kYXRhX3Q6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgcmVtb3Zl
X25hbWUgc2VhcmNoIHNldGF0dHIgd3JpdGUgfTsKYWxsb3cgeyB4ZmVyTG9jYWwySGlnaF90IHhm
ZXJBVl90IH0geGZlckxvdzJMb2NhbF9kYXRhX3Q6ZmlsZSB7IGdldGF0dHIgb3BlbiByZWFkIHVu
bGluayB9OwojIHJ1bGVzIHdoZW4gQVYgaXMgcnVubmluZwphbGxvdyB4ZmVyQVZfdCAgICAgICAg
ICB4ZmVyTG9jYWwySGlnaF9kYXRhX3Q6ZGlyIHsgYWRkX25hbWUgZ2V0YXR0ciBvcGVuIHJlYWQg
c2VhcmNoIHNldGF0dHIgfTsKYWxsb3cgeGZlckFWX3QgICAgICAgICAgeGZlckxvY2FsMkhpZ2hf
ZGF0YV90OmZpbGUgeyBjcmVhdGUgZ2V0YXR0ciBzZXRhdHRyIHdyaXRlIH07CmFsbG93IHhmZXJM
b2NhbDJIaWdoX3QgIHhmZXJMb2NhbDJIaWdoX2RhdGFfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVh
ZCByZW1vdmVfbmFtZSBzZWFyY2ggd3JpdGUgfTsKYWxsb3cgeGZlckxvY2FsMkhpZ2hfdCAgeGZl
ckxvY2FsMkhpZ2hfZGF0YV90OmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB1bmxpbmsgfTsKCmFs
bG93IHhmZXJMb3cyTG9jYWxfdCAgIHhmZXJBVmZhaWxfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVh
ZCByZW1vdmVfbmFtZSBzZWFyY2ggfTsKYWxsb3cgeGZlckxvdzJMb2NhbF90ICAgeGZlckFWZmFp
bF90OmZpbGUgeyBnZXRhdHRyIHNldGF0dHIgdW5saW5rIH07CmFsbG93IHhmZXJMb3cyTG9jYWxf
dCAgIHhmZXJMb2NhbDJIaWdoX2RhdGFfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVhZCBzZWFyY2gg
c2V0YXR0ciB9OwphbGxvdyB4ZmVyTG93MkxvY2FsX3QgICB4ZmVyTG9jYWwySGlnaF9kYXRhX3Q6
ZmlsZSBnZXRhdHRyOwphbGxvdyB4ZmVyQVZfdCAgICAgICAgICB4ZmVyQVZmYWlsX3Q6ZGlyIHsg
YWRkX25hbWUgZ2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIHNldGF0dHIgd3JpdGUgfTsKYWxsb3cg
eGZlckFWX3QgICAgICAgICAgeGZlckFWZmFpbF90OmZpbGUgeyBjcmVhdGUgZ2V0YXR0ciBzZXRh
dHRyIHdyaXRlIH07CgphbGxvdyB4ZmVyTG9jYWwyTG93X3QgICBuaWNTaWRlTG93X3Q6bmV0aWYg
eyBpbmdyZXNzIGVncmVzcyB9OwphbGxvdyB4ZmVyTG93MkxvY2FsX3QgICBuaWNTaWRlTG93X3Q6
bmV0aWYgeyBpbmdyZXNzIGVncmVzcyB9OwphbGxvdyB4ZmVyTG9jYWwySGlnaF90ICBuaWNTaWRl
SGlnaF90Om5ldGlmIHsgaW5ncmVzcyBlZ3Jlc3MgfTsKYWxsb3cgeGZlckhpZ2gyTG9jYWxfdCAg
bmljU2lkZUhpZ2hfdDpuZXRpZiB7IGluZ3Jlc3MgZWdyZXNzIH07CgphbGxvdyB7IAogICAgaW5p
dHJjX3QKICAgIHVuY29uZmluZWRfc2VydmljZV90CiAgICBzeXNsb2dkX3QKICAgIHN5c3RlbWRf
bG9naW5kX3QKICAgIHN5c3RlbWRfdG1wZmlsZXNfdAp9IENEVG1sX3R5cGVzOmZpbGUgeyBnZXRh
dHRyIGlvY3RsIG9wZW4gcmVhZCB9OwphbGxvdyB7IAogICAgaW5pdHJjX3QKICAgIHN5c2xvZ2Rf
dAogICAgc3lzdGVtZF9sb2dpbmRfdAogICAgc3lzdGVtZF90bXBmaWxlc190Cn0gQ0RUbWxfdHlw
ZXM6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIH07CmFsbG93IHsgCiAgICBpbml0cmNf
dAogICAgc3lzbG9nZF90CiAgICBzeXN0ZW1kX3RtcGZpbGVzX3QKfSBDRFRtbF90eXBlczpsbmtf
ZmlsZSB7IGdldGF0dHIgcmVhZCB9OwoKIyBEZWZpbmUgb3VyIHByb2Nlc3MgdHJhbnNpdGlvbnMg
LSBkZWZpbmUgdGhlbSBzbyB0aGF0IG9ubHkKIyBJQ01DIHVzZXJzIGNhbiB0cmFuc2l0aW9uIGZv
ciBIaWdoMkxvY2FsLCBidXQgYWxsIG90aGVyCiMgZG9tYWlucyBjYW4gYmUgZW50ZXJlZCBlaXRo
ZXIgdmlhIGxvZ2luIG9yIHZpYSBzeXN0ZW1kCmFsbG93IHVuY29uZmluZWRfdCB4ZmVySGlnaDJM
b2NhbF9leGVjX3Q6ZmlsZSB7IGdldGF0dHIgZXhlY3V0ZSBvcGVuIHJlYWQgfTsKYWxsb3cgeGZl
ckhpZ2gyTG9jYWxfdCB4ZmVySGlnaDJMb2NhbF9leGVjX3Q6ZmlsZSB7IGVudHJ5cG9pbnQgZXhl
Y3V0ZSBleGVjdXRlX25vX3RyYW5zIGdldGF0dHIgaW9jdGwgbG9jayBtYXAgb3BlbiByZWFkIH07
CmFsbG93IHhmZXJIaWdoMkxvY2FsX3Qgc3NoZF9leGVjX3Q6ZmlsZSB7IGVudHJ5cG9pbnQgfTsK
dHlwZV90cmFuc2l0aW9uIHVuY29uZmluZWRfdCB4ZmVySGlnaDJMb2NhbF9leGVjX3Q6cHJvY2Vz
cyB4ZmVySGlnaDJMb2NhbF90OwphbGxvdyB7IHNzaGRfdCB1bmNvbmZpbmVkX3QgfSB4ZmVySGln
aDJMb2NhbF90OnByb2Nlc3MgdHJhbnNpdGlvbjsKIAojIGluaXRfdCBuZWVkcyB0aGVzZSwgdG8g
c3RhcnQgZnJvbSBzeXN0ZW1kOyB1bmNvbmZpbmVkX3QgbmVlZHMgZm9yIHJvb3QKIyB0byBzdGFy
dCBzaW5nbGUgcHJvY2Vzc2VzOyB4ZmVyQWRtaW5fdCBuZWVkcyB0byBzdGFydCB0aGUgc3RhcnRB
bGwgdXRpbGl0eQphbGxvdyB7IGluaXRfdCB1bmNvbmZpbmVkX3QgeGZlckFkbWluX3QgfSB4ZmVy
TG9jYWwyTG93X2V4ZWNfdDpmaWxlIHsgZ2V0YXR0ciBleGVjdXRlIG9wZW4gcmVhZCB9OwphbGxv
dyB4ZmVyTG9jYWwyTG93X3QgeGZlckxvY2FsMkxvd19leGVjX3Q6ZmlsZSB7IGVudHJ5cG9pbnQg
ZXhlY3V0ZSBleGVjdXRlX25vX3RyYW5zIGdldGF0dHIgaW9jdGwgbG9jayBtYXAgb3BlbiByZWFk
IH07CnR5cGVfdHJhbnNpdGlvbiB7IGluaXRfdCB1bmNvbmZpbmVkX3QgeGZlckFkbWluX3QgfSAg
eGZlckxvY2FsMkxvd19leGVjX3Q6cHJvY2VzcyB4ZmVyTG9jYWwyTG93X3QgOwphbGxvdyB7IGlu
aXRfdCB1bmNvbmZpbmVkX3QgeGZlckFkbWluX3QgfSB4ZmVyTG9jYWwyTG93X3Q6cHJvY2VzcyB0
cmFuc2l0aW9uOwoKYWxsb3cgeyBpbml0X3QgdW5jb25maW5lZF90IHhmZXJBZG1pbl90IH0geGZl
ckxvdzJMb2NhbF9leGVjX3Q6ZmlsZSB7IGdldGF0dHIgZXhlY3V0ZSBvcGVuIHJlYWQgfTsKYWxs
b3cgeGZlckxvdzJMb2NhbF90IHhmZXJMb3cyTG9jYWxfZXhlY190OmZpbGUgeyBlbnRyeXBvaW50
IGV4ZWN1dGUgZXhlY3V0ZV9ub190cmFucyBnZXRhdHRyIGlvY3RsIGxvY2sgbWFwIG9wZW4gcmVh
ZCB9Owp0eXBlX3RyYW5zaXRpb24geyBpbml0X3QgdW5jb25maW5lZF90IHhmZXJBZG1pbl90IH0g
IHhmZXJMb3cyTG9jYWxfZXhlY190OnByb2Nlc3MgeGZlckxvdzJMb2NhbF90IDsKYWxsb3cgeyBp
bml0X3QgdW5jb25maW5lZF90IHhmZXJBZG1pbl90IH0geGZlckxvdzJMb2NhbF90OnByb2Nlc3Mg
dHJhbnNpdGlvbjsKCmFsbG93IHsgaW5pdF90IHVuY29uZmluZWRfdCB4ZmVyQWRtaW5fdCB9IHhm
ZXJMb2NhbDJIaWdoX2V4ZWNfdDpmaWxlIHsgZ2V0YXR0ciBleGVjdXRlIG9wZW4gcmVhZCB9Owph
bGxvdyB4ZmVyTG9jYWwySGlnaF90IHhmZXJMb2NhbDJIaWdoX2V4ZWNfdDpmaWxlIHsgZW50cnlw
b2ludCBleGVjdXRlIGV4ZWN1dGVfbm9fdHJhbnMgZ2V0YXR0ciBpb2N0bCBsb2NrIG1hcCBvcGVu
IHJlYWQgfTsKdHlwZV90cmFuc2l0aW9uIHsgaW5pdF90IHVuY29uZmluZWRfdCB4ZmVyQWRtaW5f
dCB9ICB4ZmVyTG9jYWwySGlnaF9leGVjX3Q6cHJvY2VzcyB4ZmVyTG9jYWwySGlnaF90IDsKYWxs
b3cgeyBpbml0X3QgdW5jb25maW5lZF90IHhmZXJBZG1pbl90IH0geGZlckxvY2FsMkhpZ2hfdDpw
cm9jZXNzIHRyYW5zaXRpb247CgojIHdlIG5lZWQgdG8gYWxsb3cgYXVkaXRvcnMgdG8gdHJhbnNp
dGlvbiB0byB0aGVpciBkb21haW4KYWxsb3cgeyBzc2hkX3QgdW5jb25maW5lZF90IH0geGZlckF1
ZGl0X3Q6cHJvY2VzcyB0cmFuc2l0aW9uOwoKIyBkZWZpbmUgb3VyIGZpbGUgdHJhbnNpdGlvbnM6
IFRoZXNlIGVuc3VyZSB0aGUgTGluZWFyIEFzc3VyZWQgUGlwZWxpbmUKdHlwZV90cmFuc2l0aW9u
IHhmZXJMb3cyTG9jYWxfdCB4ZmVyTG9jYWwySGlnaF9kYXRhX3Q6ZmlsZSB4ZmVyTG9jYWwySGln
aF9kYXRhX3Q7CnR5cGVfdHJhbnNpdGlvbiB4ZmVySGlnaDJMb2NhbF90IHhmZXJMb2NhbDJMb3df
ZGF0YV90OmZpbGUgeGZlckxvY2FsMkxvd19kYXRhX3Q7CgojIGFsbG93IGFkbWluaXN0cmF0b3Jz
IHRvIHN0YXJ0IGFuZCBzdG9wIHNlcnZpY2VzLCBtb25pdG9yIHRoZW0sIGV0Yy4KYWxsb3cgdW5j
b25maW5lZF90IENEVG1sX3R5cGVzOmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB9OwphbGxvdyB1
bmNvbmZpbmVkX3QgQ0RUbWxfdHlwZXM6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxsb3cgdW5j
b25maW5lZF90IENEVG1sX3R5cGVzOnByb2Nlc3MgeyBnZXRhdHRyIH07CmFsbG93IHVuY29uZmlu
ZWRfdCB4ZmVyQWRtaW5fZXhlY190OmZpbGUgeyBleGVjdXRlIGdldGF0dHIgb3BlbiByZWFkIH07
CiMgYnV0IGxpbWl0IHdobyBjYW4gZG8gd2hhdCB3aXRoIGEgdHlwZSB0cmFuc2l0aW9uCmFsbG93
IHhmZXJBZG1pbl90IHhmZXJBZG1pbl9leGVjX3Q6ZmlsZSB7IGVudHJ5cG9pbnQgZXhlY3V0ZSBl
eGVjdXRlX25vX3RyYW5zIGdldGF0dHIgaW9jdGwgbG9jayBtYXAgb3BlbiByZWFkIH07CnR5cGVf
dHJhbnNpdGlvbiB1bmNvbmZpbmVkX3QgeGZlckFkbWluX2V4ZWNfdDpwcm9jZXNzIHhmZXJBZG1p
bl90OwphbGxvdyB1bmNvbmZpbmVkX3QgeGZlckFkbWluX3Q6cHJvY2VzcyB0cmFuc2l0aW9uOwph
bGxvdyB1bmNvbmZpbmVkX3QgeGZlckFkbWluX2V4ZWNfdDpmaWxlIHsgYXBwZW5kIHJlbGFiZWx0
byB9OwphbGxvdyB1bmNvbmZpbmVkX3QgeyBDRFRtbF90eXBlcyBDRFRtbF9maWxlIH06ZGlyIHsg
Z2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIH07CiMgdGhlbiBsZXQgb3VyIG93biBwcm9jZXNzIHJl
bGFiZWwgZXZlcnl0aGluZyB3ZSBvd24KYWxsb3cgeGZlckFkbWluX3QgYWlkZV9sb2dfdDpkaXIg
eyBnZXRhdHRyIG9wZW4gcmVhZCByZWxhYmVsdG8gc2VhcmNoIH07CmFsbG93IHhmZXJBZG1pbl90
IGFpZGVfbG9nX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07CmFsbG93IHhmZXJBZG1pbl90
IGJpbl90OmRpciB7IHJlbGFiZWxmcm9tIHJlbGFiZWx0byB9OwphbGxvdyB4ZmVyQWRtaW5fdCBi
aW5fdDpmaWxlIHsgcmVsYWJlbGZyb20gcmVsYWJlbHRvIH07CmFsbG93IHhmZXJBZG1pbl90IGJv
b3RfdDpkaXIgZ2V0YXR0cjsKYWxsb3cgeGZlckFkbWluX3QgY2dyb3VwX3Q6ZGlyIHsgZ2V0YXR0
ciBzZWFyY2ggfTsKYWxsb3cgeGZlckFkbWluX3QgY2dyb3VwX3Q6ZmlsZXN5c3RlbSBnZXRhdHRy
OwphbGxvdyB4ZmVyQWRtaW5fdCBkZWZhdWx0X2NvbnRleHRfdDpmaWxlIHsgZ2V0YXR0ciBvcGVu
IHJlYWQgfTsKYWxsb3cgeGZlckFkbWluX3QgZGVmYXVsdF90OmRpciB7IGdldGF0dHIgcmVsYWJl
bGZyb20gfTsKYWxsb3cgeGZlckFkbWluX3QgZGV2aWNlX3Q6ZmlsZXN5c3RlbSBnZXRhdHRyOwph
bGxvdyB4ZmVyQWRtaW5fdCBkZXZwdHNfdDpkaXIgZ2V0YXR0cjsKYWxsb3cgeGZlckFkbWluX3Qg
ZmlsZV9jb250ZXh0X3Q6ZGlyIHNlYXJjaDsKYWxsb3cgeGZlckFkbWluX3QgZmlsZV9jb250ZXh0
X3Q6ZmlsZSB7IGdldGF0dHIgbWFwIG9wZW4gcmVhZCB9OwphbGxvdyB4ZmVyQWRtaW5fdCBodWdl
dGxiZnNfdDpkaXIgZ2V0YXR0cjsKYWxsb3cgeGZlckFkbWluX3QgaHVnZXRsYmZzX3Q6ZmlsZXN5
c3RlbSBnZXRhdHRyOwphbGxvdyB4ZmVyQWRtaW5fdCBsaWJfdDpkaXIgcmVsYWJlbGZyb207CmFs
bG93IHhmZXJBZG1pbl90IGxpYl90OmZpbGUgcmVsYWJlbGZyb207CmFsbG93IHhmZXJBZG1pbl90
IHNlbGY6ZGlyIHJlbGFiZWx0bzsKYWxsb3cgeGZlckFkbWluX3Qgc2VsZjpmaWxlIHJlbGFiZWx0
bzsKYWxsb3cgeGZlckFkbWluX3Qgc2VsaW51eF9jb25maWdfdDpmaWxlIHsgZ2V0YXR0ciBvcGVu
IHJlYWQgfTsKYWxsb3cgeGZlckFkbWluX3Qgc2V0ZmlsZXNfZXhlY190OmZpbGUgeyBleGVjdXRl
IGV4ZWN1dGVfbm9fdHJhbnMgZ2V0YXR0ciBtYXAgb3BlbiByZWFkIH07CmFsbG93IHhmZXJBZG1p
bl90IHN5c2ZzX3Q6ZGlyIGdldGF0dHI7CmFsbG93IHhmZXJBZG1pbl90IHN5c2ZzX3Q6ZmlsZXN5
c3RlbSBnZXRhdHRyOwphbGxvdyB4ZmVyQWRtaW5fdCB0bXBmc190OmRpciBnZXRhdHRyOwphbGxv
dyB4ZmVyQWRtaW5fdCB0bXBmc190OmZpbGVzeXN0ZW0gZ2V0YXR0cjsKYWxsb3cgeGZlckFkbWlu
X3QgdXNlcl90bXBfdDpkaXIgZ2V0YXR0cjsKYWxsb3cgeGZlckFkbWluX3QgdXNyX3Q6ZGlyIHJl
bGFiZWxmcm9tOwphbGxvdyB4ZmVyQWRtaW5fdCB1c3JfdDpmaWxlIHJlbGFiZWxmcm9tOwphbGxv
dyB4ZmVyQWRtaW5fdCB4ZmVyQVZfZXRjX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07CmFs
bG93IHhmZXJBZG1pbl90IHhmZXJBVl9leGVjX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07
CmFsbG93IHhmZXJBZG1pbl90IHhmZXJBVl90OmZpbGUgeyBnZXRhdHRyIHJlbGFiZWx0byB9Owph
bGxvdyB4ZmVyQWRtaW5fdCB4ZmVyQVZmYWlsX3Q6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgcmVs
YWJlbHRvIHNlYXJjaCB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyQWRtaW5fZXhlY190OmZpbGUg
cmVsYWJlbHRvOwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyQXVkaXRfZXhlY190OmZpbGUgeyBnZXRh
dHRyIHJlbGFiZWx0byB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyQXVkaXRfdDpkaXIgeyBnZXRh
dHRyIG9wZW4gcmVhZCByZWxhYmVsdG8gc2VhcmNoIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJB
dWRpdF90OmZpbGUgeyBnZXRhdHRyIHJlbGFiZWx0byB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVy
RFdDX2RhdGFfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVhZCByZWxhYmVsdG8gc2VhcmNoIH07CmFs
bG93IHhmZXJBZG1pbl90IHhmZXJEV0NfZXRjX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07
CmFsbG93IHhmZXJBZG1pbl90IHhmZXJEV0NfZXhlY190OmZpbGUgeyBnZXRhdHRyIHJlbGFiZWx0
byB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyRFdDX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRv
IH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJGaWx0ZXJfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVh
ZCByZWxhYmVsdG8gc2VhcmNoIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJMaWJfdDpkaXIgcmVs
YWJlbHRvOwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyTG9jYWwySGlnaF9kYXRhX3Q6ZGlyIHsgZ2V0
YXR0ciBvcGVuIHJlYWQgcmVsYWJlbHRvIHNlYXJjaCB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVy
TG9jYWwySGlnaF9leGVjX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07CmFsbG93IHhmZXJB
ZG1pbl90IHhmZXJMb2NhbDJIaWdoX3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07CmFsbG93
IHhmZXJBZG1pbl90IHhmZXJMb2NhbDJMb3dfZGF0YV90OmRpciB7IGdldGF0dHIgb3BlbiByZWFk
IHJlbGFiZWx0byBzZWFyY2ggfTsKYWxsb3cgeGZlckFkbWluX3QgeGZlckxvY2FsMkxvd19leGVj
X3Q6ZmlsZSB7IGdldGF0dHIgcmVsYWJlbHRvIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJMb2Nh
bDJMb3dfdDpmaWxlIHsgZ2V0YXR0ciByZWxhYmVsdG8gfTsKYWxsb3cgeGZlckFkbWluX3QgeGZl
ckxvdzJMb2NhbF9kYXRhX3Q6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgcmVsYWJlbHRvIHNlYXJj
aCB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyTG93MkxvY2FsX2V4ZWNfdDpmaWxlIHsgZ2V0YXR0
ciByZWxhYmVsdG8gfTsKYWxsb3cgeGZlckFkbWluX3QgeGZlckxvdzJMb2NhbF90OmZpbGUgeyBn
ZXRhdHRyIHJlbGFiZWx0byB9OwphbGxvdyB4ZmVyQWRtaW5fdCB4ZmVyUm9vdEgyTF90OmRpciB7
IGdldGF0dHIgb3BlbiByZWFkIHJlbGFiZWx0byBzZWFyY2ggfTsKYWxsb3cgeGZlckFkbWluX3Qg
eGZlclJvb3RMMkhfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVhZCByZWxhYmVsdG8gc2VhcmNoIH07
CmFsbG93IHhmZXJBZG1pbl90IHhmZXJSb290X3Q6ZGlyIHJlbGFiZWx0bzsKYWxsb3cgeGZlckFk
bWluX3QgeGZlclNFTGludXhfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVhZCByZWxhYmVsdG8gc2Vh
cmNoIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJTRUxpbnV4X3Q6ZmlsZSB7IGdldGF0dHIgcmVs
YWJlbHRvIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJWYXJfdDpkaXIgeyBnZXRhdHRyIG9wZW4g
cmVhZCByZWxhYmVsdG8gc2VhcmNoIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJfZXRjX3Q6ZGly
IHsgZ2V0YXR0ciBvcGVuIHJlYWQgcmVsYWJlbHRvIHNlYXJjaCB9OwojCiMgYWRtaW5pc3RyYXRp
dmUgZnVuY3Rpb25zLCBlc3BlY2lhbGx5IHVzZXIgY3JlYXRpb24KYWxsb3cgeGZlckFkbWluX3Qg
Y2hrcHdkX2V4ZWNfdDpmaWxlIHsgZXhlY3V0ZSBleGVjdXRlX25vX3RyYW5zIG1hcCBvcGVuIHJl
YWQgfTsKYWxsb3cgeGZlckFkbWluX3QgY3JhY2tfZGJfdDpmaWxlIHsgZ2V0YXR0ciBvcGVuIHJl
YWQgfTsKYWxsb3cgeGZlckFkbWluX3QgZGV2dHR5X3Q6Y2hyX2ZpbGUgZ2V0YXR0cjsKYWxsb3cg
eGZlckFkbWluX3QgbWFpbF9zcG9vbF90OmRpciBzZWFyY2g7CmFsbG93IHhmZXJBZG1pbl90IG1h
aWxfc3Bvb2xfdDpmaWxlIG9wZW47CmFsbG93IHhmZXJBZG1pbl90IHBhc3N3ZF9leGVjX3Q6Zmls
ZSB7IGV4ZWN1dGUgZXhlY3V0ZV9ub190cmFucyBnZXRhdHRyIG1hcCBvcGVuIHJlYWQgfTsKYWxs
b3cgeGZlckFkbWluX3QgcGFzc3dkX2ZpbGVfdDpmaWxlIHsgaW9jdGwgbG9jayB9OwphbGxvdyB4
ZmVyQWRtaW5fdCBzZWxmOmZpbGUgcmVsYWJlbGZyb207CmFsbG93IHhmZXJBZG1pbl90IHVzZXJh
ZGRfZXhlY190OmZpbGUgeyBleGVjdXRlIGV4ZWN1dGVfbm9fdHJhbnMgZ2V0YXR0ciBtYXAgb3Bl
biByZWFkIH07CmFsbG93IHhmZXJBZG1pbl90IHhmZXJBdWRpdF9leGVjX3Q6ZmlsZSByZWxhYmVs
ZnJvbTsKIyBmaW5hbGx5LCBhbGxvdyB4ZmVyQWRtaW5fdCB0byBzdGFydCBhbmQgc3RvcCB0aGlu
Z3MsIHRvbwojIChzaW5jZSB0aGUgc3RhcnRhbGwgdXRpbGl0eSBpcyBub3cgeGZlcl9hZG1pbl90
CiMgTk9URTogVGhlc2Ugd2VyZSBhZGRlZCBhYm92ZS4KCiMgdGhlc2UgbWF5IHNlZW0gb2RkLCBi
dXQgdGhlc2UgYWxsb3cgdGhlIHNlcnZpY2VzIHRvIHNlZSBlYWNoIG90aGVyJ3MKIyBwcm9jZXNz
IGluZm9ybWF0aW9uIC0gdGhlIGRpcnMgYW5kIGZpbGVzIGFyZSBpbiAvcHJvYyAtIHdoZW4gcnVu
bmluZwojIGFueSBvZiB0aGUgYWRtaW5pc3RyYXRpdmUgc3RhdHVzIGNvbW1hbmRzCmFsbG93IHhm
ZXJMb2NhbDJIaWdoX3QgeGZlckxvY2FsMkxvd190OmRpciB7IGdldGF0dHIgc2VhcmNoIH07CmFs
bG93IHhmZXJMb2NhbDJIaWdoX3QgeGZlckxvY2FsMkxvd190OmZpbGUgeyBvcGVuIHJlYWQgfTsK
YWxsb3cgeGZlckxvY2FsMkhpZ2hfdCB4ZmVyTG93MkxvY2FsX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFy
Y2ggfTsKYWxsb3cgeGZlckxvY2FsMkhpZ2hfdCB4ZmVyTG93MkxvY2FsX3Q6ZmlsZSB7IG9wZW4g
cmVhZCB9OwphbGxvdyB4ZmVyTG9jYWwyTG93X3QgeGZlckxvY2FsMkhpZ2hfdDpkaXIgeyBnZXRh
dHRyIHNlYXJjaCB9OwphbGxvdyB4ZmVyTG9jYWwyTG93X3QgeGZlckxvY2FsMkhpZ2hfdDpmaWxl
IHsgb3BlbiByZWFkIH07CmFsbG93IHhmZXJMb2NhbDJMb3dfdCB4ZmVyTG93MkxvY2FsX3Q6ZGly
IHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxsb3cgeGZlckxvY2FsMkxvd190IHhmZXJMb3cyTG9jYWxf
dDpmaWxlIHsgb3BlbiByZWFkIH07CmFsbG93IHhmZXJMb3cyTG9jYWxfdCB4ZmVyTG9jYWwySGln
aF90OmRpciB7IGdldGF0dHIgc2VhcmNoIH07CmFsbG93IHhmZXJMb3cyTG9jYWxfdCB4ZmVyTG9j
YWwySGlnaF90OmZpbGUgeyBvcGVuIHJlYWQgfTsKYWxsb3cgeGZlckxvdzJMb2NhbF90IHhmZXJM
b2NhbDJMb3dfdDpkaXIgeyBnZXRhdHRyIHNlYXJjaCB9OwphbGxvdyB4ZmVyTG93MkxvY2FsX3Qg
eGZlckxvY2FsMkxvd190OmZpbGUgeyBvcGVuIHJlYWQgfTsKIyBkbyBzb21ldGhpbmcgc2ltaWxh
ciBmb3IgY3JvbiAtIHBhcnQgb2YgY3JlYXRpbmcgdGhlIGRhaWx5IHJlcG9ydAphbGxvdyBzeXN0
ZW1fY3JvbmpvYl90IHhmZXJMb2NhbDJIaWdoX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxs
b3cgc3lzdGVtX2Nyb25qb2JfdCB4ZmVyTG9jYWwySGlnaF90OmZpbGUgeyBvcGVuIHJlYWQgfTsK
YWxsb3cgc3lzdGVtX2Nyb25qb2JfdCB4ZmVyTG9jYWwyTG93X3Q6ZGlyIHsgZ2V0YXR0ciBzZWFy
Y2ggfTsKYWxsb3cgc3lzdGVtX2Nyb25qb2JfdCB4ZmVyTG9jYWwyTG93X3Q6ZmlsZSB7IG9wZW4g
cmVhZCB9OwphbGxvdyBzeXN0ZW1fY3JvbmpvYl90IHhmZXJMb3cyTG9jYWxfdDpkaXIgeyBnZXRh
dHRyIHNlYXJjaCB9OwphbGxvdyBzeXN0ZW1fY3JvbmpvYl90IHhmZXJMb3cyTG9jYWxfdDpmaWxl
IHsgb3BlbiByZWFkIH07CgojIGFsbG93IGluaXRfdCwgZXRjLiwgdG8gc3RhcnQgdGhlIHNlcnZp
Y2VzCmFsbG93IHsgeGZlckFkbWluX3QgaW5pdF90IH0gQ0RUbWxfc2VydmljZTpwcm9jZXNzIHsg
bm9hdHNlY3VyZSBybGltaXRpbmggc2lnaW5oIHNpZ2tpbGwgc2lnbnVsbCBzaWduYWwgfTsKYWxs
b3cgQ0RUbWxfc2VydmljZSB7IHhmZXJBZG1pbl90IGluaXRfdH06cHJvY2VzcyB7IHNpZ2NobGQg
fTsKYWxsb3cgQ0RUbWxfc2VydmljZSB7IHhmZXJBZG1pbl90IGluaXRfdCB9OmZkIHsgdXNlIH07
CmFsbG93IENEVG1sX3NlcnZpY2UgaW5pdF90OnVuaXhfc3RyZWFtX3NvY2tldCB7IGNvbm5lY3R0
byBnZXRhdHRyIGlvY3RsIHJlYWQgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfc2VydmljZSBpbml0X3Rt
cF90OmZpbGUgeyBhcHBlbmQgY3JlYXRlIGdldGF0dHIgaW9jdGwgbG9jayBtYXAgb3BlbiByZWFk
IHdyaXRlIH07CmFsbG93IENEVG1sX3NlcnZpY2UgeGZlckFkbWluX3Q6Zmlmb19maWxlIHsgZ2V0
YXR0ciBpb2N0bCBvcGVuIHJlYWQgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfc2VydmljZSB4ZmVyQWRt
aW5fdDpmaWxlIHsgb3BlbiByZWFkIH07CmFsbG93IENEVG1sX3NlcnZpY2UgeGZlckFkbWluX3Q6
a2V5IHsgbGluayByZWFkIHNlYXJjaCB2aWV3IH07CgphbGxvdyBDRFRtbF90eXBlcyB4ZmVyVmFy
X3Q6ZGlyIHsgYWRkX25hbWUgcmVtb3ZlX25hbWUgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMg
eGZlclZhcl90OmZpbGUgeyBhcHBlbmQgY3JlYXRlIGdldGF0dHIgaW9jdGwgbG9jayBtYXAgb3Bl
biByZWFkIHVubGluayB3cml0ZSB9OwoKYWxsb3cgQ0RUbWxfdHlwZXMgeGZlclJvb3RfdDpkaXIg
eyBnZXRhdHRyIG9wZW4gcmVhZCBzZWFyY2ggfTsKYWxsb3cgeyB4ZmVyTG93MkxvY2FsX3QgeGZl
ckxvY2FsMkhpZ2hfdCB9IHhmZXJSb290TDJIX3Q6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgc2Vh
cmNoIH07CmFsbG93IHsgeGZlckhpZ2gyTG9jYWxfdCB4ZmVyTG9jYWwyTG93X3QgfSB4ZmVyUm9v
dEgyTF90OmRpciB7IGdldGF0dHIgb3BlbiByZWFkIHNlYXJjaCB9OwoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIEdlbmVyYWwg
c3lzdGVtIGFjY2VzcwphbGxvdyBDRFRtbF90eXBlcyBhZG1pbl9ob21lX3Q6ZGlyIHsgYWRkX25h
bWUgZ2V0YXR0ciBvcGVuIHJlYWQgcmVtb3ZlX25hbWUgc2VhcmNoIHdyaXRlIH07CmFsbG93IENE
VG1sX3R5cGVzIGFkbWluX2hvbWVfdDpmaWxlIHsgYXBwZW5kIGNyZWF0ZSBnZXRhdHRyIGlvY3Rs
IG9wZW4gcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBiaW5fdDpkaXIgeyBnZXRhdHRy
IG9wZW4gcmVhZCBzZWFyY2ggfTsKYWxsb3cgQ0RUbWxfdHlwZXMgYmluX3Q6ZmlsZSB7IGV4ZWN1
dGUgZXhlY3V0ZV9ub190cmFucyBnZXRhdHRyIGlvY3RsIG1hcCBvcGVuIHJlYWQgfTsKYWxsb3cg
Q0RUbWxfdHlwZXMgYmluX3Q6bG5rX2ZpbGUgeyBvcGVuIHJlYWQgfTsKYWxsb3cgeyBDRFRtbF90
eXBlcyB4ZmVyQWRtaW5fdCB9IGNlcnRfdDpmaWxlIHsgZ2V0YXR0ciBvcGVuIHJlYWQgfTsKYWxs
b3cgeyBDRFRtbF9zZXJ2aWNlIHhmZXJBZG1pbl90IH0gY2VydF90OmRpciB7IGdldGF0dHIgb3Bl
biByZWFkIHNlYXJjaCB9OwphbGxvdyBDRFRtbF90eXBlcyBjaHJvbnlkX3VuaXRfZmlsZV90OnNl
cnZpY2UgeyBzdGFydCBzdGF0dXMgZW5hYmxlIGRpc2FibGUgc3RhcnQgc3RvcCB9OwphbGxvdyBD
RFRtbF90eXBlcyBjcHVfb25saW5lX3Q6ZmlsZSB7IGdldGF0dHIgaW9jdGwgb3BlbiByZWFkIH07
CmFsbG93IENEVG1sX3R5cGVzIGRldmljZV90OmRpciBzZWFyY2g7CmFsbG93IENEVG1sX3R5cGVz
IGRldmxvZ190OnNvY2tfZmlsZSB3cml0ZTsKYWxsb3cgQ0RUbWxfdHlwZXMgZGV2cHRzX3Q6Y2hy
X2ZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBkZXZw
dHNfdDpmaWxlc3lzdGVtIHsgZ2V0YXR0ciB9OwphbGxvdyBDRFRtbF90eXBlcyBkZXZ0dHlfdDpj
aHJfZmlsZSB7IGlvY3RsIG9wZW4gcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBldGNf
dDpkaXIgeyBhZGRfbmFtZSBnZXRhdHRyIG9wZW4gcmVhZCByZW1vdmVfbmFtZSBzZWFyY2ggd3Jp
dGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgZXRjX3Q6ZmlsZSB7IGFwcGVuZCBjcmVhdGUgZ2V0YXR0
ciBpb2N0bCBsaW5rIG9wZW4gcmVhZCByZW5hbWUgc2V0YXR0ciB1bmxpbmsgd3JpdGUgfTsKYWxs
b3cgQ0RUbWxfdHlwZXMgZXRjX3Q6bG5rX2ZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB9OwphbGxv
dyBDRFRtbF90eXBlcyBmYWlsbG9nX3Q6ZmlsZSB7IGdldGF0dHIgb3BlbiByZWFkIHdyaXRlIH07
CmFsbG93IENEVG1sX3R5cGVzIGZzX3Q6ZmlsZXN5c3RlbSB7IGdldGF0dHIgYXNzb2NpYXRlIH07
CmFsbG93IENEVG1sX2ZpbGUgZnNfdDpmaWxlc3lzdGVtIHsgYXNzb2NpYXRlIH07CmFsbG93IENE
VG1sX3R5cGVzIGhvbWVfcm9vdF90OmRpciB7IGFkZF9uYW1lIGdldGF0dHIgd3JpdGUgfTsKYWxs
b3cgQ0RUbWxfdHlwZXMgaG9zdG5hbWVfZXRjX3Q6ZmlsZSB7IGFwcGVuZCBnZXRhdHRyIGlvY3Rs
IG9wZW4gcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBob3N0bmFtZV9leGVjX3Q6Zmls
ZSB7IGdldGF0dHIgZXhlY3V0ZSBleGVjdXRlX25vX3RyYW5zIGlvY3RsIG1hcCBvcGVuIHJlYWQg
fTsKYWxsb3cgQ0RUbWxfdHlwZXMgaW5pdHJjX2V4ZWNfdDpmaWxlIHsgZW50cnlwb2ludCBleGVj
dXRlIGdldGF0dHIgaW9jdGwgbWFwIG9wZW4gcmVhZCB9OwphbGxvdyBDRFRtbF90eXBlcyBpbml0
X3Q6cHJvY2VzcyBzaWdjaGxkOwphbGxvdyBDRFRtbF90eXBlcyBpbml0X3Q6c2VydmljZSB7IHN0
YXR1cyBzdG9wIHN0YXJ0IGVuYWJsZSBkaXNhYmxlIH07CmFsbG93IENEVG1sX3R5cGVzIGluaXRf
dDp1bml4X3N0cmVhbV9zb2NrZXQgeyBjb25uZWN0dG8gZ2V0YXR0ciBpb2N0bCByZWFkIHdyaXRl
IH07CmFsbG93IENEVG1sX3R5cGVzIGluaXRfdmFyX3J1bl90OmRpciB7IGFkZF9uYW1lIGNyZWF0
ZSB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBpbml0X3Zhcl9ydW5fdDpmaWZvX2ZpbGUgeyBj
cmVhdGUgb3BlbiByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIGluaXRfdmFyX3J1bl90OnNvY2tf
ZmlsZSB7IHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIGluaXRyY192YXJfcnVuX3Q6ZmlsZSB7
IGxvY2sgfTsKYWxsb3cgQ0RUbWxfdHlwZXMga2VybmVsX3Q6c3lzdGVtIG1vZHVsZV9yZXF1ZXN0
OwphbGxvdyBDRFRtbF90eXBlcyBrZXJuZWxfdDp1bml4X2RncmFtX3NvY2tldCBzZW5kdG87CmFs
bG93IENEVG1sX3R5cGVzIGtyYjVfY29uZl90OmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB9Owph
bGxvdyBDRFRtbF90eXBlcyBsYXN0bG9nX3Q6ZmlsZSB7IGFwcGVuZCBnZXRhdHRyIGlvY3RsIGxv
Y2sgb3BlbiByZWFkIHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIGxkX3NvX2NhY2hlX3Q6Zmls
ZSB7IGdldGF0dHIgbWFwIG9wZW4gcmVhZCB9OwphbGxvdyBDRFRtbF90eXBlcyBsZF9zb190OmZp
bGUgeyBleGVjdXRlIG1hcCBvcGVuIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgbGliX3Q6ZGly
IHsgZ2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIH07CmFsbG93IENEVG1sX3R5cGVzIGxpYl90OmZp
bGUgeyBleGVjdXRlIGlvY3RsIGdldGF0dHIgbWFwIG9wZW4gcmVhZCB9OwphbGxvdyBDRFRtbF90
eXBlcyBsaWJfdDpsbmtfZmlsZSByZWFkOwphbGxvdyBDRFRtbF90eXBlcyBsb2NhbGVfdDpkaXIg
c2VhcmNoOwphbGxvdyBDRFRtbF90eXBlcyBsb2NhbGVfdDpmaWxlIHsgZ2V0YXR0ciBtYXAgb3Bl
biByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIGxvY2FsZV90Omxua19maWxlIHJlYWQ7CmFsbG93
IENEVG1sX3R5cGVzIGxvY2FsX2xvZ2luX3Q6ZmQgdXNlOwphbGxvdyBDRFRtbF90eXBlcyBsb2Nh
bF9sb2dpbl90OnByb2Nlc3Mgc2lnY2hsZDsKYWxsb3cgQ0RUbWxfdHlwZXMgbWFpbF9zcG9vbF90
OmRpciB7IGFkZF9uYW1lIHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIG1haWxfc3Bvb2xfdDpm
aWxlIHsgY3JlYXRlIHNldGF0dHIgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgQ0RUbWxfY29u
ZjpmaWxlIHsgYXBwZW5kIGNyZWF0ZSBnZXRhdHRyIGlvY3RsIG9wZW4gcmVhZCByZW5hbWUgc2V0
YXR0ciB1bmxpbmsgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgbW96aWxsYV9ob21lX3Q6ZGly
IHsgYWRkX25hbWUgY3JlYXRlIHNldGF0dHIgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgbmV0
X2NvbmZfdDpkaXIgeyBhZGRfbmFtZSByZW1vdmVfbmFtZSB3cml0ZSB9OwphbGxvdyBDRFRtbF90
eXBlcyBuZXRfY29uZl90OmZpbGUgeyBhcHBlbmQgY3JlYXRlIGdldGF0dHIgb3BlbiByZWFkIHJl
bmFtZSBzZXRhdHRyIHVubGluayB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBub2RlX3Q6dWRw
X3NvY2tldCBub2RlX2JpbmQ7CmFsbG93IENEVG1sX3R5cGVzIG51bGxfZGV2aWNlX3Q6Y2hyX2Zp
bGUgeyBpb2N0bCByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIHBhc3N3ZF9maWxlX3Q6ZmlsZSB7
IGNyZWF0ZSBnZXRhdHRyIG1hcCBvcGVuIHJlYWQgcmVuYW1lIHNldGF0dHIgdW5saW5rIHdyaXRl
IH07CmFsbG93IENEVG1sX3R5cGVzIHByb2NfdDpkaXIgeyBnZXRhdHRyIG9wZW4gcmVhZCBzZWFy
Y2ggfTsKYWxsb3cgQ0RUbWxfdHlwZXMgcHJvY190OmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB9
OwphbGxvdyBDRFRtbF90eXBlcyBwcm9jX3Q6ZmlsZXN5c3RlbSBnZXRhdHRyOwphbGxvdyBDRFRt
bF90eXBlcyBwdG14X3Q6Y2hyX2ZpbGUgeyBpb2N0bCBvcGVuIHJlYWQgd3JpdGUgfTsKYWxsb3cg
Q0RUbWxfdHlwZXMgcm9vdF90OmRpciB7IGdldGF0dHIgc2VhcmNoIH07CmFsbG93IENEVG1sX3R5
cGVzIHNlY3VyaXR5X3Q6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIH07CmFsbG93IENE
VG1sX3R5cGVzIHNlY3VyaXR5X3Q6ZmlsZXN5c3RlbSBnZXRhdHRyOwphbGxvdyBDRFRtbF90eXBl
cyBzZWN1cml0eV90OmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRt
bF90eXBlcyBzZWN1cml0eV90OnNlY3VyaXR5IHsgY2hlY2tfY29udGV4dCBjb21wdXRlX2F2IH07
CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6Y2FwYWJpbGl0eSB7IGF1ZGl0X3dyaXRlIGNob3duIGRh
Y19vdmVycmlkZSBkYWNfcmVhZF9zZWFyY2ggZm93bmVyIGZzZXRpZCBuZXRfYWRtaW4gbmV0X3Jh
dyBzZXRnaWQgc2V0dWlkIHN5c19ib290IHN5c19wdHJhY2UgfTsKYWxsb3cgQ0RUbWxfdHlwZXMg
c2VsZjpmZCB1c2U7CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6Zmlmb19maWxlIHsgZ2V0YXR0ciBv
cGVuIHJlYWQgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2VsZjpmaWxlIHsgZ2V0YXR0ciBv
cGVuIHJlYWQgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2VsZjprZXkgeyByZWFkIHNlYXJj
aCB2aWV3IHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6bG5rX2ZpbGUgeyByZWFkIH07
CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6bmV0bGlua19hdWRpdF9zb2NrZXQgeyBjcmVhdGUgbmxt
c2dfcmVsYXkgcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBzZWxmOnBhc3N3ZCBwYXNz
d2Q7CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6cHJvY2VzcyB7IGV4ZWNtZW0gZm9yayBub2F0c2Vj
dXJlIHJsaW1pdGluaCBzZXRmc2NyZWF0ZSBzaWdjaGxkIHNpZ2luaCBzaWduYWwgdHJhbnNpdGlv
biB9OwphbGxvdyBDRFRtbF90eXBlcyBzZWxmOnJhd2lwX3NvY2tldCB7IGNyZWF0ZSBnZXRvcHQg
c2V0b3B0IH07CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6dGNwX3NvY2tldCB7IGNvbm5lY3QgY3Jl
YXRlIGdldGF0dHIgZ2V0b3B0IHJlYWQgc2V0b3B0IHNodXRkb3duIHdyaXRlIH07CmFsbG93IENE
VG1sX3R5cGVzIHNlbGY6dWRwX3NvY2tldCB7IGJpbmQgY29ubmVjdCBjcmVhdGUgZ2V0YXR0ciBp
b2N0bCByZWFkIHNldG9wdCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBzZWxmOnVuaXhfZGdy
YW1fc29ja2V0IHsgY29ubmVjdCBjcmVhdGUgd3JpdGUgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2Vs
Zjp1bml4X3N0cmVhbV9zb2NrZXQgeyBjb25uZWN0IGNyZWF0ZSBzaHV0ZG93biB9OwphbGxvdyBD
RFRtbF90eXBlcyBzZWxpbnV4X2NvbmZpZ190OmRpciBzZWFyY2g7CmFsbG93IENEVG1sX3R5cGVz
IHNoYWRvd190OmZpbGUgeyBjcmVhdGUgZ2V0YXR0ciBvcGVuIG1hcCByZWFkIHJlbmFtZSBzZXRh
dHRyIHVubGluayB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBzaGVsbF9leGVjX3Q6ZmlsZSB7
IGV4ZWN1dGUgbWFwIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc3NoX2V4ZWNfdDpmaWxlIHsg
ZXhlY3V0ZSBleGVjdXRlX25vX3RyYW5zIGdldGF0dHIgbWFwIG9wZW4gcmVhZCB9OwphbGxvdyBD
RFRtbF90eXBlcyBzc2hfaG9tZV90OmRpciB7IGFkZF9uYW1lIGNyZWF0ZSByZW1vdmVfbmFtZSBz
ZWFyY2ggc2V0YXR0ciB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBzc2hfaG9tZV90OmZpbGUg
eyBhcHBlbmQgY3JlYXRlIHNldGF0dHIgdW5saW5rIHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVz
IHNzaF9rZXlnZW5fZXhlY190OmZpbGUgeyBleGVjdXRlIGV4ZWN1dGVfbm9fdHJhbnMgZ2V0YXR0
ciBtYXAgb3BlbiByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIHNzaF9wb3J0X3Q6dGNwX3NvY2tl
dCB7IG5hbWVfY29ubmVjdCB9OwphbGxvdyBDRFRtbF90eXBlcyBzeXNjdGxfbmV0X3Q6ZmlsZSB3
cml0ZTsKYWxsb3cgQ0RUbWxfdHlwZXMgc3lzZnNfdDpkaXIgc2VhcmNoOwphbGxvdyBDRFRtbF90
eXBlcyBzeXNsb2dfY29uZl90OmZpbGUgeyB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBzeXN0
ZW1fZGJ1c2RfdmFyX3J1bl90OnNvY2tfZmlsZSB3cml0ZTsKYWxsb3cgQ0RUbWxfdHlwZXMgc3lz
dGVtZF9sb2dpbmRfdDpmZCB1c2U7CmFsbG93IENEVG1sX3R5cGVzIHN5c3RlbWRfbG9naW5kX3Q6
ZmlsZSB7IGdldGF0dHIgb3BlbiByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIHN5c3RlbWRfdW5p
dF9maWxlX3Q6c2VydmljZSB7IHN0YXJ0IHN0b3AgZW5hYmxlIGRpc2FibGUgc3RhdHVzIH07CmFs
bG93IENEVG1sX3R5cGVzIHRtcF90OmRpciB7IGFkZF9uYW1lIGNyZWF0ZSBnZXRhdHRyIG9wZW4g
cmVhZCByZW1vdmVfbmFtZSBybWRpciBzZWFyY2ggc2V0YXR0ciB3cml0ZSB9OwphbGxvdyBDRFRt
bF90eXBlcyB0bXBfdDpmaWxlIHsgYXBwZW5kIGNyZWF0ZSBnZXRhdHRyIGlvY3RsIG9wZW4gcmVh
ZCBzZXRhdHRyIHVubGluayB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyB0bXBfdDpzb2NrX2Zp
bGUgeyBjcmVhdGUgdW5saW5rIHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIHR1bmVkX3Q6ZGly
IHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdHVuZWRfdDpmaWxlIHsgZ2V0
YXR0ciBvcGVuIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdWRldl90OmRpciB7IGdldGF0dHIg
c2VhcmNoIH07CmFsbG93IENEVG1sX3R5cGVzIHVkZXZfdDpmaWxlIHsgZ2V0YXR0ciBvcGVuIHJl
YWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdW5jb25maW5lZF90OmRpciB7IGdldGF0dHIgc2VhcmNo
IH07CmFsbG93IENEVG1sX3R5cGVzIHVuY29uZmluZWRfdDpmaWZvX2ZpbGUgeyBnZXRhdHRyIGlv
Y3RsIG9wZW4gcmVhZCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyB1bmNvbmZpbmVkX3Q6Zmls
ZSB7IGdldGF0dHIgb3BlbiByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIHVuY29uZmluZWRfdDpr
ZXkgeyBsaW5rIHJlYWQgc2VhcmNoIHZpZXcgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdXNlcl9ob21l
X2Rpcl90OmRpciB7IGFkZF9uYW1lIGNyZWF0ZSBnZXRhdHRyIG9wZW4gcmVhZCByZW1vdmVfbmFt
ZSBzZWFyY2ggc2V0YXR0ciB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyB1c2VyX2hvbWVfZGly
X3Q6ZmlsZSB7IGFwcGVuZCBjcmVhdGUgZ2V0YXR0ciBpb2N0bCBvcGVuIHJlYWQgcmVuYW1lIHNl
dGF0dHIgdW5saW5rIHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIHVzZXJfaG9tZV90OmZpbGUg
eyBhcHBlbmQgY3JlYXRlIGdldGF0dHIgb3BlbiByZWFkIHJlbmFtZSBzZXRhdHRyIHVubGluayB3
cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyB1c2VyX3RtcF90OmZpbGUgd3JpdGU7CmFsbG93IENE
VG1sX3R5cGVzIHVzZXJfdHR5X2RldmljZV90OmNocl9maWxlIHsgZ2V0YXR0ciBpb2N0bCByZWFk
IHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIHVzcl90OmRpciB7IGdldGF0dHIgb3BlbiBzZWFy
Y2ggfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdXNyX3Q6ZmlsZSB7IGdldGF0dHIgaW9jdGwgb3BlbiBy
ZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIHZhcl9sb2dfdDpmaWxlIHsgZ2V0YXR0ciBpb2N0bCBs
b2NrIG1hcCBvcGVuIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdmFyX3J1bl90OmRpciBzZWFy
Y2g7CmFsbG93IENEVG1sX3R5cGVzIHZhcl9ydW5fdDpmaWxlIHsgbG9jayBvcGVuIHJlYWQgfTsK
YWxsb3cgQ0RUbWxfdHlwZXMgdmFyX3J1bl90Omxua19maWxlIHJlYWQ7CmFsbG93IENEVG1sX3R5
cGVzIHZhcl90OmRpciB7IGFkZF9uYW1lIGdldGF0dHIgc2VhcmNoIG9wZW4gd3JpdGUgfTsKYWxs
b3cgaW5pdHJjX3QgQ0RUbWxfdHlwZXM6ZGlyIHsgZ2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIH07
CmFsbG93IGluaXRyY190IENEVG1sX3R5cGVzOmZpbGUgeyBnZXRhdHRyIGlvY3RsIG1hcCBvcGVu
IHJlYWQgfTsKYWxsb3cgc3lzbG9nZF90IENEVG1sX3R5cGVzOmRpciBzZWFyY2g7CmFsbG93IHN5
c2xvZ2RfdCBDRFRtbF90eXBlczpmaWxlIHsgZ2V0YXR0ciBvcGVuIHJlYWQgfTsKYWxsb3cgc3lz
bG9nZF90IENEVG1sX3R5cGVzOmxua19maWxlIHJlYWQ7CgphbGxvdyBDRFRtbF90eXBlcyB7CiAg
ICBhYnJ0X3QKICAgIGFicnRfd2F0Y2hfbG9nX3QKICAgIGF1ZGl0ZF90CiAgICBjcm9uZF90CiAg
ICBkaGNwY190CiAgICBmaXJld2FsbGRfdAogICAgZnNkYWVtb25fdAogICAgZ2V0dHlfdAogICAg
aW5pdF90CiAgICBpbml0cmNfdmFyX3J1bl90CiAgICBrZXJuZWxfdAogICAgbG9jYWxfbG9naW5f
dAogICAgbHNtZF90CiAgICBsdm1fdAogICAgcG9saWN5a2l0X3QKICAgIHByb2NfdAogICAgcmhu
c2RfdAogICAgcmhzbWNlcnRkX3QKICAgIHJuZ2RfdAogICAgcnBjYmluZF90CiAgICB1c2VyX2hv
bWVfdAogICAgdmFyX2xvZ190CiAgICB4ZmVyQWRtaW5fdAogICAgeGZlckxpYl90Cn06ZGlyIHsg
Z2V0YXR0ciBvcGVuIHJlYWQgc2VhcmNoIH07CmFsbG93IENEVG1sX3R5cGVzIHsKICAgIGFicnRf
dAogICAgYWJydF93YXRjaF9sb2dfdAogICAgYXVkaXRkX3QKICAgIGNyb25kX3QKICAgIGRoY3Bj
X3QKICAgIGZpcmV3YWxsZF90CiAgICBmc2RhZW1vbl90CiAgICBnZXR0eV90CiAgICBpbml0X3QK
ICAgIGluaXRyY192YXJfcnVuX3QKICAgIGtlcm5lbF90CiAgICBsb2NhbF9sb2dpbl90CiAgICBs
c21kX3QKICAgIGx2bV90CiAgICBwb2xpY3lraXRfdAogICAgcmhuc2RfdAogICAgcmhzbWNlcnRk
X3QKICAgIHJuZ2RfdAogICAgcnBjYmluZF90Cn06ZmlsZSB7IG9wZW4gcmVhZCB9OwphbGxvdyBD
RFRtbF90eXBlcyB7CiAgICBwcm9jX3QKfTpsbmtfZmlsZSB7IGdldGF0dHIgb3BlbiByZWFkIH07
CmFsbG93IENEVG1sX3R5cGVzIHsKICAgIG51bGxfZGV2aWNlX3QKICAgIHVzZXJfZGV2cHRzX3QK
fTpjaHJfZmlsZSB7IGFwcGVuZCBnZXRhdHRyIGlvY3RsIG9wZW4gcmVhZCB3cml0ZSB9OwoKYWxs
b3cgQ0RUbWxfdHlwZXMgc2VjdXJpdHlfdDpmaWxlIHsgZ2V0YXR0ciBvcGVuIHJlYWQgfTsKYWxs
b3cgQ0RUbWxfdHlwZXMgc2VsZjprZXkgbGluazsKYWxsb3cgQ0RUbWxfdHlwZXMgc2VsZjpwcm9j
ZXNzIHsgc2V0cmxpbWl0IHNldHNjaGVkIHNpZ2tpbGwgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2Vs
Zjp1bml4X3N0cmVhbV9zb2NrZXQgeyBhY2NlcHQgYmluZCBsaXN0ZW4gfTsKYWxsb3cgQ0RUbWxf
dHlwZXMgc2V0cmFuc192YXJfcnVuX3Q6ZGlyIHNlYXJjaDsKYWxsb3cgQ0RUbWxfdHlwZXMgc2hl
bGxfZXhlY190OmZpbGUgeyBleGVjdXRlX25vX3RyYW5zIGdldGF0dHIgb3BlbiB9OwphbGxvdyBD
RFRtbF90eXBlcyBzc2hfYWdlbnRfZXhlY190OmZpbGUgeyBleGVjdXRlIGV4ZWN1dGVfbm9fdHJh
bnMgbWFwIG9wZW4gcmVhZCB9OwphbGxvdyBDRFRtbF90eXBlcyBzc2hfaG9tZV90OmRpciBnZXRh
dHRyOwphbGxvdyBDRFRtbF90eXBlcyBzc2hfaG9tZV90OmZpbGUgeyBnZXRhdHRyIG9wZW4gcmVh
ZCB9OwphbGxvdyBDRFRtbF90eXBlcyBzc2hkX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxs
b3cgQ0RUbWxfdHlwZXMgc3NoZF90OmZpbGUgeyBvcGVuIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlw
ZXMgc3VfZXhlY190OmZpbGUgeyBleGVjdXRlIGV4ZWN1dGVfbm9fdHJhbnMgZ2V0YXR0ciBtYXAg
b3BlbiByZWFkIH07CmFsbG93IENEVG1sX3R5cGVzIHN5c2N0bF9rZXJuZWxfdDpkaXIgc2VhcmNo
OwphbGxvdyBDRFRtbF90eXBlcyBzeXNjdGxfa2VybmVsX3Q6ZmlsZSB7IG9wZW4gcmVhZCB9Owph
bGxvdyBDRFRtbF90eXBlcyBzeXNsb2dkX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxsb3cg
Q0RUbWxfdHlwZXMgc3lzbG9nZF90OmZpbGUgeyBvcGVuIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlw
ZXMgc3lzdGVtX2RidXNkX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsKYWxsb3cgQ0RUbWxfdHlw
ZXMgc3lzdGVtX2RidXNkX3Q6ZmlsZSB7IG9wZW4gcmVhZCB9OwphbGxvdyBDRFRtbF90eXBlcyBz
eXN0ZW1kX2xvZ2luZF9zZXNzaW9uc190OmZpZm9fZmlsZSB3cml0ZTsKYWxsb3cgQ0RUbWxfdHlw
ZXMgc3lzdGVtZF9sb2dpbmRfdDpkYnVzIHNlbmRfbXNnOwphbGxvdyBDRFRtbF90eXBlcyBzeXN0
ZW1kX2xvZ2luZF90OmRpciB7IGdldGF0dHIgc2VhcmNoIH07CgoKCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMKIyBGb3IgY29ubmVj
dGluZyB0byBhbmQgdXNpbmcgZGJ1cywgaWYgbmVjZXNzYXJ5CmFsbG93IENEVG1sX3R5cGVzIHsg
c3lzdGVtX2RidXNkX3Qgc2VsZiB9OmRidXMgc2VuZF9tc2c7CmFsbG93IHsgc3lzdGVtX2RidXNk
X3QgZGJ1c2RfdW5jb25maW5lZCB9IENEVG1sX3R5cGVzOmRidXMgc2VuZF9tc2c7CmFsbG93IENE
VG1sX3R5cGVzIHN5c3RlbV9kYnVzZF92YXJfbGliX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggb3Bl
biB9OwphbGxvdyBDRFRtbF90eXBlcyBzeXN0ZW1fZGJ1c2RfdmFyX2xpYl90OmZpbGUgeyBvcGVu
IHsgZ2V0YXR0ciByZWFkIGlvY3RsIGxvY2sgfSB9OwphbGxvdyBDRFRtbF90eXBlcyB2YXJfbGli
X3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggb3BlbiB9OwphbGxvdyBDRFRtbF90eXBlcyBkZXZpY2Vf
dDpkaXIgeyBnZXRhdHRyIHNlYXJjaCBvcGVuIH07CmFsbG93IENEVG1sX3R5cGVzIHVyYW5kb21f
ZGV2aWNlX3Q6Y2hyX2ZpbGUgeyBnZXRhdHRyIG9wZW4gcmVhZCBpb2N0bCB9OwphbGxvdyBDRFRt
bF90eXBlcyB2YXJfdDpsbmtfZmlsZSB7IHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgdmFyX3J1
bl90Omxua19maWxlIHsgcmVhZCB9OwphbGxvdyBDRFRtbF90eXBlcyB2YXJfcnVuX3Q6ZGlyIHsg
YWRkX25hbWUgY3JlYXRlIGdldGF0dHIgb3BlbiByZWFkIHJlbGFiZWx0byByZW1vdmVfbmFtZSBz
ZWFyY2ggc2V0YXR0ciB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBzeXN0ZW1fZGJ1c2RfdmFy
X3J1bl90OmRpciB7IGdldGF0dHIgc2VhcmNoIG9wZW4gfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc3lz
dGVtX2RidXNkX3Zhcl9ydW5fdDpzb2NrX2ZpbGUgeyB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBl
cyBzeXN0ZW1fZGJ1c2RfdDp1bml4X3N0cmVhbV9zb2NrZXQgY29ubmVjdHRvOwphbGxvdyBDRFRt
bF90eXBlcyBkYnVzZF9ldGNfdDpkaXIgeyBnZXRhdHRyIHNlYXJjaCBvcGVuIHJlYWQgfTsKYWxs
b3cgQ0RUbWxfdHlwZXMgZGJ1c2RfZXRjX3Q6ZmlsZSB7IG9wZW4geyBnZXRhdHRyIHJlYWQgaW9j
dGwgbG9jayB9IH07CmFsbG93IENEVG1sX3R5cGVzIHVuY29uZmluZWRfc2VydmljZV90OmRidXMg
c2VuZF9tc2c7CmFsbG93IHVuY29uZmluZWRfc2VydmljZV90IENEVG1sX3R5cGVzOmRidXMgc2Vu
ZF9tc2c7CmFsbG93IENEVG1sX3R5cGVzIHNzaGRfdDpmZCB7IHVzZSB9OwphbGxvdyBDRFRtbF90
eXBlcyBpbml0X3RtcF90OmZpbGUgeyBhcHBlbmQgY3JlYXRlIGdldGF0dHIgaW9jdGwgb3BlbiBy
ZWFkIHdyaXRlIH07CmFsbG93IENEVG1sX3R5cGVzIHVuY29uZmluZWRfdDpmZCB7IHVzZSB9Owph
bGxvdyB1bmNvbmZpbmVkX3QgQ0RUbWxfdHlwZXM6cHJvY2VzcyB7IG5vYXRzZWN1cmUgcmxpbWl0
aW5oIHNpZ2luaCBzaWdraWxsIHNpZ25hbCBzaWdudWxsIH07CmFsbG93IENEVG1sX3R5cGVzIHVu
Y29uZmluZWRfdCA6cHJvY2VzcyB7IHNpZ2NobGQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2VsZjpk
aXIgeyBnZXRhdHRyIG9wZW4gcmVhZCBzZWFyY2ggfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2VsZjpm
aWxlIHsgZ2V0YXR0ciBpb2N0bCBvcGVuIHJlYWQgfTsKYWxsb3cgQ0RUbWxfdHlwZXMgc2VsZjpm
aWZvX2ZpbGUgeyBpb2N0bCB9OwphbGxvdyBDRFRtbF90eXBlcyBzZWxmOm5ldGxpbmtfcm91dGVf
c29ja2V0IHsgYmluZCBjcmVhdGUgZ2V0YXR0ciBubG1zZ19yZWFkIHJlYWQgc2V0b3B0IHdyaXRl
IH07CmFsbG93IENEVG1sX3R5cGVzIHNlbGY6bmV0bGlua19zZWxpbnV4X3NvY2tldCB7IGJpbmQg
Y3JlYXRlIGdldGF0dHIgbmxtc2dfcmVhZCByZWFkIHNldG9wdCB3cml0ZSB9OwphbGxvdyBDRFRt
bF90eXBlcyBzZWxmOnVuaXhfc3RyZWFtX3NvY2tldCB7IGNvbm5lY3R0byBnZXRhdHRyIGdldG9w
dCBpb2N0bCByZWFkIHNldG9wdCB3cml0ZSB9OwphbGxvdyBDRFRtbF90eXBlcyBpbml0X3Q6ZGJ1
cyBzZW5kX21zZzsKYWxsb3cgaW5pdF90IENEVG1sX3R5cGVzOmRidXMgc2VuZF9tc2c7CmFsbG93
IENEVG1sX3R5cGVzIHN5c3RlbV9kYnVzZF90OmRidXMgc2VuZF9tc2c7CmFsbG93IENEVG1sX3R5
cGVzIHN5c3RlbV9kYnVzZF90OnVuaXhfc3RyZWFtX3NvY2tldCBjb25uZWN0dG87CmFsbG93IGlu
aXRfdCBDRFRtbF90eXBlczpmaWxlIHsgZ2V0YXR0ciBpb2N0bCBvcGVuIHJlYWQgfTsKYWxsb3cg
aW5pdF90IENEVG1sX3R5cGVzOmRpciB7IGdldGF0dHIgb3BlbiByZWFkIHNlYXJjaCB9OwphbGxv
dyBzeXN0ZW1fZGJ1c2RfdCBDRFRtbF90eXBlczpmaWxlIHsgZ2V0YXR0ciBpb2N0bCBvcGVuIHJl
YWQgfTsKYWxsb3cgc3lzdGVtX2RidXNkX3QgQ0RUbWxfdHlwZXM6ZGlyIHsgZ2V0YXR0ciBvcGVu
IHJlYWQgc2VhcmNoIH07CmFsbG93IENEVG1sX3R5cGVzIGluaXRfdDpzeXN0ZW0geyByZWxvYWQg
c3RhdHVzIH07CmFsbG93IENEVG1sX3R5cGVzIHBvbGljeWtpdF90OmRidXMgc2VuZF9tc2c7CmFs
bG93IHBvbGljeWtpdF90IENEVG1sX3R5cGVzOmRidXMgc2VuZF9tc2c7CmFsbG93IENEVG1sX3R5
cGVzIHN5c3RlbWRfaG9zdG5hbWVkX3Q6ZGJ1cyBzZW5kX21zZzsKYWxsb3cgc3lzdGVtZF9ob3N0
bmFtZWRfdCBDRFRtbF90eXBlczpkYnVzIHNlbmRfbXNnOwphbGxvdyBzeXN0ZW1kX2xvZ2luZF90
IENEVG1sX3R5cGVzOmRidXMgc2VuZF9tc2c7Cgo=
--0000000000007d137305bb3d9192--
