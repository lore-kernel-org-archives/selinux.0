Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAALq7Sf006469
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 16:52:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAALphBb009766
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 21:51:43 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id hAALph4o009763
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 21:51:43 GMT
Date: Mon, 10 Nov 2003 16:52:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Tom <tom@lemuria.org>
cc: selinux@tycho.nsa.gov
Subject: Re: Do we break POSIX?
In-Reply-To: <20031110143701.S16119@lemuria.org>
Message-ID: <Xine.LNX.4.44.0311101651350.5214-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 10 Nov 2003, Tom wrote:

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

No, we do not break Posix, as anyone can add new error codes.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
