MIME-Version: 1.0
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 14 Feb 2018 20:19:44 +0100
Message-ID: <CAJfZ7=kT4VRgWzoQMyehL=a4qGNGGcNPqiUcw6523zVH9R+JHA@mail.gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Rework of makefiles v5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 14, 2018 at 10:57 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> I have updated the patchset.
>
> The biggest change is that $(DESTDIR) is now used in the
> install stage only.
>
> Also some overidden CFLAGS/LDFLAGS has been removed since we now have
> explicit build rules.
>
> I have moved the changelog into patches.
>
> Please test to compile with:
> make DESTDIR=/tmp/myroot PREFIX=/myusr install
> or
> make DESTDIR=/tmp/myroot install
>
> Thanks for all feedback.
>
> Best regards
> Marcus Folkesson
>

Hi,
Thanks for this update! Here are three comments on this patchset:

* you forgot a $(DESTDIR) occurrence in patch 7.
* .travis.yml needs a simple patch to fix the value of PYSITEDIR. I
will send it later.
* While reading the Makefile after patch 15, I have been surprised by
"LIBDIR ?= $(DESTDIR)$(PREFIX)/lib", with DESTDIR. As this variable is
not exported, it works fine as it is, but it might be cleaner to
define it as "LIBDIR ?= $(PREFIX)/lib" and to use $(DESTDIR) in the
following lines. This point may be addressed in a follow-up commit
after the patchset has been merged.

As the patchset looks almost ready to be merged, I have created
https://github.com/SELinuxProject/selinux/pull/79 with a modified
patch 7 and my patch for .travis.yml. This pull request holds the
commits I plan to apply in a few days if no other maintainer disagrees
with this.

Best,
Nicolas
