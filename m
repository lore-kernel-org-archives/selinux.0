Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA11335
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 09:06:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA08944
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 14:04:06 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id OAA08940 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 14:04:04 GMT
Date: Mon, 28 Oct 2002 15:05:47 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021028150547.A7632@lemuria.org>
References: <20021028110158.A1294@lemuria.org> <200210281324.12898.russell@coker.com.au> <20021028135809.A4521@lemuria.org> <200210281447.09486.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210281447.09486.russell@coker.com.au>; from russell@coker.com.au on Mon, Oct 28, 2002 at 02:47:09PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 28, 2002 at 02:47:09PM +0100, Russell Coker wrote:
> Maybe the right thing to do would be to have a separate domain for mysql 
> admin, so initrc_t transitions to mysqld_admin_t which then transitions to 
> mysqld_t when it runs the database server.

Funny thing is: It doesn't I don't understand why it's running
mysaqladmin at all. Oh, well, I'll just find out.


> I haven't got into these things in any detail, you're probably the best person 
> to work on this.

So I'm now with apache and mysql. :)

That's fine with me as I'm working on that anyways. I'm currently
fighting with apache2 and SSL. I'll get to apache1+SSL later.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
