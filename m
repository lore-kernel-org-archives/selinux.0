Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8E3AxsT023580
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 23:11:19 -0400
Received: by mail-pg0-f42.google.com with SMTP id 188so4002522pgb.2
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 20:10:19 -0700 (PDT)
Received: from localhost ([2404:e800:e600:97:c0f5:aa0e:22e7:3dde])
 by smtp.gmail.com with ESMTPSA id 75sm14788383pfx.145.2017.09.13.20.10.17
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Sep 2017 20:10:18 -0700 (PDT)
Date: Thu, 14 Sep 2017 11:10:15 +0800
From: Jason Zaman <jason@perfinion.com>
To: SELinux <selinux@tycho.nsa.gov>
Message-ID: <20170914031015.GA27095@meriadoc.perfinion.com>
References: <a2755ee4-2a46-ff99-5653-c5f19a0efa55@ieee.org>
 <CAJfZ7==RrGdPStpM_YSLZOed0yOarjfjD_C_40G53Rs6R7O92Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfZ7==RrGdPStpM_YSLZOed0yOarjfjD_C_40G53Rs6R7O92Q@mail.gmail.com>
Subject: Re: Userspace Python version
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Sep 10, 2017 at 08:06:28PM +0200, Nicolas Iooss wrote:
> On Sat, Sep 9, 2017 at 1:18 AM, Chris PeBenito <pebenito@ieee.org> wrote:
> > I believe that all major SELinux distributions have at least Python 3.4
> > support.  Python 3 changeover has gone so long that even 3.3 is about to go
> > end-of-life [1].  Can we officially drop Python 2.7 support in userspace
> > code?
> >
> > I'd like to drop support for everything older than Python 3.4 in SETools.
> >
> > [1]
> > http://blog.python.org/2017/09/python-337rc1-is-now-available-prior-to.html
> 
> When I updated the Arch Linux packages for the last release, I tried
> to use Python 3 everywhere and there was one component which required
> Python 2: selinux-gui [1], because PyGtk is not compatible with Python
> 3. After a quick search I found https://askubuntu.com/a/97107 : "PyGTK
> has been deprecated in favor of PyGI+GTK. Because of that, a version
> of PyGTK for Python 3 was never written."
> 
> I will try to port selinux-gui to PyGI [2] in order to reduce the
> dependency towards Python 2. Before I start this work, are there
> already other people working on this? More precisely there have been
> some patches/commits related to this, like 9a57996dfa9a ("sandbox: Use
> GObject introspection binding instead of pygtk2") and 917f398d7cd2
> ("policycoreutils: Use GObject introspection binding instead of
> python-gobject in selinux_server.py") and I am wondering whether their
> authors also looked at selinux-gui (and command
> system-config-selinux).
> 
> Cheers,
> Nicolas
> 
> [1] directory gui/ of https://github.com/SELinuxProject/selinux
> [2] with ideas from
> https://wiki.gnome.org/action/show/Projects/PyGObject/IntrospectionPorting

This sounds about right. I know for sure all the commandline and
important selinux stuff all works with python3. I dont really use
selinux-gui. I didnt port it over when i did the big 2to3 patches since
I dont really know gtk. I think some of the redhat guys did some fixes
for it but not sure how comprehensive.

I have a mild preference for porting that to py3 before dropping it but
I havent heard any issues on the gentoo side about py3 support since the
last release so its probably fine.

Can the one that drops py2 be version 4.2? then if there do happen to be
any small bugfixes they can continue on 4.1.x?

-- Jason
