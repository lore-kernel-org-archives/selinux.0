Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26994
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 09:46:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA12956
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 13:45:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA12950 for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 13:45:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: latest policy patch
Date: Thu, 17 Oct 2002 15:46:46 +0200
Cc: selinux@tycho.nsa.gov
References: <200210170017.38299.russell@coker.com.au> <200210171050.09887.russell@coker.com.au> <20021017144801.E19993@lemuria.org>
In-Reply-To: <20021017144801.E19993@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210171546.46189.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 17 Oct 2002 14:48, Tom wrote:
> On Thu, Oct 17, 2002 at 10:50:09AM +0200, Russell Coker wrote:
> > > Will you update your policy.tgz file on coker.com.au as well? I've
> > > deviated somewhat from the old default policy, and believe it's easier
> > > and cleaner to install a new one and redo the few changes that were not
> > > added with the apache diff.
> >
> > OK.  But why not just use the Debian package for this?
>
> I can extract the .tgz to some other directory and check for diffs
> _before_ applying it. :)

Of course you could just run the following command when it first asks you 
about changing policy:
diff -ru /usr/share/selinux/policy/default /usr/share/selinux/policy/current \ 
| grep -v ^Only

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
