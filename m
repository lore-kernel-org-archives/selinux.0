Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1EDIRb006590
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:13:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1EDCqY005474
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:13:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB1EDC0o005471 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:13:12 GMT
Subject: Re: More mkinitrd setup script problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20031128111439.GA18062@vnl.com>
References: <20031128110536.GE12418@vnl.com>
	 <200311282210.39268.russell@coker.com.au>  <20031128111439.GA18062@vnl.com>
Content-Type: text/plain
Message-Id: <1070287987.12270.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:13:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-28 at 06:14, Dale Amon wrote:
> On Fri, Nov 28, 2003 at 10:10:39PM +1100, Russell Coker wrote:
> > Strange, I would have expected libselinux.so.1 to be needed for quite a while.
> 
> Yes, it is. I was rather surprised to say the least.

load_policy was originally statically linked for the initrd.  When we
transitioned to using Dan's patched init program to perform the initial
policy load, load_policy was switched to being dynamically linked, since
it doesn't need to go onto the initrd.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
