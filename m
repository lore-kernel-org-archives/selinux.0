Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i083i6Rb019631
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 22:44:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i083h2xr001617
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 03:43:02 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i083h0Yc001498
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 03:43:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Kerberos
Date: Thu, 8 Jan 2004 14:42:08 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200401081401.18967.russell@coker.com.au> <84fzerdsst.fsf@snoopy.apana.org.au>
In-Reply-To: <84fzerdsst.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401081442.08541.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jan 2004 14:26, Brian May <bam@snoopy.apana.org.au> wrote:
> >>>>> "Russell" == Russell Coker <russell@coker.com.au> writes:
>
>     Russell> For Kerberos we have a /etc/krb5.conf file that has the
>     Russell> configuration.  How sensitive is the contents of this
>     Russell> file?
>
> All clients and servers need read access.  Even if the contents of
> krb5.conf, the worst that could happen is a denial-of-service attack
> by pointing programs to the wrong KDC.

I'm not sure what you mean by this.  Are you saying that the worst that can 
happen from unauthorised writes to krb5.conf is a DOS attack?

> It would not be possible to trick clients into using the wrong KDC
> unless the secret key used has been compromised (eg. the users
> password, /etc/krb5.keytab, or, worst case, the KDC itself). In fact,
> the most important details from krb5.conf can also be configured in
> DNS.
>
> This however implies that /etc/krb5.keytab needs to be kept under very
> tight control; It contains any number of secret keys.

To clarify.  krb5.conf is like /etc/passwd and krb5.keytab is like
/etc/shadow ?

>     Russell> Would it be possible to change the kerberos libraries to
>     Russell> spawn a child process similar in nature to unix_chkpwd to
>     Russell> perform the kerberos functions?
>
> I don't think this would help for krb5.conf, but it might help for
> /etc/krb5.keytab.

So most programs access krb5.conf, while only /bin/login and equivalent 
programs access krb5.keytab (like the passwd and shadow files)?

> I am not that familiar with the API used in the Kerberos libraries, so
> I don't know how feasible this is. It could be that the API is
> inappropriate for this split.

I can't imagine how it could be impossible to do this.  The worst-case 
scenario is that you have a dialog between client and server which requires 
two pipes for communication between the unpriv process and the program that's 
like unix_chkpwd.

> The concept though would be to have a child process that takes the
> name of the file (/etc/krb5.keytab), the name of the key within this
> file, and it will decrypt data given with this key.
>
> That way, the daemon never needs access to the secret key.

Sounds good.  How difficult do you think it would be to implement this for 
Heimdal?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
