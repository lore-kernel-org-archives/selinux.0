Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NNuCRb020448
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 18:56:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1NNuBQQ027614
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 23:56:11 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1NNu9P0027487 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 23:56:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: identity
Date: Tue, 24 Feb 2004 10:54:45 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200402231535.26738.russell@coker.com.au> <1077544221.18234.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1077544221.18234.9.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402241054.45407.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Feb 2004 00:50, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > Steve, what do you think?
>
> This seems to overlap with Joshua Brindle's avc ipaddr patches, except
> that his patches have the kernel track the IP addr and include it in the
> AVC audit messages.

Yes.  My idea is (IMHO) a better way of achieving the same aims.

Having the kernel guess the IP address of the client will be difficult in the 
case of login servers that support NIS, LDAP, or Kerberos.  Also knowing more 
than just the IP address will often be useful.

If it's a plain text field that's set by the login process then an identd 
lookup could be performed, and any other data that seems relevant could be 
included.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
