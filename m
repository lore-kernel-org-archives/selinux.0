Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9DAOPWt013397
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 06:24:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9DAOPUb020884
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 10:24:25 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9DAONhX020875 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 10:24:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erlend Aasland <erlend-a@ux.his.no>
Subject: Re: Users are not assigned correct security context on login
Date: Mon, 13 Oct 2003 20:24:15 +1000
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <20031013110626.GA10270@badne3.ux.his.no> <200310131950.09485.russell@coker.com.au> <20031013120218.GB14227@badne3.ux.his.no>
In-Reply-To: <20031013120218.GB14227@badne3.ux.his.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310132024.15616.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Oct 2003 22:02, Erlend Aasland wrote:
> > It looks like you have not installed the SE Linux patched /bin/login or
> > the SE
>
> I've successfully applied the SELinux patches to util-linux, so
> /bin/login should be ok. I will give the PAM module a try and see if it
> helps.

Combining the PAM module and a patched /bin/login is not a good idea, it is 
likely to work to some extent but will report errors relabeling the tty 
device at least.

But I suggest double-checking the util-linux patch, the symptoms exactly match 
what happens when an unpatched /bin/login is used, I can't think of any other 
possible cause.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
