Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8DBt6La001461
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 07:55:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8DBrRLY007529
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 11:53:27 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8DBrQsG007526
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 11:53:27 GMT
Date: Sat, 13 Sep 2003 12:55:03 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030913115503.GB16830@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've got it sorted and the answers may be useful to
others. 

1) Don't enable BOTH cramfs and romfs if you are
   using romfs for your initrd image. initrd seems
   to default to cramfs if it is in the kernel.
   This was very unobvious from the error output.

2) Make sure you enable the shm pseudo file system
   so that tmpfs exists.

I'll try to find some time to write up the details
of getting initrd running on a 2.6.0 kernel under
a Debian dist. 

First I've got a *&^%$ load of avc's. And I still
have to prove my attribute handler kernel patch
works.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
