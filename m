Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA29665
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 13:57:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0LIvYI25312
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 18:57:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0LIvXf25308 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 18:57:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Cambridge Security Group talk
Date: Tue, 21 Jan 2003 19:57:22 +0100
Cc: selinux@tycho.nsa.gov
References: <200301211748.MAA02328@moss-shockers.ncsc.mil>
In-Reply-To: <200301211748.MAA02328@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301211957.22188.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jan 2003 18:48, Stephen D. Smalley wrote:
> > Which raises another interesting topic, that is 2.5.x supports attrs
> > (EAs) on ext2 and ext3 (at the minimum; I don't know about reiserfs),
> > maybe SE-Linux security contexts could be stored in attrs?
>
> Yes, we're looking into the use of EAs for file security contexts.
> We would still retain the persistent label mapping as a fallback if
> the filesystem didn't support EAs.

I think it would be good to have a migration strategy from PSID to xattr in 
this case.  We need a way to convert a system from PSID to xattr without 
down-time (IE it must be possible to convert the root file system without 
having to boot with a different root fs).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
