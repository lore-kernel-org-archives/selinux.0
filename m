Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB681jIi019487
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 03:01:46 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB681joX001331
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 08:01:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: patch: misc policy additions
Date: Mon, 6 Dec 2004 19:01:34 +1100
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20041109210447.GC2543@jmh.mhn.de> <20041127225844.GA2509@jmh.mhn.de> <20041128193712.GA2509@jmh.mhn.de>
In-Reply-To: <20041128193712.GA2509@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412061901.36320.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 29 November 2004 06:37, Thomas Bleher 
<bleher@informatik.uni-muenchen.de> wrote:
> I just looked over it again and realized that tty_file_t doesn't have
> attribute ttyfile. So I agree that it's not very useful. We may want to
> allow relabelfrom (it's already in initrc-policy) so you can say
>         restorecon /dev/tty*
> in an init-script and have it work even if the files hadn't been
> relabeled back (eg because of a crash)
> But I'll leave that for you to decide.

I think that the best solution to this may be to have getty restore the 
context.  This could be done by having a shell script run restorecon before 
running getty or by patching getty to know about SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
