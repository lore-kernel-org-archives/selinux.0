Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBREtmIi017854
	for <selinux@tycho.nsa.gov>; Mon, 27 Dec 2004 09:55:48 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBRErvTv001749
	for <selinux@tycho.nsa.gov>; Mon, 27 Dec 2004 14:53:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Yee-HAH! 'smartd' issues 70 avc's when it tries to send mail...
Date: Tue, 28 Dec 2004 01:55:37 +1100
Cc: Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov
References: <200412032012.iB3KCjaT030175@turing-police.cc.vt.edu> <200412071650.iB7GoSQs014629@turing-police.cc.vt.edu> <200412080203.iB823Mhd023488@turing-police.cc.vt.edu>
In-Reply-To: <200412080203.iB823Mhd023488@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412280155.40742.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 08 December 2004 13:03, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 07 Dec 2004 11:50:27 EST, Valdis.Kletnieks@vt.edu said:
> > I'm wondering if it would make more sense to push a patch upstream to the
> > kernel-utils crew.  Reading the smartd manpage in more detail, it looks
> > like feeding it a '-M exec /usr/sbin/sendmail' (or building with that as
> > the default) would let us only have to add sendmail_exec_t rather than
> > all those.
>
> Or that *would* work, if the smartd code didn't use popen() to actually run
> it, giving us a gratuitous '/bin/sh -c'.  Looks like some fairly hefty
> reworking to make it do the whole pipe()/fork()/exec() thing itself.

In spite of what Colin says I think it would be good to get such a change in 
smartd.

There are other benefits too.  Imagine that we get a bad sector on the part of 
disk that contains /bin/bash or one of the many shared objects it uses.  
Bummer if this causes smartd not to do anything and this delay in 
notification causes the administrator to lose other data as the hard disk 
slowly dies.

Another issue is that hard disk errors are probably more likely than average 
in times of high disk load.  Anything that you can do to reduce the disk use 
in performing an operation at such times will give a faster result.  NB Linux 
tends to give very long delays on file read or process execute if there is a 
large write queue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
