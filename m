Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TBiqrT014466
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 07:44:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TBhmnY000864
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 11:43:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: policy for timidity
Date: Wed, 29 Sep 2004 21:44:47 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040926202033.GB2529@jmh.mhn.de>
In-Reply-To: <20040926202033.GB2529@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409292144.47950.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 06:20, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> Timidity can be used as alsa sequencer client and run as a daemon (when
> started as timidity -iA). Attached policy allows this to work on a
> SELinux system.

allow timidity_t tmpfs_t:file { read write };

That is wrong.  Should be tmpfs_domain(timidity).

Also for the unix_stream_socket access I think that there's no reason not to 
use create_stream_socket_perms access.

Apart from that it's fine and I've put it in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
