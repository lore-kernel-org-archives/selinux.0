Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAALWISf006321
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 16:32:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAALVrBb008199
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 21:31:53 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id hAALVq4o008184
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 21:31:52 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id C928617CFC9B
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 22:31:55 +0100 (CET)
Date: Mon, 10 Nov 2003 22:32:07 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: Do we break POSIX?
Message-ID: <20031110213207.GA23280@suse.de>
References: <20031110143701.S16119@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031110143701.S16119@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 10, Tom wrote:

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

The write( ) function may fail if:
[EACCES]            A write was attempted on a socket and the calling
                    process does not have appropriate privileges.

POSIX says nothing about files, but for sockets, EACCES is a valid
error code.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
