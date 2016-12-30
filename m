Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBUI7vJm020302
 for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2016 13:07:57 -0500
From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <stephen.smalley@gmail.com>
Reply-To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>, Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
Date: Sat, 31 Dec 2016 05:07:52 +1100
Message-ID: <2748246.FsU5sQayLg@russell.coker.com.au>
In-Reply-To: <CAB9W1A2bzpKEWEzpxqou=cWnvWkURxQVSjPDyVe3EBB0B8NA0w@mail.gmail.com>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
 <70625685.47kgmqZV44@russell.coker.com.au>
 <CAB9W1A2bzpKEWEzpxqou=cWnvWkURxQVSjPDyVe3EBB0B8NA0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, 30 December 2016 12:43:01 PM AEDT Stephen Smalley wrote:
> Fedora no longer runs mcstransd by default, so that may also be relevant.
> Dbusd should likely provide the raw context to clients so that they are
> free to use either the raw or translated interfaces without difficulty.

Good idea.  This is the last important issue for SE Linux in Debian which has 
to be solved in a week or 2 if we are going to make the release.  A worst-case 
scenario would be to just get mcstransd get kicked out of testing before the 
release.  I don't think it's getting used much anyway and I'm sure that the 
people who do use it think that being able to login is more important.  :-#

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
