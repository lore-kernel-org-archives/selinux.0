Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Thu, 15 Sep 2011 03:41:10 +0200
In-Reply-To: <1316026239-27148-2-git-send-email-eparis@redhat.com>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316050871.23290.8.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric.

On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> At the moment we create a symlink:
> 
> /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> 
> This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> ../../.  Instead create a symlink from

See the patch that I posted earlier on. The same is also true for the
libsepol library and libsemanage does it differently but might need to
be patched too if you really want to create the link in LIBDIR instead
of in SHLIBDIR.

To be a 100% safe, the link could be created in both LIBDIR and
SHLIBDIR.

However my explanation is as follows. SHLIBDIR stands for "shared
libraries directory" while LIBDIR stands for "libraries directory".
Therefore the *versioned* executable library should go in SHLIBDIR and a
symbolic link should be created in SHLIBDIR from the *versioned*
executable library to the *unversioned* generic shared library name.
This is an aid for LD. In any case, ldconfig is going to create a link
if SHLIBDIR is in its search path. However if a link is not there,
ldconfig might create a different link for it always links to the most
recent versioned library executable.

> $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> 
> Thus it works no matter what values one might use for LIBDIR and
> SHLIBDIR.

My advice is to always create the link and install the executable in
SHLIBDIR and forget LIBDIR for the shared libraries.

Please do not forget to drop the above bits from my patch (if you are
going to do it differently). And please, even more important, do not
forget about looking at libsepol and libsemanage too.

Thanks.

> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  libselinux/src/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 78874be..bccc777 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -126,7 +126,7 @@ install: all
>  	install -m 755 $(LIBSO) $(SHLIBDIR)
>  	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
>  	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> -	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> +	ln -sf $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
>  
>  install-pywrap: pywrap
>  	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
