Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LCkCWt026144
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 08:46:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LCjxIS017563
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:45:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9LCjxDc017560
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:45:59 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310211052.28494.russell@coker.com.au>
References: <200310200148.15852.russell@coker.com.au>
	 <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
	 <200310211052.28494.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066739557.27065.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 08:32:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On a related note, someone else pointed out via private email that
initramfs could be used with 2.6 for the initial policy load, and this
wouldn't require any bootloader support.  That would avoid the legacy
bootloader problems while still preserving the desirable aspects of an
early policy load.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
