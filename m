Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i085nARb020087
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 00:49:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i085m6xr006477
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:48:06 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id i085lwYc006474
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:47:59 GMT
From: Brian May <bam@snoopy.apana.org.au>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Kerberos
References: <200401081401.18967.russell@coker.com.au>
	<200401081610.24138.russell@coker.com.au>
	<84brpfc8ca.fsf@snoopy.apana.org.au>
	<200401081644.02192.russell@coker.com.au>
Date: Thu, 08 Jan 2004 16:48:56 +1100
In-Reply-To: <200401081644.02192.russell@coker.com.au> (Russell Coker's
 message of "Thu, 8 Jan 2004 16:44:02 +1100")
Message-ID: <84wu83at2v.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    >> Or perhaps I am confused with a different meaning for the word
    >> "client"?
    >> 
    >> Here, for client, I consider ssh, telnet, etc to be clients and
    >> sshd, telnetd, etc to be servers.

    Russell> For kerberos sshd is a client and the Kerberos server is
    Russell> the server.

I see your point, but this gets a bit messy; sshd never actually talks
to the KDC server. ssh does.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
