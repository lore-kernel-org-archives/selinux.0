Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LDucWt026849
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 09:56:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LDuQIS023453
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:56:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9LDuNDc023445
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:56:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>
Subject: Re: init patch for loading policy
Date: Tue, 21 Oct 2003 23:56:32 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310200148.15852.russell@coker.com.au> <200310211052.28494.russell@coker.com.au> <1066739557.27065.43.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066739557.27065.43.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310212356.32110.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2003 22:32, Stephen Smalley wrote:
> On a related note, someone else pointed out via private email that
> initramfs could be used with 2.6 for the initial policy load, and this
> wouldn't require any bootloader support.  That would avoid the legacy
> bootloader problems while still preserving the desirable aspects of an
> early policy load.

For the long term this is probably the best solution.  It avoids all the 
hackery we are going through now, and has no down-side.

I will clean up my initrd-policy for release then.  For the policy needed to 
get to the stage of running init and letting it load a proper policy to do 
the rest I can probably get it to below 100K uncompressed (probably <20K 
compressed).

My last experiments were at about 300K uncompressed, but that was for having 
the real SE Linux policy loaded from a script under /etc/rc.d/rc5.d.  So I 
had to have policy for updfstab, fsck, and lots of other things.  All that 
policy raised the potential for changes and also made the policy big.  Having 
the bare minimum for init_t and initrc_t will make it much smaller and a good 
candidate for linking in the kernel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
