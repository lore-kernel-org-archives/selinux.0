Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03JYIXf023492
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:34:19 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03JXIqa029566
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:33:18 GMT
Message-ID: <43BAB5C7.5080904@cornell.edu>
Date: Tue, 03 Jan 2006 12:35:03 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: libsepol
References: <200601040559.04895.russell@coker.com.au>
In-Reply-To: <200601040559.04895.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -		context_destroy(&c->context[0]);
> -		context_destroy(&c->context[1]);
> +		if(con)
> +		{
> +			context_destroy(&con->context[0]);
> +			context_destroy(&con->context[1]);
> +		}
>   
This is actually wrong, the bug is that con should be iface, as we're 
freeing the interface's context.
The variable c was correctly left uninitialized in the code - it was 
just used where it's not supposed to.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
