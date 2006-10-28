Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9SHoi9T013018
	for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 13:50:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9SHnwdQ017724
	for <selinux@tycho.nsa.gov>; Sat, 28 Oct 2006 17:49:58 GMT
Message-ID: <4543985C.4000002@tresys.com>
Date: Sat, 28 Oct 2006 13:50:20 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
CC: selinux@tycho.nsa.gov
Subject: Re: Object manager for X-Window
References: <BAY114-F3051C1F2700FEE079C12B1AF050@phx.gbl>
In-Reply-To: <BAY114-F3051C1F2700FEE079C12B1AF050@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Salvo Giuffrida wrote:
> I saw that the file flask/access_vectors in the policy source 
> directory has definitions also for graphic objects (window, drawable, 
> font, etc...). Does this mean that the default kernel-space object 
> manager is able to enforce a TE/MLS policy also to X objects?
> Thanks
No, clearly the kernel does not know what a window or cursor are, X 
enforces the decisions that it gets from the security server in the kernel.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
