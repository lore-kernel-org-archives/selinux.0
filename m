Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2H6QBx6026058
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 01:26:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA24225
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 06:22:45 GMT
Received: from lappy.home.eternal-newbie.dk (213.237.70.59.adsl.vby.worldonline.dk [213.237.70.59])
	by jazzswing.ncsc.mil  with ESMTP id GAA24221
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 06:22:44 GMT
Received: from localhost
	([127.0.0.1] helo=lappy.home.eternal-newbie.dk ident=ask)
	by lappy.home.eternal-newbie.dk with smtp (Exim 3.36 #1 (Debian))
	id 18uo3z-0004C9-00
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 07:25:36 +0100
Date: Mon, 17 Mar 2003 07:25:24 +0100
From: Ask Holme <ask@eternal-newbie.dk>
To: selinux@tycho.nsa.gov
Subject: Re: Apache policy
Message-Id: <20030317072524.0334bac0.ask@eternal-newbie.dk>
In-Reply-To: <200303162342.50653.russell@coker.com.au>
References: <200303162342.50653.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 16 Mar 2003 23:42:50 +0100
Russell Coker <russell@coker.com.au> wrote:

> Now I think that the only correct thing to do is to have a
> cgiwrap/suexec type program with SE Linux functionality to use the
> correct role and identity for the cgi-bin scripts (I believe that
> something similar has been done previously but not released).

I belive that the apache 2 suexec model could easily be ported to be
"security aware" :) (the suexec model does not only apply to .cgi but
also to .php and other kinds of server side scripts, making it all
secure :) 

-- 
Regards

Ask Holme aka kVanQue
Half-time student - Fulltime geek
PGP/GPG keyid 58CE6FE4 - fetch it today, from your local keyserver

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
