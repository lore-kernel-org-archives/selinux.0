Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9JHwuWt016776
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 13:58:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9JHwj0p009197
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 17:58:45 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9JHuZr7009106
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 17:56:48 GMT
Date: Sun, 19 Oct 2003 18:35:01 +0200
From: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
Message-ID: <20031019163501.GA26554@wavehammer.waldi.eu.org>
References: <20031018113455.GA22140@wavehammer.waldi.eu.org> <200310190035.06420.russell@coker.com.au> <20031019121044.GA29052@wavehammer.waldi.eu.org> <200310192301.20068.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310192301.20068.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 19, 2003 at 11:01:20PM +1000, Russell Coker wrote:
> Here is the message with the patch:
> http://marc.theaimsgroup.com/?l=selinux&m=106557438826674&w=2

okay, i see it. but it seems to violate the fhs by put the libselinux.so
symlink into /lib as well, it is not essential for running applications.

bastian

-- 
Without freedom of choice there is no creativity.
		-- Kirk, "The return of the Archons", stardate 3157.4

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
