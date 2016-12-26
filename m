Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQKZg0i006700
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 15:35:42 -0500
Message-ID: <1482784532.3984.5.camel@trentalancia.net>
Subject: Re: [PATCH 2/2] libsemanage: fix optimized compile errors
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Mon, 26 Dec 2016 21:35:32 +0100
In-Reply-To: <CAJfZ7=ksisa9PoaUEZGVuzEiCqhnX3W051VUAmMD5gSU4LzEcw@mail.gmail.com>
References: <1482506214.10020.8.camel@trentalancia.net>
 <1482506386.10020.10.camel@trentalancia.net>
 <CAJfZ7=ksisa9PoaUEZGVuzEiCqhnX3W051VUAmMD5gSU4LzEcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello.

Because of the default compiler flag "-Werror", warnings are treated as
errors and therefore they break the compile process.

It's not a major issue, of course, but it's much better if it is fixed
so that it is not annoying people building with optimization.

I used gcc version 6.2.0. I don't know how other compilers or gcc
versions react to those compiler flags...

Because they have no side-effect, I simply recommend applying the
patches. That's all I can say.

I hope it helps.

On Mon, 26/12/2016 at 21.30 +0100, Nicolas Iooss wrote:
> On Fri, Dec 23, 2016 at 4:19 PM, Guido Trentalancia <guido@trentalanc
> ia.net> wrote:
> > Fix compile errors when using the "-O -Werror" flags on gcc6.
> > 
> > Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> > ---
> >  src/direct_api.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff -pru libsemanage-2.6-orig/src/direct_api.c libsemanage-
> > 2.6/src/direct_api.c
> > --- libsemanage-2.6-orig/src/direct_api.c       2016-10-14
> > 17:31:26.000000000 +0200
> > +++ libsemanage-2.6/src/direct_api.c    2016-12-23
> > 15:22:50.101297993 +0100
> > @@ -955,8 +955,8 @@ static int semanage_compile_module(seman
> >         ssize_t bzip_status;
> >         int status = 0;
> >         int compressed;
> > -       size_t cil_data_len;
> > -       size_t err_data_len;
> > +       size_t cil_data_len = 0;
> > +       size_t err_data_len = 0;
> > 
> >         if (!strcasecmp(modinfo->lang_ext, "cil")) {
> >                 goto cleanup;
> 
> Hello,
> From a package maintainer perspective (ie. someone who reads the git
> log in order to find patchs which need to be backported), it would be
> nice if the patch description would state whether this fixes a real
> error which went undetected in the previous releases, or whether this
> silents a false-positive warning from the compiler.
> In this case, gcc is having hard time to find out whether
> semanage_pipe_data() initializes *out_data_len and *err_data_len
> parameters when this function is called by semanage_compile_module().
> So it seems to be a false-positive. If you confirm this analysis and
> send a second revision, could you please add this information to the
> description?
> 
> Cheers,
> Nicolas

Regards,

Guido
