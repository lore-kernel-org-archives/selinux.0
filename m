Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i085jTRb020065
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 00:45:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i085iQxr006360
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:44:26 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i085iOYc006314
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:44:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Kerberos
Date: Thu, 8 Jan 2004 16:44:02 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200401081401.18967.russell@coker.com.au> <200401081610.24138.russell@coker.com.au> <84brpfc8ca.fsf@snoopy.apana.org.au>
In-Reply-To: <84brpfc8ca.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401081644.02192.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jan 2004 16:33, Brian May <bam@snoopy.apana.org.au> wrote:
> >>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:
>
>     Russell> So it seems that a simple way to write policy for
>     Russell> Kerberos would be to have krb5.conf labeled as etc_t,
>     Russell> krb5.keytab labeled at kerberos_secret_t, and have the
>     Russell> following in domains/misc/kerberos-client.te:
>
>     Russell> allow { auth auth_chkpwd } kerberos_secret_t:file { getattr
> read }; Russell> can_network({ auth auth_chkpwd })
>     Russell> ifdef(`kerberos.te', `
>     Russell> can_tcp_connect({ auth auth_chkpwd }, kerberosd_t)
>     Russell> ')
>
> This is for the server, right?

kerberos.te is for the Kerberos server.  The policy I suggested above is for 
Kerberos clients such as sshd, which need to access the secret file, the 
network, and TCP connections to the local kerberos server (if there is one).

> The client doesn't need access to kerberos_secret_t, only servers.

The krb5.keytab file needs to be accessed by kerberos clients such as login 
and sshd.

> Or perhaps I am confused with a different meaning for the word
> "client"?
>
> Here, for client, I consider ssh, telnet, etc to be clients and sshd,
> telnetd, etc to be servers.

For kerberos sshd is a client and the Kerberos server is the server.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
