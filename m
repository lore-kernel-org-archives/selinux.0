From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <JBrindle@snu.edu>,
   SELinux@tycho.nsa.gov
Subject: Re: is_selinux_enabled in fileutils
Date: Mon, 29 Sep 2003 23:47:04 +1000
References: <sf7751ab.035@atlas.snu.edu> <3F7823FA.2070702@redhat.com>
In-Reply-To: <3F7823FA.2070702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309292347.04845.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Sep 2003 22:22, Daniel J Walsh wrote:
> if selinux
> setfscreatecon
> output file
> setxattr
> else
> output file

Of course there are some potential issues if the machine crashes at this 
point.  However if you are running a SE Linux machine in non-SE mode then you 
probably have bigger problems than this.  Also the old SE Linux with 
the ...security directory had problems like this on unexpected crashes, and 
I'm not sure that the use of XATTR's will solve this problem.

> setxattr
> end

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
