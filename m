Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h647fkHa005718
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 03:41:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h647fjH5007262
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 07:41:45 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h647fiRX007259 for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 07:41:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Mauro Chiarugi <vlaovic@libero.it>
Subject: Re: Policies.. but where there are?
Date: Fri, 4 Jul 2003 17:41:36 +1000
Cc: selinux@tycho.nsa.gov
References: <20030703234800.330f8026.vlaovic@libero.it> <200307040852.51081.russell@coker.com.au> <20030704085135.0ffdf7a7.vlaovic@libero.it>
In-Reply-To: <20030704085135.0ffdf7a7.vlaovic@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307041741.36842.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Jul 2003 16:51, Mauro Chiarugi wrote:
> Il Fri, 4 Jul 2003 08:52:51 +1000
>
> Russell Coker borbottando disse:
> > They are stored in a "policy database" named
> > /etc/security/selinux/policy.XX (where XX is the version number) in
> > recent versions.
>
> I believe that policy.XX is protected against attacks, such as malicious
> editing.. is it right???

Yes.  There is a special type for it and it is protected against editing.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
