Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA07633
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 06:30:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA27567
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 10:29:07 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id KAA27563 for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 10:29:07 GMT
Date: Wed, 9 Oct 2002 12:30:56 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: /proc woes
Message-ID: <20021009123056.C18828@lemuria.org>
References: <20021008163245.A5508@lemuria.org> <Pine.GSO.4.33.0210081037410.25356-100000@raven> <20021008171123.A6113@lemuria.org> <200210081913.17017.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210081913.17017.russell@coker.com.au>; from russell@coker.com.au on Tue, Oct 08, 2002 at 07:13:17PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 08, 2002 at 07:13:17PM +0200, Russell Coker wrote:
> If you do the following:
> echo /proc | setfiles -s -v /etc/selinux/file_contexts/file_contexts
> Then it will be relabelled to file_t.
> 
> The Debian package base-files "owns" /proc and therefore it will be relabelled 
> in the fashion shown above if you upgrade your base-files package.

That sounds like it's what happened, since I did indeed do a major
update that most likely included base-files.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
