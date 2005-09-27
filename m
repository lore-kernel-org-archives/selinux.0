Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RL3WNs029574
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 17:03:32 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RKw4pk000394
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 20:58:04 GMT
Message-ID: <4339B46C.50800@cornell.edu>
Date: Tue, 27 Sep 2005 17:06:52 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: selinux@tycho.nsa.gov, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage-functionality 4/17
References: <200509272038.j8RKcKYs000732@gotham.columbia.tresys.com>
In-Reply-To: <200509272038.j8RKcKYs000732@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>These also need to be routed through the handle function pointers so that
>alternative implementations for the policy server can be provided. This can
>be done by:
>
>1) adding the function pointers to the semanage_func_table in
>src/include/semanage_private.h.
>
>2) Adding a routing function in semanage.c that calls the function pointer
>in the handle and performs any error passing. This function cannot assume
>any implementation details.
>
>3) Filling in the function pointers in semange_direct_connect
>(direct_api.c).
>  
>
...I'll get to this eventually... the first portion (passing the handle) 
was in my dbase initialization patch, but I need to update that to fit 
with your code. It's not entirely clear how policy connections will work 
- that's the next thing I was going to figure out. I want to fill out 
another record table for policy functions (look at the initialization 
patch, and how it separates things out into several tables).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
