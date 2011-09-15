Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Eric Paris <eparis@redhat.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Wed, 14 Sep 2011 21:46:14 -0400
In-Reply-To: <1316050871.23290.8.camel@vortex>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
	 <1316050871.23290.8.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316051175.2738.81.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 03:41 +0200, Guido Trentalancia wrote:

> > $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> > 
> > Thus it works no matter what values one might use for LIBDIR and
> > SHLIBDIR.
> 
> My advice is to always create the link and install the executable in
> SHLIBDIR and forget LIBDIR for the shared libraries.

That is an interesting question, and maybe the right one.  Do we really
need a link from /usr/lib64/libselinux.so -> /lib64/libselinux.so.1 ?

Would it not be fine to just have the link:
/lib64/libselinux.so -> /lib64/libselinux.so.1 ?

I lean towards agreeing that Guido is right and dropping the link
in /usr/lib64 altogether.  Any arguments against?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
