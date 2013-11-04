Message-ID: <52779C9A.4050306@tycho.nsa.gov>
Date: Mon, 04 Nov 2013 08:09:46 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 1/2] Explicitly link libselinux against -lpthread
References: <1383434030-5853-1-git-send-email-bigon@debian.org>
In-Reply-To: <1383434030-5853-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/02/2013 07:13 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> libselinux is using pthread functions internally without explicitly
> linking against it.
> 
> If the executable is itself not linked against libpthread, this could
> lead to some weird ld.so assertions, see:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=728529

This seems to effectively revert a portion of:
commit c32da69e016061c1a06ec08298aae8c995fbea31
Author: Dan Walsh <dwalsh@redhat.com>
Date:   Wed Oct 9 16:27:43 2013 -0400

    Fixes for procattr calls to handle cache properly.

    We were asked not to link to libpthread but to use gcc internals.
    We were not handling properly the fact that a cache was UNSET, and this
    patch fixes this.

Can the two of you work out a proper fix that works for you both?

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 02dd829..2a79b27 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -114,7 +114,7 @@ $(LIBA): $(OBJS)
>  	$(RANLIB) $@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> +	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -lpthread -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
>  	ln -sf $@ $(TARGET) 
>  
>  $(LIBPC): $(LIBPC).in ../VERSION
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
