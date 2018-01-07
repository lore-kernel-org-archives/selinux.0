Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w07Kn5CH014132
 for <selinux@tycho.nsa.gov>; Sun, 7 Jan 2018 15:49:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 3zF9Vl4HWzz34qsN
 for <selinux@tycho.nsa.gov>; Sun,  7 Jan 2018 20:49:03 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 3zF9Vl3YfZz34qsK
 for <selinux@tycho.nsa.gov>; Sun,  7 Jan 2018 20:49:03 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id o76so3683195lfi.10
 for <selinux@tycho.nsa.gov>; Sun, 07 Jan 2018 12:49:02 -0800 (PST)
Date: Sun, 7 Jan 2018 21:49:01 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180107204901.GA27200@gmail.com>
References: <20180103162955.22677-1-marcus.folkesson@gmail.com>
 <20180103211346.27213-1-marcus.folkesson@gmail.com>
 <CAJfZ7=kaGwRKBGD1os2ApK0cUBkEzhiQnE3s3RSWaHBU9Z1tFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfZ7=kaGwRKBGD1os2ApK0cUBkEzhiQnE3s3RSWaHBU9Z1tFg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: introduce PCPREFIX substitute
 variable for .pc files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

On Sun, Jan 07, 2018 at 09:38:58PM +0100, Nicolas Iooss wrote:
> On Wed, Jan 3, 2018 at 10:13 PM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > `prefix` in the .pc file may be messed up when using a buildsystem
> > that has specified a sysroot as DESTDIR.
> > We need to make it possible to override the default `libdir`
> > and `includedir`.
> >
> > `includedir` may be overridden by `INCLUDEDIR` but `libdir` is using
> > `PREFIX` to setup the path.
> >
> > Therefore, introduce PCPREFIX to make it possible to generate a more
> > customized .pc file.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> 
> Looks good to me. This patch does not seem to break the existing usage
> and adds more flexibility for packagers. By the way, I was worried by
> the modification on INCLUDEDIR, but as this variable is only used to
> generate pkg-config files, it is reasonable to use PCPREFIX instead of
> PREFIX in its definition.
> 
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>


Thank you for your review Nicolas.

I'm currently reworking the Makefiles again.
After more digging I have came to the conclusion that the main problem
is that the Makefiles does not follow the standard semantic of DESTDIR
and PREFIX.
I will try to fix this.

I suggest that we drop this patch and wait for my new patchsets.

Thank you

Best regards
Marcus Folkesson
