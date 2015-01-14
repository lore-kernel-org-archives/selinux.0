Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0EEQL4S021454
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 09:26:21 -0500
Received: by mail-wg0-f44.google.com with SMTP id y19so9204257wgg.3
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 06:26:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150114110334.GA24984@suse.de>
References: <20150114110334.GA24984@suse.de>
Date: Wed, 14 Jan 2015 09:26:17 -0500
Message-ID: <CAB9W1A1bN6aBJi9-6RT+23BoH5dmppTv6WSUWtgVrJ21KOAqDg@mail.gmail.com>
Subject: Re: ebitmap: map size does not match my size on s390x
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Johannes Segitz <jsegitz@suse.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There have been a couple of endianness fixes for
/sys/fs/selinux/policy, e.g. see:
9085a6422 and b138004

On Wed, Jan 14, 2015 at 6:03 AM, Johannes Segitz <jsegitz@suse.com> wrote:
> Hello,
>
> running sepolgen-ifgen fails on s390x. It fails because calling
> # sepolgen-ifgen-attr-helper /sys/fs/selinux/policy /tmp/tmpsSrJj3
> gives:
> libsepol.policydb_index_others: security:  7 users, 47 roles, 3156 types, 201 bools
> libsepol.policydb_index_others: security: 1 sens, 1024 cats
> libsepol.policydb_index_others: security:  83 classes, 59401 rules, 9799 cond rules
> security: ebitmap: map size 1400 does not match my size 64 (high bit was 1545)
> error(s) encountered while parsing configuration
>
> I use version 2.3 of the userspace tools on SLE 12 with kernel 3.12.28. The
> policy is based on Fedoras policy with some extension for SUSE
> (f85b52d1c6805e9b0a8bd2a4a4332e66e4b52c00 for the base policy and
> 627644e1bb9c6f851c2466ab6e0eec7607f472cd for contrib). This combination
> works fine on other architectures, only s390x shows this behavior. I did
> not work on s390x before so I don't know if this ever worked.
>
> The message comes from libsepol/src/ebitmap.c:361. Could this be a
> endianness issue?
>
> Best regards
> Johannes
> --
> Johannes Segitz                                        SUSE Security Team
> GPG Key E7C81FA0       EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
> SUSE LINUX GmbH        Maxfeldstraße 5            90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG Nürnberg)
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
