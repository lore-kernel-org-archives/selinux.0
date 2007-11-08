Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA8KBLPJ013949
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 15:11:22 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA8KBJvr029913
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 20:11:20 GMT
Message-ID: <47336D33.4010606@redhat.com>
Date: Thu, 08 Nov 2007 15:10:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: type class key
References: <1194529933.3293.7.camel@vogon>
In-Reply-To: <1194529933.3293.7.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> Every time I log into my system via ssh an audit is generated:
> 
> audit(1194529539.754:7803673): avc:  denied  { link } for  pid=9526
> comm="sshd" scontext=system_u:system_r:sshd_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:dovecot_t:s0 tclass=key
> 
> and after logout the following:
> 
> audit(1194529580.969:7803674): avc:  denied  { search } for  pid=9526
> comm="sshd" scontext=system_u:system_r:sshd_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:dovecot_t:s0 tclass=key
> 
> Quite frankly I even do not know what a type class "key" is. Can someone
> explain to me what a type class "key" is? And maybe any suggestions why
> ssh tries to access dovecot's key (which is an imap server).
> 
> cheers,
> Stefan
> 
> PS: I'm running CentOS 5 with the latest updates and strict policy.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
key is the SELinux mapping of the kernel keyring.  No app currently uses
the kernel keyring, to the best of my knowledge.  And the pam
configurations up to now are setup incorrectly.

When any confined app runs it gets handed a keyring and does a search
access on the app that created the key ring.

The avc's you are reporting above are very strange.  They look like
dovecot created a keyring, probably though pam_keyinit.  And now sshd is
trying to access it.  I think you are running in permissive mode and
your context is messed up.

When you login are you getting user_t or staff_t?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHM20yrlYvE4MpobMRAoY/AJ43FAim2WQEt1yrpHMsWMjKnpJoWQCfSemn
ihtmBI+3TyCb09sQIX+ssnU=
=/Ad8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
