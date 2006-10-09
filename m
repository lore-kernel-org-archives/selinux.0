Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99BhNnF014451
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 07:43:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k99Bg7v2013503
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 11:42:07 GMT
Message-ID: <452A35CD.4050005@tresys.com>
Date: Mon, 09 Oct 2006 07:43:09 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
CC: selinux@tycho.nsa.gov
Subject: Re: Who is responsible for role assignment?
References: <BAY114-F176D19BDB63BBD335C9ED9AF160@phx.gbl>
In-Reply-To: <BAY114-F176D19BDB63BBD335C9ED9AF160@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Salvo Giuffrida wrote:
> Who is responsible for role and domain assignment during the login? 
> The single programs listed in the default_context file (ssh, login, 
> cron, su, etc..)? Or is this a "trasparent" operation, done by the 
> security server?
> Thanks
The login programs attempt the contexts in default_context in order. The 
first to succeed wins. The security server doesn't know about abstract 
events like logins and has no reason to.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
