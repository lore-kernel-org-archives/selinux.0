Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PLiKZA026571
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 17:44:20 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PLiFYg001088
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 21:44:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jim Meyering <jim@meyering.net>
Subject: Re: ls in Debian/Unstable
Date: Wed, 26 Mar 2008 08:22:22 +1100
Cc: 472590@bugs.debian.org, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200803251523.34329.russell@coker.com.au> <87tziu96yz.fsf@rho.meyering.net>
In-Reply-To: <87tziu96yz.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803260822.25123.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 March 2008 02:08, Jim Meyering <jim@meyering.net> wrote:
> Older versions of the POSIX spec for ls clearly require a "+" on
> any file with a SE Linux security context.
> But the latest allows it to be any non-space printable character.
> So eventually we'll make it more useful than a one-size-fits-all "+",
> but it must remain a non-' '.

Having it remain non-space long-term is OK.  But I think that we need to have 
Lenny released with a version of ls that doesn't display "+" on every file.  
That means that either the code to display some character other than "+" in 
the case of files with a SE Linux context needs to be written reasonably soon 
(and a final decision has to be made on which character it will be) or we 
need to release lenny with the same functionality as etch in this regard.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
