Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i085BrRb019936
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 00:11:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i085Anxr005190
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:10:49 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i085AlYc005062
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 05:10:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Kerberos
Date: Thu, 8 Jan 2004 16:10:24 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200401081401.18967.russell@coker.com.au> <200401081442.08541.russell@coker.com.au> <844qv7dp2b.fsf@snoopy.apana.org.au>
In-Reply-To: <844qv7dp2b.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401081610.24138.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jan 2004 15:47, Brian May <bam@snoopy.apana.org.au> wrote:
>     Russell> To clarify.  krb5.conf is like /etc/passwd and
>     Russell> krb5.keytab is like /etc/shadow ?
>
> Sort of, except security is breached if /etc/passwd is altered in
> anyway (I could set my account to be uid=0 for instance), but it isn't
> so critical for /etc/krb5.conf. Small point, it probably isn't
> significant as far as SE-Linux support is concerned.

OK, but the main thing is that there is no reason to label that file 
differently to /etc/passwd (which has etc_t - IE no special labeling).

>     Russell> So most programs access krb5.conf, while only /bin/login
>     Russell> and equivalent programs access krb5.keytab (like the
>     Russell> passwd and shadow files)?
>
> Yes. All programs access krb5.conf; only servers need access to
> krb5.keytab (and login). kinit does not need access to krb5.keytab.

So it seems that a simple way to write policy for Kerberos would be to have 
krb5.conf labeled as etc_t, krb5.keytab labeled at kerberos_secret_t, and 
have the following in domains/misc/kerberos-client.te:
allow { auth auth_chkpwd } kerberos_secret_t:file { getattr read };
can_network({ auth auth_chkpwd })
ifdef(`kerberos.te', `
can_tcp_connect({ auth auth_chkpwd }, kerberosd_t)
')

That just leaves the issue of allowing kerberos getpwnam(3) operations, Steve 
didn't like what I did for nscd.  Maybe if we just allow it for userdomain 
and then test all the daemons to see which ones need it, and have a macro 
can_lookup_user() which will do appropriate things for kerberos, nscd, LDAP, 
etc.

>     Russell> Sounds good.  How difficult do you think it would be to
>     Russell> implement this for Heimdal?
>
> No idea, it might be worth investigating some time.

I was hoping that you would rush off and do it.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
