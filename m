Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04JVZIi027132
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 14:31:35 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04JThPZ018968
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 19:29:43 GMT
Subject: Re: policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200501022303.49225.russell@coker.com.au>
References: <200501022303.49225.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104867214.19492.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 04 Jan 2005 14:33:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-02 at 07:03, Russell Coker wrote:
> network_macros.diff makes a cosmetic change to the network macros.

I don't see the benefit of this, the compiler will take care of the
duplicate rules, and it is easier to maintain as is.  

If this were the only thing producing duplicate rules, then it might be
worthwhile.  

If we were going to change it, wouldn't this be better anyway?

define(`can_network_tcp',`
base_can_network($1, tcp, `$2')
allow $1 self:tcp_socket { listen accept connect };
')

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
