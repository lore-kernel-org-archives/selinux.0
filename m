Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FD8KHa017242
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 09:08:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FD7JnJ015100
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 13:07:19 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id h6FD7Ghr015090
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 13:07:17 GMT
Date: Tue, 15 Jul 2003 23:07:54 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Colin Walters <walters@verbum.org>
cc: selinux@tycho.nsa.gov
Subject: Re: crash with 2.5.74 while loading policy
In-Reply-To: <1058249829.24843.13.camel@columbia>
Message-ID: <Mutt.LNX.4.44.0307152306260.23933-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 15 Jul 2003, Colin Walters wrote:

> Hi,
> 
> Linux oopsed while loading a policy today on my SELinux 2.5.74 machine. 
> It doesn't offhand look directly related to SELinux, but I was curious
> if anyone here had seen it before.

I've not seen anything like this with 2.5.  And according to your report, 
it seems that dpkg was running when the oops occurred.


- James
-- 
James Morris
<jmorris@intercode.com.au>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
