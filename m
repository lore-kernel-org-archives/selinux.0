Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA29320
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 04:02:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2392FI04109
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 09:02:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h2392Ef04105 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 09:02:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux and ReiserFS
Date: Sat, 1 Mar 2003 18:58:13 +0100
Cc: "Sherman Boyd" <ShermanB@clh.com>
References: <D17BA970DE186447AD8A5A2A117C2C1503E00E@bulbasaur.internal.clh.com> <200303011015.35871.russell@coker.com.au> <20030301123458.5ff03d00.fw@fwsystems.com>
In-Reply-To: <20030301123458.5ff03d00.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303011858.13333.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 1 Mar 2003 18:34, forrest whitcher wrote:
> Presently, as russell indicates ext[23] and reiserfs are coded into the
> policy and scripts. I have done test installations using JFS and found
> that PSID's seem to work fine, JFS developers assert that there are no
> plans to change the inode semantics.

I think that sounds like a good justification for including a JFS entry in the 
default policy.

Is it's identifier just "jfs"?  I'll put it in the next release of my policy 
tree.

> BTW, as JFS is now incorporated into the mainline kernel it'd be
> great to see that incorporated into the SEL patches (maybe it already
> is, I'm still working with the 2.4.19 SEL kernel).

Also it would be good if someone did some tests with XFS.  XFS is the other 
major file system that's getting used at the moment.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
