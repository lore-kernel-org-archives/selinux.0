Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j317u5Do010086
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 02:56:05 -0500 (EST)
Received: from nox.lemuria.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j317pwhV021500
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2005 07:51:58 GMT
Date: Fri, 1 Apr 2005 09:54:27 +0200
From: Tom <tom@lemuria.org>
To: Rogelio Serrano <rogelio.serrano@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050401095427.A1942@lemuria.org>
References: <20050331160546.36303.qmail@web31615.mail.mud.yahoo.com> <1112285287.11216.114.camel@moss-spartans.epoch.ncsc.mil> <20050331231259.B2607@lemuria.org> <1112303152.11216.199.camel@moss-spartans.epoch.ncsc.mil> <a9951d2a050331212851af92d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9951d2a050331212851af92d4@mail.gmail.com>; from rogelio.serrano@gmail.com on Fri, Apr 01, 2005 at 01:28:29PM +0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 01, 2005 at 01:28:29PM +0800, Rogelio Serrano wrote:
> > > He does have a point, though - sometimes the application can not be
> > > changed. It may be a legacy application and for all I care, those are
> > > the ones most in need of a protective cage.
> 
> Unchangeable legacy apps should die.

Just like hunger and war, yes. The fact remains that they exist, and
you and I have to work with (and/or around) them.

Now, you _can_ do binary patching or even runtime binary patching, you
can overload system calls, you can do all sorts of dirty tricks to
change the behaviour of an "unchangeable" app. In most cases that's
non-trivial and it'll certainly mean you lose customer support.

SELinux is an excellent way to deal with these abominations and beat a
little sense into them. Were you on the list 2 years ago or so, when I
wrote policies for commercial Linux games? The audit log is an
interesting read, you wouldn't _believe_ what they try to access for no
obvious reason.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
