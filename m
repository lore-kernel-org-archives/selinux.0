Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PBOJrT004487
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 07:24:19 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PBOFuQ004516
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 11:24:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: policy mods for xfs (to support xfstt and xfs-xtt)
Date: Wed, 25 Aug 2004 21:24:12 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823232812.GB12720@lkcl.net>
In-Reply-To: <20040823232812.GB12720@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cbHLBn9G0OGFtxD"
Message-Id: <200408252124.12152.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_cbHLBn9G0OGFtxD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

What is /usr/bin/xfs-xtt?  Contents-i386.gz doesn't list it.

+allow xfs_t { etc_runtime_t }:dir { getattr search };

There should not be a directory of type etc_runtime_t (there is no 
file_contexts entry for it).

What is /var/cache/xfstt?  The name implies that xfs would write to it, in 
which case fonts_t is not the appropriate type label.  Changing the policy to 
allow xfs_t to write to fonts_t changes the way things work.  I think that we 
probably need different types for read-only files and writable files.

I've put a few things from your patch in my tree and attached the relevant 
files in a tgz so we can work from the same base.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_cbHLBn9G0OGFtxD
Content-Type: application/x-tgz;
  name="xfs.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="xfs.tgz"

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

--Boundary-00=_cbHLBn9G0OGFtxD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
