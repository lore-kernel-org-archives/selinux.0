Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OElTRb023375
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 09:47:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1OElEQQ013321
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 14:47:14 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i1OElDP0013318 for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 14:47:14 GMT
Date: Tue, 24 Feb 2004 09:47:26 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: identity
In-Reply-To: <200402231535.26738.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Feb 2004, Russell Coker wrote:

> The idea is to have something like rjc#10.0.0.1:user_r:user_t to indicate that 
> I logged in from IP address 10.0.0.1.

How would the kernel know the IP address you're logged in from?  Would you 
also want to log the serial device if that's how the user logged in?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
