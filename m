Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87CL3rT025632
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:21:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87CK8xo018722
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:20:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: debian-devel@lists.debian.org
Subject: Re: dpkg and selinux
Date: Tue, 7 Sep 2004 22:20:53 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Scott James Remnant <scott@netsplit.com>, SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>
References: <20040831234115.GZ4375@lkcl.net> <1094045403.6901.112.camel@descent.netsplit.com> <20040901172551.GC4400@lkcl.net>
In-Reply-To: <20040901172551.GC4400@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409072220.53751.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Sep 2004 03:25, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  russell _has_ been putting "X-Debian-Packages: xdm, kdm, gdm, wdm"
>  into the tops of e.g. the domains/programs/xdm.te policy file,
>  presumably so that in the future an automated decision can be made.

Colin Walters wrote such code, but I never got around to integrating it into 
the policy package.  I got too bogged down in writing policy and other SE 
Linux stuff.

> > Indeed, I'm leaning towards agreeing with you.  The postinst solution
> > has always smelled of rotten fish, it needs to be done properly --
> > either inside dpkg or inside the package postinsts.
>
>  inside dpkg it has to be then, because literally every postinst
>  would need to ask for its file contexts to be redone.

OK, same as has been done for rpm.

> > Vaguely, files are unpacked in a temporary place then moved into the
> > right place (inside process_archive).
>
>  okay, then that means that:
>
>  1b) the move needs to be handled carefully to ensure that the
>     selinux permissions are preserved

This is already catered for.  The only move which could lose the SE Linux 
context is one that crosses file systems.  This doesn't work for package 
installation anyway (imagine if /bin/bash or /usr/bin/perl was being replaced 
and half way through copying over the new file there was a power failure).

>  2) the linux kernel could be "prepped" by the functions in libselinux
>      such that the correct file contexts be applied at move time (i think!)

No kernel changes.

> > > > Such as
> > > > debconf-maintained configuration files, symlinks, etc.  How do those
> > > > get selinux policy?
> > >
> > >  to be honest, i don't rightly know.
> > >
> > >  _hopefully_ they are mentioned in the dpkg -L <packagename> listing
> > >  such that they can be managed.
> >
> > Nope.  Policy, in fact, demands that they aren't mentioned -- files
> > written during package maintainer scripts *cannot* be dpkg managed
> > conffiles.  (They get into a bit of a fight).

If the files are put into a directory that is specific to them then it's easy 
to sort out the context as Luke notes below.  Otherwise something like the 
following in a postinst script will work:
test -s /sbin/restorecon && /sbin/restorecon $CONFFILE

>  well, under most circumstances, i believe that can be catered for
>  (with /etc/init.d/xfs creating /tmp/.font-unix being a notable
>   exception).

test -s /sbin/restorecon && /sbin/restorecon /tmp/.font-unix

>  one particular way is that selinux has the equivalent of an
>  enhanced setgid for directories (known as file_auto_trans).
>
>  so, as long as a package has all its config files, temp files,
>  run files in its own directory (e.g. /etc/cups, /var/state/cups,
>  /var/run/cups) then it's possible to say, with a file_auto_trans
>  statement, "if the cups daemon creates a file in the directory
>  /var/spool/cups, then give it _these_ permissions".
>
>  it's typically the packages that disobey the Debian Policy
>  (or is it FHS policy) about creating per-package directories in
>  /etc, /var/run, /var/spool, /var/tmp that have the problems
>  (like /tmp/.font-unix)

I think that /var/run/.font-unix would be better anyway.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
