Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2JBeRb017503
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:11:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2JBeqY012964
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 19:11:40 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
        by jazzband.ncsc.mil  with ESMTP id hB2JBc0o012960 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 19:11:39 GMT
Date: Tue, 2 Dec 2003 20:04:42 +0100
From: Tom <tom@lemuria.org>
To: joshmccormack@travelersdiary.com
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Debian Investigation Report after Server Compromises (fwd)
Message-ID: <20031202200441.I18433@lemuria.org>
References: <Pine.LNX.4.44.0312021036000.14896-100000@westhost39.westhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0312021036000.14896-100000@westhost39.westhost.net>; from joshmccormack@travelersdiary.com on Tue, Dec 02, 2003 at 10:37:40AM -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 10:37:40AM -0600, joshmccormack@travelersdiary.com wrote:
> Sorry this is so long, but I couldn't find it online anywhere to send a link out. I'd love some perspective on this from people using SELinux, on Debian ideally. 

As I learned earlier this year, protection of the system once the
kernel has been broken open is outside the scope of SELinux.

It's an interesting topic, though. And it will certainly grow in
importance as the blackhats are concentrating more on kernel exploits
and less on userspace exploits. Which is a trend we've been seing for
at least a year now.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
