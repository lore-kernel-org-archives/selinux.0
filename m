Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8AI6dUM020632
 for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2017 14:06:39 -0400
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 05CA456493F
 for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2017 20:06:29 +0200 (CEST)
Received: by mail-lf0-f47.google.com with SMTP id c80so13947232lfh.0
 for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2017 11:06:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a2755ee4-2a46-ff99-5653-c5f19a0efa55@ieee.org>
References: <a2755ee4-2a46-ff99-5653-c5f19a0efa55@ieee.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 10 Sep 2017 20:06:28 +0200
Message-ID: <CAJfZ7==RrGdPStpM_YSLZOed0yOarjfjD_C_40G53Rs6R7O92Q@mail.gmail.com>
To: Chris PeBenito <pebenito@ieee.org>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Userspace Python version
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Sep 9, 2017 at 1:18 AM, Chris PeBenito <pebenito@ieee.org> wrote:
> I believe that all major SELinux distributions have at least Python 3.4
> support.  Python 3 changeover has gone so long that even 3.3 is about to go
> end-of-life [1].  Can we officially drop Python 2.7 support in userspace
> code?
>
> I'd like to drop support for everything older than Python 3.4 in SETools.
>
> [1]
> http://blog.python.org/2017/09/python-337rc1-is-now-available-prior-to.html

When I updated the Arch Linux packages for the last release, I tried
to use Python 3 everywhere and there was one component which required
Python 2: selinux-gui [1], because PyGtk is not compatible with Python
3. After a quick search I found https://askubuntu.com/a/97107 : "PyGTK
has been deprecated in favor of PyGI+GTK. Because of that, a version
of PyGTK for Python 3 was never written."

I will try to port selinux-gui to PyGI [2] in order to reduce the
dependency towards Python 2. Before I start this work, are there
already other people working on this? More precisely there have been
some patches/commits related to this, like 9a57996dfa9a ("sandbox: Use
GObject introspection binding instead of pygtk2") and 917f398d7cd2
("policycoreutils: Use GObject introspection binding instead of
python-gobject in selinux_server.py") and I am wondering whether their
authors also looked at selinux-gui (and command
system-config-selinux).

Cheers,
Nicolas

[1] directory gui/ of https://github.com/SELinuxProject/selinux
[2] with ideas from
https://wiki.gnome.org/action/show/Projects/PyGObject/IntrospectionPorting
