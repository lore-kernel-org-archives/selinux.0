Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h445cTI4023032
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 01:38:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h445cGVf021685
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 05:38:16 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h445cE4D021682
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 05:38:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Richard Troth <rtroth@bmc.com>
Subject: Re: SE Linux on Familiar
Date: Sun, 4 May 2003 15:37:25 +1000
Cc: selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0305031407050.11631-100000@trothnec.bmc.com>
In-Reply-To: <Pine.LNX.4.44.0305031407050.11631-100000@trothnec.bmc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305041537.25098.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 4 May 2003 05:07, Richard Troth wrote:
> With memory so tight on a device like that,
> how much did this increase the size of the system?   (abs and rel)

I haven't done a detailed comparison yet.

The kernel binary increases by about 70K in size when compiled for X-scale 
(other ARM sub-architectures may differ slightly).  I have to check the 
output of "free" to see who much kernel memory is apparently used for the 
code when it's uncompressed.  As for kernel data I am guessing that it will 
be some small multiple of the size of the uncompressed policydb, but I have 
to look into that, it's slightly more difficult to measure, but the output of 
free should again give a good approximation.

Then there's the wrapper programs which take between 6K and 33K of disk space, 
which is not much when compared to the various utility programs that are 
necessary (load_policy, setfiles, chsid, etc).  I plan to add all of them to 
busybox and expect that I can not take more than an extra 30K-40K of disk 
space for it.  The compressed policydb is about 86K at the moment, it will 
reach 90K soon (but I will try to trim it down a bit).  The file_contexts 
file is about 24K, I am not sure whether it's worth trying too hard to reduce 
the size of this as it's less than 5K when compressed.

NB all disk space figures refer to uncompressed file size.  I believe that 
jffs2 compresses all files using the same algorithm as gzip so increasing a 
file by 20K does not necessarily mean that 20/32768 of your storage space is 
used.

For a modern iPaQ the space used by SE Linux is trivial.  When I'm finished 
anything that can usably run Linux should be able to run SE Linux without any 
problems.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
