Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAICuSf005113
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 13:12:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAAICV1W022306
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:12:32 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id hAAICU5e022303
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:12:31 GMT
Date: Mon, 10 Nov 2003 18:03:38 +0000
From: =?iso-8859-2?B?TWFnb3PhbnlpIMFycOFk?= <mag@bunuel.tii.matav.hu>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: [selinux] Do we break POSIX?
Message-ID: <20031110180338.GB18816@bunuel.tii.matav.hu>
References: <20031110143701.S16119@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20031110143701.S16119@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

write(2) on linux does not actually lists EACCESS as a possible error
value. It also says: "Other errors may occur, depending on the object
connected to fd."
Let's assume for now that returning permission denied error from write
operation breaks POSIX.

I would not consider it a big issue, because
	-write can do error return, and any well-behaved application
	should handle that, even when the error code is unexpected
	-if you want to be posixly correct, you can still give EIO
	as the error code
	-revocation of permission to write occurs infrequently,
	as normally programs do not cross domains, and policy is
	reloaded only very infrequently. And you make your trusted
	procedures error resistant, don't you?

A levelezõm azt hiszi, hogy Tom a következõeket írta:
> One point brought up by Theo DeRaadt during PacSec was that according
> to POSIX, write operations can not return a permission denied error.
> 
> I could not argue with him on that because I have not actually read the
> POSIX standard, but he has a valid point in that breaking standards
> would be a big no.
> 
> Does anyone know immediately if this is so and if we are indeed
> breaking POSIX? If nobody can answer that, I will find out myself, as
> I've promised him to check.
> 
> 
> -- 
> PGP/GPG key: http://web.lemuria.org/pubkey.html
> pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
>      Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
