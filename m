Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i090WKRb027301
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 19:32:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i090VGxr020790
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 00:31:16 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id i090V8Yc020781
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 00:31:09 GMT
From: Brian May <bam@snoopy.apana.org.au>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Kerberos
References: <200401081401.18967.russell@coker.com.au>
	<200401081644.02192.russell@coker.com.au>
	<84wu83at2v.fsf@snoopy.apana.org.au>
	<200401081718.08454.russell@coker.com.au>
Date: Fri, 09 Jan 2004 11:32:05 +1100
In-Reply-To: <200401081718.08454.russell@coker.com.au> (Russell Coker's
 message of "Thu, 8 Jan 2004 17:18:08 +1100")
Message-ID: <84d69uarne.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    Russell> Could you please give me a summary of how Kerberos works
    Russell> in terms of SE Linux.  What talks to what by what
    Russell> mechanism, and when it does so.

    Russell> It seems that I don't understand how this is supposed to
    Russell> work.

In order to allow user U to use server S, the user needs a ticket,
T(U,S).

Initially the first server the user will (almost always) get access to
is the TGS (ticket granting server), which will then give tickets for
any other server.

In order to simplify the following, I have eliminated stuff used to
prevent replay attacks. I am also assuming that the user obtains the
ticket to use the desired service on first contact with the KDC, as
the TGS is just a service like any other (with the exception it is
provided by the KDC).

Note:

1. The KDC is the secure server acting as the third party and
   has all secret keys.
2. Only the KDC and the user know K(U), the user's password.
3. Only the KDC and the server know K(S), the secret key for service S.
   This is stored in /etc/krb5.keytab on the server.
4. I have used server to mean the server that the client/user connects to.

To summarise:

1. To use service S, user U obtains a ticket, either using kinit, or
   the Kerberos PAM module. Internally (for kinit) this:

   a) asks the user for their password, K(U).
   b) sends a request to the KDC server.
   c) receives the response. There are two parts:
      1. A session key that is encrypted with K(U), this is decrypted.
      2. A session key that is encrypted with K(S), the user can't access this.

   The fact that the response was decrypted proves that the remote KDC
   is the correct one, as only it could encrypt the response with the
   users password.

2. The user later on needs to use service S. The "authenticator" is
   sent to the server. This includes:
   a) The session key encrypted with K(S).
   b) The name of the client (according to my notes, not sure of this)
   encrypted with the session key.

   The server then decrypts the session key with K(S). It then
   decrypts the rest of the data with the session key. It now has
   authenticated the user, as only the U and S could encrypt data with
   the session key (actually the KDC also could, but we are assuming
   it is trusted[1]). It can then use this session key to talk to the
   client. If it sends a message to the client encrypted with the
   session key, the client can authenticate the server.


As far as SE-Linux is concerned, there are several week points:

1. User enters the password, which is used to decrypt the session key,
Possibly SE-Linux can prevent core dumps, strace, gdb, of kinit. This
might help to some degree. kinit is just a normal non-setuid
not-setguid executable.

2. The server only needs to decrypt the session key, but has access to
all Kerberos secret keys stored on that computer; this is what I speculated
could be fixed with the helper program.

3. On the KDC, only the KDC server should have any access to the KDC
secret data. In fact, you could argue that not even the administrator
should have access (except for initial installation).


I hope this helps clarifies the process. This is all mostly from
memory, and from my thesis, because it was so long ago when I worked
on it.


Note:

[1] There was an extension to the Kerberos protocol to so even the KDC
doesn't know the session key. Diffie Hellman??? I can't remember the
details.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
