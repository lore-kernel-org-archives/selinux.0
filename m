Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Steve Smalley <sds@tislabs.com>
Subject: Re: distribution of kernel patches
Date: Mon, 1 Oct 2001 19:49:58 +0200
Cc: SELinux@tycho.nsa.gov
References: <Pine.SOL.3.95.1011001100634.95A-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1011001100634.95A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <20011001174958.61F7B37D943@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Oct 2001 16:12, Steve Smalley wrote:
> For the modified daemons and utilities, you
> probably just want the individual patches provided under Option 4, but you
> will need to adapt them to the corresponding Debian daemons and utilities,
> since we used RedHat as our base platform.

This raises another issue.  It's probably a good idea to ship a copy of the 
un-patched utility programs.

When I first took over Portslave development I had heaps of problems trying 
to identify changes because it was impossible to find a pppd source tree that 
matched the version that Portslave was based on.

Hopefully I won't have the same problems here (at least you presumably have 
the matching upstream source somewhere, and it's too new to have disappeared 
from all the FTP sites yet).  But to save future problems for us it would be 
good to have a copy of the source without the patches.

Also this makes auditing the code easier.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
