From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: SELinux, KDE, and honeypots
Date: Wed, 9 Jul 2003 19:48:43 +1000
Cc: SELinux@tycho.nsa.gov
References: <200307082303.22083.wlsel@verizon.net> <20030709102025.C30693@lemuria.org>
In-Reply-To: <20030709102025.C30693@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307091948.43838.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jul 2003 18:20, Tom wrote:
> Yes, though if I understand correctly, the kdm patch was never actually
> tested.

The patch for KDE 3.x was never successfully compiled (or not by me anyway).

For KDE 2.x I was using the patch for quite a long time, and there's no reason 
why you couldn't use it today.  You would need a default_context file in 
addition to the default_contexts file, but that's not a serious problem.

Using wdm to login to KDE is also a good option.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
