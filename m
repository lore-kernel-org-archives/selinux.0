Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4OEhI8f000738
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 10:43:18 -0400
Received: by mail-lf0-f54.google.com with SMTP id a5so55324938lfh.2
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 07:43:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
References: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 May 2017 10:43:02 -0400
Message-ID: <CAHC9VhQTMbJYy-6zxeTvYmLKfCHSnSEjaJLfMyUd+TaJ=-y=5Q@mail.gmail.com>
Subject: Re: Fedora COPR repositories with builds of latest code
To: Petr Lautrbach <plautrba@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
 Selinux on Fedora discussion <selinux@lists.fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 24, 2017 at 10:22 AM, Petr Lautrbach <plautrba@redhat.com> wrote:
> For the motivation see
> https://marc.info/?l=selinux&m=149435307518336&w=2
>
> I've restarted building of Fedora packages based on latest SELinux userspace
> code in Fedora COPR. Packages are built using the
> https://gitlab.com/bachradsusi/selinux-rpm project.
>
> There is a new selinux.spec [1] file which allows to build all Fedora
> packages from one src.rpm and Makefile which makes the process simple.
>
> Currently there are two COPR projects:
>
> * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
>
> This is built with Python3 support based on Fedora patches which are rebased
> against latest upstream code.

Thanks Petr!

FWIW, I've been using the plautrba/selinux-fedora COPR on my test
system for the past ~week and it has been working well.

-- 
paul moore
www.paul-moore.com
