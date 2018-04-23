MIME-Version: 1.0
In-Reply-To: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 23 Apr 2018 22:00:39 +0200
Message-ID: <CAJfZ7=nF6H1QA53FH8=gkaJJB2EBm5T5Aj4gqqRPAx8Zo0z-aQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: ANN: SELinux userspace 2.8-rc1 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 19, 2018 at 5:07 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> A 2.8-rc1 release candidate for the SELinux userspace is now available at:
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Please give it a test and let us know if there are any issues.
>
> If there are specific changes that you think should be called out in
> release notes for packagers and users in the final release announcement, let us know.
>
> Thanks to all the contributors to this release candidate!

Thanks for this release! I have built and installed Arch Linux
packages for it and have not experimented any noticeable issue.

Here are some notes which could be useful for packagers:

* Important notice: when overriding PREFIX, BINDIR, SBINDIR, SHLIBDIR,
LIBEXECDIR, etc., DESTDIR has to be removed from the definition. For
example on Arch Linux, I had to change SBINDIR="${pkgdir}/usr/bin" to
SBINDIR="/usr/bin".
* Defining variable LIBSEPOLA (to /usr/lib/libsepol.a, for example) is
no longer mandatory (thanks to the switch to "-l:libsepol.a" in
Makefiles).
* Still in Makfiles, PYSITEDIR has been renamed PYTHONLIBDIR (and its
definition changed).
* selinux-gui (ie. system-config-selinux GUI application) is now
compatible with Python 3. Doing this required migrating away from
PyGTK to the supported PyGI library. This means that selinux-gui now
depends on python-gobject, Gtk+ 3 and selinux-python. It no longer
requires PyGtk or Python 2.

By the way, for Arch Linux users who want to test the RC, I have
published the PKGBUILDs I have written on branch "selinux-2.8-rc" of
https://github.com/archlinuxhardened/selinux/commits/selinux-2.8-rc .

Cheers,
Nicolas
