Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KEt5rT018090
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 10:55:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KEs3oq029822
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 14:54:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [RFC] Upstream policy handling
Date: Tue, 21 Sep 2004 00:54:48 +1000
Cc: Joshua Brindle <method@gentoo.org>, selinux <selinux@tycho.nsa.gov>,
   "pebe @lkcl.net>> Chris PeBenito" <pebenito@gentoo.org>
References: <414DA0A7.1000708@gentoo.org> <200409200729.50087.russell@coker.com.au> <20040920122548.GM23901@lkcl.net>
In-Reply-To: <20040920122548.GM23901@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409210054.48578.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Sep 2004 22:25, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Mon, Sep 20, 2004 at 07:29:50AM +1000, Russell Coker wrote:
> > The Debian goals are closer to Gentoo goals than that of Fedora.  For
> > example there is no targeted policy in Debian.
>
>  *lol* - there _is_ no policy for debian - no group has taken clear
>  responsibility for it "official" like and said "this is it, this is
>  what debian can run with" and i don't believe that is likely to
>  happen.

In Debian each package is owned by a person and that person has virtually 
total control over it.  I own the selinux-policy-default package in Debian, 
so therefore the official default for Debian is strict policy because I say 
so.

Another Debian developer may package the targeted policy, if so then Debian 
will have two policies to choose from, but the strict policy will remain the 
default.

Fedora has targeted policy as the default.  Different aims, different 
user-base, and a different default.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
