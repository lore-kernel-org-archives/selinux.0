Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.com
In-Reply-To: <1316026239-27148-2-git-send-email-eparis@redhat.com>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Sep 2011 15:18:01 -0400
Message-ID: <1316027881.26965.15.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> At the moment we create a symlink:
> 
> /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> 
> This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> ../../.  Instead create a symlink from
> 
> $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> 
> Thus it works no matter what values one might use for LIBDIR and
> SHLIBDIR.

I'm not sure this works the way you would want.  Consider rpm build of
libselinux - it does:
make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install

And then rpm collects up the files into the package.
But if the symlink encodes the full pathname used at make install time,
then it will be wrong on the final system when the rpm is installed.
Haven't actually tested that theory, but I think it is true.  Welcome to
hell.

> 
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
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
