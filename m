Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA11006
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 08:47:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA08088
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 13:45:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA08084 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 13:45:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: mysql policy
Date: Mon, 28 Oct 2002 14:47:09 +0100
Cc: selinux@tycho.nsa.gov
References: <20021028110158.A1294@lemuria.org> <200210281324.12898.russell@coker.com.au> <20021028135809.A4521@lemuria.org>
In-Reply-To: <20021028135809.A4521@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210281447.09486.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Oct 2002 13:58, Tom wrote:
> On Mon, Oct 28, 2002 at 01:24:12PM +0100, Russell Coker wrote:
> > It's not that uncommon for an init script to read the config file before
> > starting a daemon.  I'll change my policy in that regard.
>
> Right. The thing is, this is the mysqladmin program, not mysqld -
> mysqladmin is a commandline tool to administrate the database. Not sure
> if they should run in the same domain. Right now, mysqladmin is just a
> regular tool, i.e. bin_t.

Being in bin_t means of course that there's no domain transition.

Maybe the right thing to do would be to have a separate domain for mysql 
admin, so initrc_t transitions to mysqld_admin_t which then transitions to 
mysqld_t when it runs the database server.

I haven't got into these things in any detail, you're probably the best person 
to work on this.

> Funny thing is, it worked flawlessly on friday. I made an update
> earlier today, so maybe a recent change broke it?

That's not uncommon.  Debian/unstable changes fast.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
