Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2H86STS030183
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 04:06:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 403FJx08gfz34qv4
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 08:06:25 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 403FJw6X5Xz34qSN
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 08:06:24 +0000 (UTC)
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 34233564837
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 09:06:16 +0100 (CET)
Received: by mail-oi0-f54.google.com with SMTP id x12so10490864oie.13
 for <selinux@tycho.nsa.gov>; Sat, 17 Mar 2018 01:06:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314193002.GA9676@workstation>
References: <20180311221527.7626-1-nicolas.iooss@m4x.org>
 <20180314193002.GA9676@workstation>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 17 Mar 2018 09:06:14 +0100
Message-ID: <CAJfZ7=kpD7h5TZxxqXj9da0t87F6zc0-tRe2cYJ1V0Dsnq8p1g@mail.gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 14, 2018 at 8:30 PM, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Sun, Mar 11, 2018 at 11:15:27PM +0100, Nicolas Iooss wrote:
> > libselinux and libsemanage Makefiles invoke site.getsitepackages() in
> > order to get the path to the directory /usr/lib/pythonX.Y/site-packages
> > that matches the Python interpreter chosen with $(PYTHON). This method
> > is incompatible with Python virtual environments, as described in
> > https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452 .
> > This issue has been opened for more than 5 years.
> >
> > On the contrary python/semanage/ and python/sepolgen/ Makefiles use
> > distutils.sysconfig.get_python_lib() in order to get the site-packages
> > path into a variable named PYTHONLIBDIR. This way of computing
> > PYTHONLIBDIR is compatible with virtual environments and gives the same
> > result as PYSITEDIR.
> >
> > As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselinux and
> > libsemanage Makefiles use it. And as native code is installed (as part
> > of the SWIG wrapper), use "plat_specific=1" in order to use /usr/lib64
> > on systems which distinguish /usr/lib64 from /usr/lib.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Looks good to me. Thanks!
>
> https://github.com/SELinuxProject/selinux/pull/86
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks. I have merged the patch.

Nicolas
