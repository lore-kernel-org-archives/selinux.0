Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99CotSe016238
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 08:50:55 -0400
Received: from bay0-omc2-s27.bay0.hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99CoHjU019314
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 12:50:17 GMT
Message-ID: <BAY114-F34E9E30AB0797D837EDF94AF160@phx.gbl>
In-Reply-To: <452A35CD.4050005@tresys.com>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: Re: Who is responsible for role assignment?
Date: Mon, 09 Oct 2006 14:50:51 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From: Joshua Brindle <jbrindle@tresys.com>
>To: Salvo Giuffrida <giuffsalvo@hotmail.it>
>CC: selinux@tycho.nsa.gov
>Subject: Re: Who is responsible for role assignment?
>Date: Mon, 09 Oct 2006 07:43:09 -0400
>
>Salvo Giuffrida wrote:
>>Who is responsible for role and domain assignment during the login? The 
>>single programs listed in the default_context file (ssh, login, cron, su, 
>>etc..)? Or is this a "trasparent" operation, done by the security server?
>>Thanks
>The login programs attempt the contexts in default_context in order. The 
>first to succeed wins. The security server doesn't know about abstract 
>events like logins and has no reason to.
I though that, during the creation of the shell process by the login 
programs (using fork() and execve()), the security server was responsible 
for correct labeling of the child process created.
But it looks like this is a responsibility of the login programs 
themselves....So, this implies that they've been modified to use libselinux 
APIs (setexeccon(), and so on)?
Thanks

_________________________________________________________________
Ricerche online più semplici e veloci con MSN Toolbar! 
http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
