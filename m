Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KD1hWt019460
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:01:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KD1W0p024164
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:01:32 GMT
Received: from unicorn.lemuria.org (b067032.adsl.hansenet.de [62.109.67.32])
	by jazzswing.ncsc.mil  with ESMTP id h9KD1Vr7024161
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:01:31 GMT
Date: Mon, 20 Oct 2003 14:55:27 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
Message-ID: <20031020145526.H321@lemuria.org>
References: <20031018113455.GA22140@wavehammer.waldi.eu.org> <200310190035.06420.russell@coker.com.au> <20031019121044.GA29052@wavehammer.waldi.eu.org> <200310192301.20068.russell@coker.com.au> <20031019163501.GA26554@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031019163501.GA26554@wavehammer.waldi.eu.org>; from bastian+selinux=tycho.nsa.gov@waldi.eu.org on Sun, Oct 19, 2003 at 06:35:01PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 19, 2003 at 06:35:01PM +0200, Bastian Blank wrote:
> okay, i see it. but it seems to violate the fhs by put the libselinux.so
> symlink into /lib as well, it is not essential for running applications.

It is. For all apps that reside in /bin or /sbin and could potentially
be executed before /usr is mounted.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
