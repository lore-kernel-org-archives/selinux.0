Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05846
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 10:23:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0MFMlI18990
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 15:22:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0MFMkf18986 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 15:22:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>, Tom <tom@lemuria.org>
Subject: Re: Apache/mysql policy status ?
Date: Wed, 22 Jan 2003 16:22:15 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0301220841170.23864-200000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0301220841170.23864-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301221622.15207.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Jan 2003 14:49, Wayne Salamon wrote:
>   Tom, I've attached a diff file that brings your patch from October up to
> date with the current CVS tree. But are you working on a new version of
> the apache policy, or should this patch be applied?
>
>   Note that I've added back in the admin TTY rule/comments that were
> eliminated after your first patch. Is this access still needed for Apache
> 2.0?

For apache2 putting the following on the apache command line should allow it 
to start:
< /dev/null > /dev/null 2>&1

Therefore the change to allow apache access to the admin_tty_type should not 
be absolutely required.

The comment "The user role is authorized for this domain" doesn't match the 
"role system_r" on the next line...

Regarding the can_exec(httpd_php_t, lib_t) line, perhaps something should be 
re-labelled from lib_t to some other type instead?

For access to /tmp there's the tmp_domain() macro.

For the mysql access we probably need a can_mysql_connect() macro which can be 
used on demand.  It's likely that there are people who have mysql and PHP on 
the same machine and don't want them to communicate with each other.  So I 
think it's best to have that access denied and easy to allow on demand.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
