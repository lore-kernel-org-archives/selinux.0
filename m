Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA20092
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:36:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA07364
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:33:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA07360
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:33:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Frank Mayer" <mayerf@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: some random policy observations
Date: Mon, 24 Feb 2003 23:36:24 +0100
References: <004901c2dc50$c208b480$6600a8c0@columbia.tresys.com>
In-Reply-To: <004901c2dc50$c208b480$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302242336.24663.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Feb 2003 23:04, Frank Mayer wrote:
> 1. dpkg_t has load_policy access to security_t security object.
> Probably a legacy problem; seems like it should use the load_policy
> program, which is the only one that needs this access.

Good point, I'll change that.

> 3. Related, we might want to change the compile option for some program
> (e.g., load_policy and checkpolicy) so they're statically linked.  This
> not only removes the potential threat of intercepting their linking
> process, but also allows us to remove the shared libraries as another
> type of file that can be read.

Also if you make a mistake in labelling or policy such that you can't load 
shared objects it would be good to be able to run setfiles, load_policy, 
checkpolicy, etc.  (yes I know such things should never happen - but I've 
seen it too many times).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
