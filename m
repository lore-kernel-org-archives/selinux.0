Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03225
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 11:10:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA12150
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 15:09:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id PAA12141
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 15:09:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "James Bishop" <james.bishop@jrc.it>
Subject: Re: Compiling for SuSE 7.2
Date: Fri, 5 Oct 2001 14:40:44 +0200
Cc: selinux@tycho.nsa.gov
References: <Pine.GSO.4.33.0110041101190.7555-100000@raven> <3BBD5F8C.6090309@jrc.it>
In-Reply-To: <3BBD5F8C.6090309@jrc.it>
MIME-Version: 1.0
Message-Id: <20011005150905.8ED4537DF6C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 5 Oct 2001 09:21, James Bishop wrote:
> I had that feeling that it was too easy...
>
> When I boot selinux (or SuSE linux) into runlevel 3 (no X), I get the
> login prompt, I enter username and password, and then answer the query
> about choosing a new context (in selinux only). After replying "no", I'm
> back at the login prompt again; not the shell prompt.
>
> So my modified login doesn't actually work - awareness dawns (somewhat
> slowly). I had assumed that the same login binary was used for all
> logins to the system, but apparently X, and / or Gnome, do things
> differently. Is this really so?

/bin/login is for console logins, telnetd, and I think rshd.  sshd doesn't 
use it (but there's a patch to sshd).  X logins use an X program, options 
include xdm, kdm, gdm, and many others.  I intend to develop a patch for kdm 
after getting everything else working (if no-one beats me to it).

Initially using startx after logging in on the console is easiest.

?dm programs for X login are complex, have lots of features, and generally 
have code that's been hacked on by 100 people and is not easy to modify.  :(

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
