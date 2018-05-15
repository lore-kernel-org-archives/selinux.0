To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20180515082524.30252-1-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cfae1463-aa5e-a1d3-68a5-800ff154ee0b@tycho.nsa.gov>
Date: Tue, 15 May 2018 09:11:40 -0400
MIME-Version: 1.0
In-Reply-To: <20180515082524.30252-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 0/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2018 04:25 AM, Richard Haines via Selinux wrote:
> Not sure how useful this is but saw [1] and thought I'll have a go out
> of idle curiosity.

I haven't looked at the code yet but I'm in favor of adding it - this should
help prevent regressions in the binder SELinux checks in upstream kernels.

> 
> I've only tested on Fedora 27 with kernel-4.16.3-200.fc27.x86_64
> 
> Use ./test -v to see the flow of binder info
> 
> I just added the following to the standard kernel-x86_64.config:
> CONFIG_ANDROID_BINDER_DEVICES="binder"
> CONFIG_ANDROID_BINDER_IPC=y
> # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> 
> [1] https://github.com/SELinuxProject/selinux-testsuite/issues/27
> 
> Richard Haines (1):
>   selinux-testsuite: Add binder tests
> 
>  README.md                   |   8 +
>  defconfig                   |   8 +
>  policy/Makefile             |   2 +-
>  policy/test_binder.te       |  83 +++++++
>  tests/Makefile              |   2 +-
>  tests/binder/Makefile       |   7 +
>  tests/binder/check_binder.c |  80 +++++++
>  tests/binder/test           | 131 +++++++++++
>  tests/binder/test_binder.c  | 543 ++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 862 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_binder.te
>  create mode 100644 tests/binder/Makefile
>  create mode 100644 tests/binder/check_binder.c
>  create mode 100644 tests/binder/test
>  create mode 100644 tests/binder/test_binder.c
> 
