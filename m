Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5K4tagv031781
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 00:55:36 -0400
Received: by mail-pg0-f43.google.com with SMTP id 132so24204672pgb.2
 for <selinux@tycho.nsa.gov>; Mon, 19 Jun 2017 21:55:34 -0700 (PDT)
Date: Tue, 20 Jun 2017 12:55:29 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: ANN: SELinux userspace 2.7-rc2 release
Message-ID: <20170620045529.GB22554@meriadoc.perfinion.com>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1497632109.7898.5.camel@tycho.nsa.gov>
 <20170618073233.GA24080@meriadoc.perfinion.com>
 <1497891970.27645.5.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1497891970.27645.5.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 19, 2017 at 01:06:10PM -0400, Stephen Smalley wrote:
> On Sun, 2017-06-18 at 15:32 +0800, Jason Zaman wrote:
> > There is a bug that needs to be fixed before the final release:
> > https://bugs.gentoo.org/show_bug.cgi?id=621762
> > 
> > I think the fix is just add override in utils/Makefile to the LDLIBS
> > and
> > LDFLAGS bits. I'm not sure I'll have time to get around to testing
> > it so just wanted to let you know before the final release.
> 
> I wondering if we should actually revert
> fcb5d5cc721187b3e3a19b44155d5b824d7be7e6, at least wrt removal of -L/-
> I.  This seems to have broken usage of DESTDIR (except from top-level,
> via 9a7763e18604c4649ff67ea6d43a730f90311592, which doesn't help people
> using the individual tar balls.  And it seems like many package recipes
> are relying on make DESTDIR= to work as expected.

Thats the thing tho, DESTDIR is not supposed to affect compilation at
all. it should only affect where things are installed to. lots of other
things get confused if that changes. DESTDIR is for when rpm or portage
or whatever want to keep track of all the files installed by a package
before merging into the real / so it can uninstall them all. If you
want to do like a prefix install into /home/bin or whatever then i think
the variable is SYSROOT or something like that.

building should technically be done something like:
passing DESTDIR when you do the actual compilation bits isnt right.

# portage or rpm's building thing or whatever do this automatically
export CC CFLAGS LDLFAGS etc
make all
make DESTDIR="/wherever" install
cd /wherever/
tar cf libselinux.tar ./

https://www.gnu.org/prep/standards/html_node/DESTDIR.html
"DESTDIR should be supported only in the install* and uninstall*
targets, as those are the only targets where it is useful."

-- Jason
