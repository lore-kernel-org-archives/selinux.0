Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00206
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 11:52:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA07533
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:51:10 GMT
Received: from Cantor.suse.de (Cantor.suse.de [194.112.123.193])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA07529
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:51:09 GMT
Date: Mon, 15 Jan 2001 17:52:31 +0100
From: Andi Kleen <ak@suse.de>
To: Bennett Todd <bet@rahul.net>
Cc: Jan Petranek <jan@petranek.de>, selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root
Message-ID: <20010115175231.A15560@gruyere.muc.suse.de>
References: <01011516091701.13938@linux16> <20010115112253.H8565@rahul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010115112253.H8565@rahul.net>; from bet@rahul.net on Mon, Jan 15, 2001 at 11:22:53AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Mon, Jan 15, 2001 at 11:22:53AM -0500, Bennett Todd wrote:
> Now _if_ you had a situation where the machine was sufficiently
> thoroughly physically secured, and the software running on it
> sufficiently tightly configured, that you were confident that the OS
> wasn't tampered with, then the problem would reduce to a real oldie,
> the trusted path. The typical fix for that is to have the OS
> directly support a special hot-key combo that is absolutely
> guaranteed to terminate all processes associated with that console,
> and start a new login process, guaranteed to come from the real OS
> and not any trojan left running by the last person on that console.
> That would be easy to add to selinux. In fact, I thought I'd
> remembered seeing something along those lines, but when I just
> checked the todo.html I didn't find 'em, maybe my brain is playing
> nasty tricks on me.

Linux already has a secure attention key, you just have to enable it.
Unfortunately it doesn't do very good, because when the X server is
unexpectedly killed it often leaves the graphic card in unusable state.
>From a network login you can also just open a new ssh/telnet etc. 


-Andi


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
