Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u96DVjdU010961
 for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2016 09:31:45 -0400
Received: by mail-it0-f52.google.com with SMTP id o19so29493301ito.1
 for <selinux@tycho.nsa.gov>; Thu, 06 Oct 2016 06:31:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1722968607.809359.1475757444568.JavaMail.zimbra@redhat.com>
References: <587794099.804698.1475756176552.JavaMail.zimbra@redhat.com>
 <1722968607.809359.1475757444568.JavaMail.zimbra@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 6 Oct 2016 09:31:37 -0400
Message-ID: <CAFftDdq9rBtu34V9VrQAk8gzVZdaUZbML_cTCMa91BAKrJJ5kw@mail.gmail.com>
Subject: Re: Fuzzing /usr/libexec/selinux/hll/pp with AFL
To: Milos Malik <mmalik@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for fuzzing stuff, it helps with code robustness. However, in
my opinion, this is only the first step. I'm a firm believer if you
find it,
you should at least take a stab at fixing it. Analyzing these inputs
and understanding what broke and having a patch helps aid
in the correct fix. Perhaps your patch is the correct fix, or in some
cases, it helps point those more familiar with the code base
to the right spot.

So I would recommend attempting to fix these and send patches if you
want to see this fixed. This is my own two cents,
I am not a maintainer.

Bill


On Thu, Oct 6, 2016 at 8:37 AM, Milos Malik <mmalik@redhat.com> wrote:
> Hi all,
>
> inspired by Nicolas Iooss idea of fuzzing with AFL, I found few input files which cause a crash or a hang of hll/pp on RHEL-7.3. Hopefully, I discovered something else than what's already fixed in upstream.
>
> afl-2.35b
> libselinux-2.5-6.el7.x86_64
> libselinux-devel-2.5-6.el7.x86_64
> libselinux-python-2.5-6.el7.x86_64
> libselinux-utils-2.5-6.el7.x86_64
> libsemanage-2.5-4.el7.x86_64
> libsemanage-devel-2.5-4.el7.x86_64
> libsemanage-python-2.5-4.el7.x86_64
> libsemanage-static-2.5-4.el7.x86_64
> libsepol-2.5-6.el7.x86_64
> libsepol-devel-2.5-6.el7.x86_64
> libsepol-static-2.5-6.el7.x86_64
> policycoreutils-2.5-9.el7.x86_64
> policycoreutils-debuginfo-2.5-9.el7.x86_64
> policycoreutils-devel-2.5-9.el7.x86_64
> policycoreutils-gui-2.5-9.el7.x86_64
> policycoreutils-newrole-2.5-9.el7.x86_64
> policycoreutils-python-2.5-9.el7.x86_64
> policycoreutils-restorecond-2.5-9.el7.x86_64
> policycoreutils-sandbox-2.5-9.el7.x86_64
> selinux-policy-3.13.1-102.el7.noarch
> selinux-policy-devel-3.13.1-102.el7.noarch
> selinux-policy-minimum-3.13.1-102.el7.noarch
> selinux-policy-mls-3.13.1-102.el7.noarch
> selinux-policy-targeted-3.13.1-102.el7.noarch
>
> # /usr/libexec/selinux/hll/pp crash0
> Segmentation fault
> # /usr/libexec/selinux/hll/pp crash1
> Segmentation fault
> # dmesg
> [10487.300325] pp[24302]: segfault at 0 ip 00007f5dff4f8a4f sp 00007fffe41e5ba0 error 4 in libsepol.so.1[7f5dff4d0000+95000]
> [10489.509501] pp[24320]: segfault at 0 ip 00007f6067bec544 sp 00007fff17b0e5c0 error 4 in libsepol.so.1[7f6067bdb000+95000]
> #
>
> I also tested checkmodule and checkpolicy with AFL, but nothing sofar.
>
> Milos Malik
> SELinux QE person
> BaseOS QE Security team
> Red Hat Czech
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
