Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3DJuRb021085
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 08:19:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB3DJtqY013949
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 13:19:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB3DJt0o013946 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 13:19:55 GMT
Subject: Re: machine check exception
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Nicholas Mucci <nmucci@eecs.ku.edu>, selinux@tycho.nsa.gov
In-Reply-To: <200312040005.54935.russell@coker.com.au>
References: <20031203043334.S1461@tesla.eecs.ku.edu>
	 <200312040005.54935.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070457587.16049.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Dec 2003 08:19:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-12-03 at 08:05, Russell Coker wrote:
> Does this only happen when running SE Linux?  What happens when SE Linux is 
> compiled in but not enabled (boot with selinux=0)?  What happens when SE 
> Linux is not compiled in?
> 
> If the problem occurs when SE Linux is not compiled in to the kernel then it 
> is something that is best discussed on the linux-kernel mailing list.

I'd also suggest using a more modern SELinux kernel, e.g. the kernel
RPMs from under http://people.redhat.com/arjanv/2.5.  Latest is
2.6.0-0.test11.1.99

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
