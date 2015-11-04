Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA4KWXM9004819
 for <selinux@tycho.nsa.gov>; Wed, 4 Nov 2015 15:32:34 -0500
Received: by obbza9 with SMTP id za9so49456546obb.1
 for <selinux@tycho.nsa.gov>; Wed, 04 Nov 2015 12:32:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563A5AAB.5000802@tycho.nsa.gov>
References: <1451625304.2912505.1446655745278.JavaMail.zimbra@redhat.com>
 <563A5AAB.5000802@tycho.nsa.gov>
Date: Wed, 4 Nov 2015 15:32:24 -0500
Message-ID: <CAHC9VhTihxGX=7MPRxP+CQiOeXTqd7BGnhf+XJ10Fx4OwOiLZg@mail.gmail.com>
Subject: Re: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 4, 2015 at 2:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> selinux-testsuite exercises the individual kernel permission checks using
> its own privately defined test domains and types, so a failure indicates a
> kernel bug or a bug in the test policy or test code, not a bug in the
> distribution policy package.  It could be that a change in the distribution
> policy has a side effect (e.g. allowing some permission to all domains that
> we are trying to test such that we cannot trigger a failure, as in this
> case), but the testsuite tries to work around such cases by setting any
> necessary global booleans for the test duration and/or custom defining the
> test domain in such a way that it does not inherit anything from the
> distribution policy.
>
> The exec* checks can be disabled on certain architectures if they default to
> executable data but that would affect more than just execmod (and s390 does
> not default to executable data).
>
> Can you check that execmod permission is NOT granted to test_no_execmod_t:
> $ sesearch -AC -s test_no_execmod_t -p execmod
>
> Can you confirm that the test program is not marked with executable stack
> flag:
> $ execstack -q tests/mmap/mprotect_file_private_execmod
>
> Otherwise, I think you need some kernel instrumentation / tracing to see
> what is happening, particularly the selinux_file_mprotect() function.

I have been working with Jan on this and it appears that the issue is
due to the READ_IMPLIES_EXEC personality being set on the affected
s390x kernels.

-- 
paul moore
www.paul-moore.com
