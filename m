Date: Mon, 1 Oct 2001 10:12:46 -0400 (EDT)
From: Steve Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux@tycho.nsa.gov
Subject: Re: distribution of kernel patches
In-Reply-To: <Pine.SOL.3.95.1011001081954.24962B-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.SOL.3.95.1011001100634.95A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 1 Oct 2001, Stephen Smalley wrote:
> So, you want a new download option that consists of:
> 1) A "pure" LSM kernel patch relative to some snapshot from lsm.immunix.org,
> 2) A SELinux kernel patch that modifies the LSM security/{Makefile, 
> Config.in} and that drops the SELinux kernel module into
> security/selinux_plug, and 
> 3) A SELinux archive that contains everything except the module 
> subdirectory, plus an alternate README for this situation?

Actually, you probably want #3 to just be the SELinux small archive from
Download Option 4 without the kernel module (i.e. the example policy
configuration, the setfiles utility and file_contexts configuration, and
the new utility programs).  For the modified daemons and utilities, you
probably just want the individual patches provided under Option 4, but you
will need to adapt them to the corresponding Debian daemons and utilities,
since we used RedHat as our base platform.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
