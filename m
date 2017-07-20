Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6K0BUaX006127
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 20:11:30 -0400
Received: by mail-lf0-f49.google.com with SMTP id l200so6268157lfb.2
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 17:11:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719152651.15105-1-sds@tycho.nsa.gov>
References: <20170719152651.15105-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jul 2017 20:11:06 -0400
Message-ID: <CAHC9VhToZfJsdJACo1_DbeZxpM5cv9fbBBsp8za6dohw1JcXzw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux-testsuite: Add tests for AT_SECURE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 19, 2017 at 11:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Add tests for the AT_SECURE auxv flag to ensure that its value
> is set correctly based on whether noatsecure permission is allowed
> between the old domain and the new domain.
>
> Also test that the dynamic linker ignores LD_PRELOAD when AT_SECURE
> is set to 1.
>
> AT_SECURE has been supported since Linux 2.6.0, so these tests should
> work on all SELinux systems and do not need to be conditionally enabled.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policy/Makefile           |  2 +-
>  policy/test_atsecure.te   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/Makefile            |  3 ++-
>  tests/atsecure/Makefile   |  9 +++++++++
>  tests/atsecure/atsecure.c | 10 ++++++++++
>  tests/atsecure/evil.c     | 10 ++++++++++
>  tests/atsecure/good.c     | 10 ++++++++++
>  tests/atsecure/test       | 31 +++++++++++++++++++++++++++++++
>  8 files changed, 119 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_atsecure.te
>  create mode 100644 tests/atsecure/Makefile
>  create mode 100644 tests/atsecure/atsecure.c
>  create mode 100644 tests/atsecure/evil.c
>  create mode 100644 tests/atsecure/good.c
>  create mode 100755 tests/atsecure/test

Merged, thanks.

I wanted to get this in soon so we have something to use to verify the
changes in Kees' patchset.

-- 
paul moore
www.paul-moore.com
