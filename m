Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5OMZK3E026161
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 18:35:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5OMZI5e008030
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 22:35:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h5OMZB92008027 for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 22:35:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dean Anderson <dean@av8.com>, selinux@tycho.nsa.gov
Subject: Re: Macro flags
Date: Wed, 25 Jun 2003 08:34:57 +1000
References: <Pine.LNX.4.44.0306241033090.11428-100000@vista.av8.net>
In-Reply-To: <Pine.LNX.4.44.0306241033090.11428-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306250834.57476.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Jun 2003 00:38, Dean Anderson wrote:
> I'm trying to setup a domain and file contexts for proftpd, running as a
> daemon.  I noticed that the ftpd.te has an ifdef(`ftpd_daemon')
> conditional.
>
> Where should these flags be set? Is there a preferred file to put these
> flags in?

At the moment there is no fixed place.  I have been thinking about using a 
special file for it which has comments documenting all the standard 
definitions that you may use.

In the mean time I suggest using domains/misc/custom.te.

> Also, are you interested in additional domains and file contexts for
> things like DJB's rbldns and such?

Yes.  Any policy you write which is likely to be of wider use is of interest.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
