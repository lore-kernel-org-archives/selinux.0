Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i083QpRb019569
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 22:26:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i083QoiV022314
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 03:26:51 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id i083Qm06022306 for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 03:26:49 GMT
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Kerberos
References: <200401081401.18967.russell@coker.com.au>
From: Brian May <bam@snoopy.apana.org.au>
Date: Thu, 08 Jan 2004 14:26:42 +1100
In-Reply-To: <200401081401.18967.russell@coker.com.au> (Russell Coker's
 message of "Thu, 8 Jan 2004 14:01:18 +1100")
Message-ID: <84fzerdsst.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:

    Russell> For Kerberos we have a /etc/krb5.conf file that has the
    Russell> configuration.  How sensitive is the contents of this
    Russell> file?

All clients and servers need read access.  Even if the contents of
krb5.conf, the worst that could happen is a denial-of-service attack
by pointing programs to the wrong KDC.

It would not be possible to trick clients into using the wrong KDC
unless the secret key used has been compromised (eg. the users
password, /etc/krb5.keytab, or, worst case, the KDC itself). In fact,
the most important details from krb5.conf can also be configured in
DNS.

This however implies that /etc/krb5.keytab needs to be kept under very
tight control; It contains any number of secret keys.

    Russell> Would it be possible to change the kerberos libraries to
    Russell> spawn a child process similar in nature to unix_chkpwd to
    Russell> perform the kerberos functions?

I don't think this would help for krb5.conf, but it might help for
/etc/krb5.keytab.

I am not that familiar with the API used in the Kerberos libraries, so
I don't know how feasible this is. It could be that the API is
inappropriate for this split.

The concept though would be to have a child process that takes the
name of the file (/etc/krb5.keytab), the name of the key within this
file, and it will decrypt data given with this key.

That way, the daemon never needs access to the secret key.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
