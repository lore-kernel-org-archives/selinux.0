Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i086JYRb020200
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 01:19:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i086IVxr007466
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 06:18:31 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i086ITYc007449
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 06:18:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Kerberos
Date: Thu, 8 Jan 2004 17:18:08 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200401081401.18967.russell@coker.com.au> <200401081644.02192.russell@coker.com.au> <84wu83at2v.fsf@snoopy.apana.org.au>
In-Reply-To: <84wu83at2v.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401081718.08454.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jan 2004 16:48, Brian May <bam@snoopy.apana.org.au> wrote:
> >>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:
>     >> Or perhaps I am confused with a different meaning for the word
>     >> "client"?
>     >>
>     >> Here, for client, I consider ssh, telnet, etc to be clients and
>     >> sshd, telnetd, etc to be servers.
>
>     Russell> For kerberos sshd is a client and the Kerberos server is
>     Russell> the server.
>
> I see your point, but this gets a bit messy; sshd never actually talks
> to the KDC server. ssh does.

Could you please give me a summary of how Kerberos works in terms of SE Linux.  
What talks to what by what mechanism, and when it does so.

It seems that I don't understand how this is supposed to work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
