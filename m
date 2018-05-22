Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4MFpvr5012856
 for <selinux@tycho.nsa.gov>; Tue, 22 May 2018 11:51:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id e6-v6so11123805plt.11
 for <selinux@tycho.nsa.gov>; Tue, 22 May 2018 08:39:43 -0700 (PDT)
Date: Tue, 22 May 2018 23:39:39 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180522153939.GA6986@baraddur.perfinion.com>
References: <20180521100346.48699-1-jason@perfinion.com>
 <CAJfZ7=n8RCbOXyLNwongX_Og2hEsogrpVFF=GWKv8B5z-DpYmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfZ7=n8RCbOXyLNwongX_Og2hEsogrpVFF=GWKv8B5z-DpYmw@mail.gmail.com>
Subject: Re: [PATCH] travis.yml: add ruby 2.5 to the test matrix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 21, 2018 at 10:42:15PM +0200, Nicolas Iooss wrote:
> On Mon, May 21, 2018 at 12:03 PM, Jason Zaman <jason@perfinion.com> wrote:
> >
> > Ruby 2.5 is not installed by default, force reinstall with rvm
> >
> > Signed-off-by: Jason Zaman <jason@perfinion.com>
> > ---
> >
> > This passes on my repo:
> > https://travis-ci.org/perfinion/selinux/builds/381597252
> 
> This passes on my repo too, both without any modifications compared to
> upstream and with some modifications to Makefiles (I enabled more
> warning flags in my repo, like clang -Weverything, but they trigger
> some false positive depending on the compiler version, which is why I
> do not upstream these modifications). For the record, clang did not
> like the "__error__" attribute used by some Ruby headers (cf.
> https://travis-ci.org/fishilico/selinux/builds/381760812) and this is
> not an issue related to the project.

Thats awesome! I was looking through your branch, you have a few things
marked as not upstreamable (like the flake8 py linter) and a few asserts
to silence the static analyzer.

I don't see why those couldnt be upstreamed. we have the scripts/ dir
with a couple things already, I would support putting more in there then
you wouldnt have to maintain it on your own and keep rebasing and
whatnot. And maybe the static analyzer isnt quite ready to upstream so
fast, but I dont see problems with the fixes. eg this kind of stuff
seems good:
https://github.com/fishilico/selinux/commit/46b056fdbc90fcf8a22c77bc17b4a4ee77ee28eb

> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Cool, i'll push it tmrr then :)

-- Jason
