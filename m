Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VCRjgA001319
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 08:27:45 -0400 (EDT)
Received: from ppsw-0.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VCLUpZ000598
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 12:21:31 GMT
Date: Tue, 31 May 2005 13:29:31 +0100
From: Stephen Bennett <spb@gentoo.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: gentoo/hardened
Message-ID: <20050531132931.5c2bee94@localhost>
In-Reply-To: <20050531110542.GA4131@lkcl.net>
References: <20050530013136.GA28006@lkcl.net>
	<1117496766.1742.39.camel@chris.pebenito.net>
	<20050531005739.GH28006@lkcl.net>
	<1117512454.1742.101.camel@chris.pebenito.net>
	<20050531110542.GA4131@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 31 May 2005 12:05:42 +0100
Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  ... so am i allowed to ask you, after endeavouring to shoot
>  everybody down in flames: any chance you could make your
>  latest [experimental?] gentoo policy available?  i do need
>  to get a gentoo/hardenened workstation running, asap.

It's all in cvs --
http://www.gentoo.org/cgi-bin/viewcvs.cgi/selinux/?root=gentoo-projects
would probably be the place to start. If you don't like the viewcvs
interface, there does exist an anoncvs mirror of it that's Not For
Public Consumption (or was last thing I heard from the owner) -- mail me
off list if you want the address. I also have some patches (well, one
very big patch really) to import most of the changes from nsa cvs, done
mainly for my benefit -- the mips box really needs a 2.6.12-rc kernel,
and running that with a policy that has no concept of name_connect is
painful.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
