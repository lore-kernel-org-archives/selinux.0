Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA10611
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 07:58:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA05569
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 12:56:16 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id MAA05565 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 12:56:16 GMT
Date: Mon, 28 Oct 2002 13:58:09 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021028135809.A4521@lemuria.org>
References: <20021028110158.A1294@lemuria.org> <200210281324.12898.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210281324.12898.russell@coker.com.au>; from russell@coker.com.au on Mon, Oct 28, 2002 at 01:24:12PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 28, 2002 at 01:24:12PM +0100, Russell Coker wrote:
> It's not that uncommon for an init script to read the config file before 
> starting a daemon.  I'll change my policy in that regard.

Right. The thing is, this is the mysqladmin program, not mysqld -
mysqladmin is a commandline tool to administrate the database. Not sure
if they should run in the same domain. Right now, mysqladmin is just a
regular tool, i.e. bin_t.


> For the tee thing, I think that the startup scripts you use are using tee to 
> redirect stdout of the daemon to a file on disk as well.  What version of the 
> daemon are you using?

Current sid (updated today). I'm running the normal /etc/init.d/mysql
script, nothing else. The /usr/bin/safe_mysqld script started from
there does indeed contain a few tee commands.

Funny thing is, it worked flawlessly on friday. I made an update
earlier today, so maybe a recent change broke it?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
