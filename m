Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA18573
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 08:02:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA06946
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 12:01:01 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id MAA06939 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 12:01:00 GMT
Date: Mon, 30 Sep 2002 14:02:36 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: new policy
Message-ID: <20020930140236.B17748@lemuria.org>
References: <200209300055.39193.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209300055.39193.russell@coker.com.au>; from russell@coker.com.au on Mon, Sep 30, 2002 at 12:55:38AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Sep 30, 2002 at 12:55:38AM +0200, Russell Coker wrote:
> The netscape changes in netscape.diff rely on the new file x_client_macros.te, 
> it is about splitting the X access part of it into a separate file so the 
> same policy is also used by other programs that use X but which are not 
> entirely trusted.

would it make sense to create a macro here, along the lines of
can_network ? can_x is most certainly something that'll appear often.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
