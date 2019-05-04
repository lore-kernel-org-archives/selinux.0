Return-Path: <SRS0=AqYs=TE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB64C43219
	for <selinux@archiver.kernel.org>; Sat,  4 May 2019 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9765A206DF
	for <selinux@archiver.kernel.org>; Sat,  4 May 2019 18:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfEDSA6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 May 2019 14:00:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37435 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDSA6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 May 2019 14:00:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id u3so2656553otq.4
        for <selinux@vger.kernel.org>; Sat, 04 May 2019 11:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQjmtZ6moqyJ4CKl6ycYsKS5lHL9oNObJcwgv3V0UZE=;
        b=GrYpMRiZlsPgFSt2Dr3dsxkgLGwdD5DKQ7k46/VzaYKDlmUcrNCxUad6LUGHfS2cwS
         +X3Q4NL/tiApf+V2nXvfkS8w3S6QIfZ2Znvx1yCfJ07zTYo34QwPJDd2/WKhLhlKzz50
         e0LgJk9VzQQrkMG8IOeY9+egx7YQcHgiEK3qHIx6rOQ9tuBmvLLjA2OXV92ZxjXl4OtR
         J2XrnMRBrOFgYeHJhiIdYNYBIYyzvXYUYIZxUeosBIIekEgZoQgb6lBdQk+VsRKzfbSF
         EXkRNjLFaNmYGeMzbjJeF2sGcIp/s2iF3pOMWF42vVT2H24ekqQ5rJuI/jf9pj2yqMho
         vrSw==
X-Gm-Message-State: APjAAAUtffayBrOShhybCodHGIjLURYFC5B3lj6Asdb7Ej+82pxI3AjP
        37s2HYGc7LVeVkqvEopGO5T4JjTRWQnIk/KAy38VtVXpzRM=
X-Google-Smtp-Source: APXvYqy0R4zx72fWRiiJ74zHfxiuFUrMXa+bc3+0cRfiIKZvgpXBbMKXlsY8afZLw1muACuE6NUBop+QyrqBHPl4ioE=
X-Received: by 2002:a9d:350:: with SMTP id 74mr2589975otv.86.1556992857965;
 Sat, 04 May 2019 11:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190504034155.GA888@starlab.io>
In-Reply-To: <20190504034155.GA888@starlab.io>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 4 May 2019 20:00:50 +0200
Message-ID: <CAFqZXNt0abLcRxbOVdvybZ4fntN95zZyce4XK0z0tLftW19Tmw@mail.gmail.com>
Subject: Re: Possible regression test failure?
To:     Dan Noland <dan@starlab.io>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dan,

On Sat, May 4, 2019 at 5:42 AM Dan Noland <dan@starlab.io> wrote:
> - Hello -
>
> I am running a CentOS (7.6.1810 Core) base system with a 4.19.0-x
> kernel. I have a fresh clone of the selinux-testsuite from
> github. Before invoking "make -C policy load" I am running only the
> targeted policy in the enforcing mode. I am consistently seeing a
> single failure in the mmap regression tests:
>
> not ok 27
> # Failed test 27 in ./mmap/test at line 143
> #  ./mmap/test line 143 is:     ok($result);
>
> Other than this one failure things seem to be OK according to the test
> summary:
>
> Test Summary Report
> -------------------
> mmap/test                 (Wstat: 0 Tests: 47 Failed: 1)
>   Failed test:  27
>   Files=51, Tests=520, 35 wallclock secs ( 0.11 usr  0.03 sys +  0.82
>   cusr  0.85 \
>   csys =  1.81 CPU)
>   Result: FAIL
>   Failed 1/51 test programs. 1/520 subtests failed.
>
> The test in question is:
>
> /bin/runcon -t test_no_map_t -- $basedir/mmap_file_shared $basedir/temp_file
>
> Investigation indicates that the failure is caused by a bad (EACCES) open()
> at mmap_file_shared.c:38
>
> The AVC in the audit log shows that the { search } permission was
> missing.
>
> type=AVC msg=audit(1556938308.571:936): avc:  denied  { search } for
> pid=7517 comm="mmap_file_share" name="vagrant" dev="dm-0" ino=81922
> scontext=unconfined_u:unconfined_r:test_no_map_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_dir_t:s0 tclass=dir
> permissive=0
> type=SYSCALL msg=audit(1556938308.571:936): arch=c000003e syscall=2
> success=no exit=-13 a0=7ffcc17da74a a1=2 a2=8 a3=7ffcc17d8d20 items=0
> ppid=7512 pid=7517 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
> sgid=0 fsgid=0 tty=pts1 ses=4 comm="mmap_file_share"
> exe="/home/vagrant/selinux-testsuite/tests/mmap/mmap_file_shared"
> subj=unconfined_u:unconfined_r:test_no_map_t:s0-s0:c0.c1023 key=(null)
> type=PROCTITLE msg=audit(1556938308.571:936):
> proctitle=2F686F6D652F76616772616E742F73656C696E75782D7465737473756974652F74657374732F6D6D61702F6D6D61705F66696C655F736861726564002F686F6D652F76616772616E742F73656C696E75782D7465737473756974652F74657374732F6D6D61702F74656D705F66696C65
>
> My understanding of the intent of this regression test is limited,
> but I don't think this is an intended negative result.
>
> Any wisdom on how I should understand and address this failure would
> be gratefully received.

RHEL (and likely also CentOS) 7.6 has the domain_can_mmap_files
SELinux boolean set to "on" by default [1], which basically means that
map permissions are not checked, which logically leads to the failure
of the test that checks that map permission is denied when it was not
allowed by the test policy. When running the testsuite on CentOS/RHEL
7.6, you need to turn off the domain_can_mmap_files boolean during
test execution:

# setsebool domain_can_mmap_files off
(run the testsuite)
# setsebool domain_can_mmap_files on

[1] https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html-single/7.6_release_notes/index#BZ1460322

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
