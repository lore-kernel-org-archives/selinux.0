Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Guido Trentalancia <guido@trentalancia.com>, selinux@tycho.nsa.gov
In-Reply-To: <1316051175.2738.81.camel@localhost>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
	 <1316050871.23290.8.camel@vortex>  <1316051175.2738.81.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Sep 2011 08:41:38 -0400
Message-ID: <1316090498.16483.3.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 21:46 -0400, Eric Paris wrote:
> On Thu, 2011-09-15 at 03:41 +0200, Guido Trentalancia wrote:
> 
> > > $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> > > 
> > > Thus it works no matter what values one might use for LIBDIR and
> > > SHLIBDIR.
> > 
> > My advice is to always create the link and install the executable in
> > SHLIBDIR and forget LIBDIR for the shared libraries.
> 
> That is an interesting question, and maybe the right one.  Do we really
> need a link from /usr/lib64/libselinux.so -> /lib64/libselinux.so.1 ?
> 
> Would it not be fine to just have the link:
> /lib64/libselinux.so -> /lib64/libselinux.so.1 ?
> 
> I lean towards agreeing that Guido is right and dropping the link
> in /usr/lib64 altogether.  Any arguments against?

We didn't invent this paradigm; it just came from existing layout in
Fedora and is true of other libraries there as well.  See for
example /lib64/libz.so.N vs /usr/lib64/libz.so.  And note that the
symlink is owned by the -devel package rather than the base package, and
shouldn't be required for normal operation (and thus can live in /usr).
Of course nowadays they are proposing eliminating the distinction
between /foo and /usr/foo entirely (discussion at LPC).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
