Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i084lVRb019817
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 23:47:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i084kSxr004249
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 04:46:28 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id i084kPYc004241
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 04:46:25 GMT
From: Brian May <bam@snoopy.apana.org.au>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Kerberos
References: <200401081401.18967.russell@coker.com.au>
	<84fzerdsst.fsf@snoopy.apana.org.au>
	<200401081442.08541.russell@coker.com.au>
Date: Thu, 08 Jan 2004 15:47:24 +1100
In-Reply-To: <200401081442.08541.russell@coker.com.au> (Russell Coker's
 message of "Thu, 8 Jan 2004 14:42:08 +1100")
Message-ID: <844qv7dp2b.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    >>  All clients and servers need read access.  Even if the
    >> contents of krb5.conf, the worst that could happen is a
    >> denial-of-service attack by pointing programs to the wrong KDC.

    Russell> I'm not sure what you mean by this.  Are you saying that
    Russell> the worst that can happen from unauthorised writes to
    Russell> krb5.conf is a DOS attack?

Correct.

    >> It would not be possible to trick clients into using the wrong
    >> KDC unless the secret key used has been compromised (eg. the
    >> users password, /etc/krb5.keytab, or, worst case, the KDC
    >> itself). In fact, the most important details from krb5.conf can
    >> also be configured in DNS.
    >> 
    >> This however implies that /etc/krb5.keytab needs to be kept
    >> under very tight control; It contains any number of secret
    >> keys.

    Russell> To clarify.  krb5.conf is like /etc/passwd and
    Russell> krb5.keytab is like /etc/shadow ?

Sort of, except security is breached if /etc/passwd is altered in
anyway (I could set my account to be uid=0 for instance), but it isn't
so critical for /etc/krb5.conf. Small point, it probably isn't
significant as far as SE-Linux support is concerned.

    Russell> So most programs access krb5.conf, while only /bin/login
    Russell> and equivalent programs access krb5.keytab (like the
    Russell> passwd and shadow files)?

Yes. All programs access krb5.conf; only servers need access to
krb5.keytab (and login). kinit does not need access to krb5.keytab.

    Russell> Sounds good.  How difficult do you think it would be to
    Russell> implement this for Heimdal?

No idea, it might be worth investigating some time.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
