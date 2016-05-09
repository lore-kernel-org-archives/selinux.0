Subject: Re: [PATCH 0/3] Update make clean instructions and .gitgnore files
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8e33696c-b3fe-09db-6d67-ee0ce6b0d82d@tycho.nsa.gov>
Date: Mon, 9 May 2016 08:20:46 -0400
MIME-Version: 1.0
In-Reply-To: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/05/2016 08:02 AM, Nicolas Iooss wrote:
> Hello,
> 
> While working on testing the selinux-userspace project on several
> configurations (compiler, compiler flags, libc, Python version...) it is
> quite convenient that "make clean" leaves the directory clean, both from
> a git prespective ("git ls-files --ignored --others --exclude-standard")
> and from a build point of view (all generated and cached files are
> removed).
> 
> These patches update the relevant .gitignore and Makefile files to
> achieve this.

Thanks, applied.

> 
> Cheers,
> Nicolas
> 
> Nicolas Iooss (3):
>   Update .gitignore files
>   sepolgen: remove additional files when cleaning
>   libsepol: remove libsepol.map when cleaning
> 
>  libselinux/utils/.gitignore        | 5 +++++
>  libsemanage/tests/.gitignore       | 1 +
>  libsepol/src/Makefile              | 2 +-
>  libsepol/tests/.gitignore          | 1 +
>  libsepol/tests/policies/.gitignore | 3 +++
>  sepolgen/src/sepolgen/Makefile     | 3 +--
>  sepolgen/tests/.gitignore          | 4 ++++
>  sepolgen/tests/Makefile            | 3 +++
>  8 files changed, 19 insertions(+), 3 deletions(-)
>  create mode 100644 libsemanage/tests/.gitignore
>  create mode 100644 libsepol/tests/.gitignore
>  create mode 100644 libsepol/tests/policies/.gitignore
>  create mode 100644 sepolgen/tests/.gitignore
> 
