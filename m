Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i085Y3Rb020003
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 00:34:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i085Wxxr005999
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:32:59 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id i085WvYc005996
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:32:58 GMT
From: Brian May <bam@snoopy.apana.org.au>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Kerberos
References: <200401081401.18967.russell@coker.com.au>
	<200401081442.08541.russell@coker.com.au>
	<844qv7dp2b.fsf@snoopy.apana.org.au>
	<200401081610.24138.russell@coker.com.au>
Date: Thu, 08 Jan 2004 16:33:57 +1100
In-Reply-To: <200401081610.24138.russell@coker.com.au> (Russell Coker's
 message of "Thu, 8 Jan 2004 16:10:24 +1100")
Message-ID: <84brpfc8ca.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    Russell> So it seems that a simple way to write policy for
    Russell> Kerberos would be to have krb5.conf labeled as etc_t,
    Russell> krb5.keytab labeled at kerberos_secret_t, and have the
    Russell> following in domains/misc/kerberos-client.te:

    Russell> allow { auth auth_chkpwd } kerberos_secret_t:file { getattr read };
    Russell> can_network({ auth auth_chkpwd })
    Russell> ifdef(`kerberos.te', `
    Russell> can_tcp_connect({ auth auth_chkpwd }, kerberosd_t)
    Russell> ')

This is for the server, right?

The client doesn't need access to kerberos_secret_t, only servers.

Or perhaps I am confused with a different meaning for the word
"client"?

Here, for client, I consider ssh, telnet, etc to be clients and sshd,
telnetd, etc to be servers.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
