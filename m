Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i13JCeRb007693
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 14:12:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i13JCd1I004435
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 19:12:39 GMT
Received: from butternut.transitive.com (dsl-217-207-128-218.uk.easynet.net [217.207.128.218] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id i13JCdbs004432 for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 19:12:39 GMT
Message-ID: <401FF280.8070301@treblig.org>
Date: Tue, 03 Feb 2004 19:12:00 +0000
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problems finding working kernel/user land combination
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
   I've been following the document 'Getting Started With SE Linux 
HOWTO' by Faye Coker (12 March 2003) and am having problems. Any help 
much appreciated.

I'm using Debian Woody and the 'stable' set of tools from Brian May 
(www.microcomaustralia.com.au)

If I build the latest NSA kernel source the user land tools don't 
recognise that SELinux is in the kernel:

id -c :

Sorry, --context (-c) can be used only on a flask-enabled kernel.

yet the boot messages contain:

SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized


which I've read is normal behaviour (is it?)

An strace of 'id' shows:

SYS_223(0xf97cff8c, 0xc, 0, 0x400135cc) = -1 ENOSYS (Function not 
implemented)

There is an selinuxfs that I can mount and I can see files
'access  context  create  enforce  load  policyvers  relabel  user'
but they give invalid argument if I try and cat them.

I have:

CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y

-----------------------

OK - so that doesn't work; and I'm thinking I need to try a different 
kernel patch set.
So I download the patches from www.coker.com.au/newselinux/kern

and after battling through adding the ea, acl and nfsacl patches
I then patch the coker lsm patches on.

This has two problems:
   1) A minor reject in tcp_ipv4.c that appears easy to fix
   2) Line 666 (gulp!) of ip_output.c has:

   security_ip_fragment(skb2, skb);

   but there doesn't appear to be an skb2 in that context.

------------------------

So in short; does anyone have a known good set of kernel patches that 
actually work, or a set of userland tools for Debian/stable that work 
with the NSA kernel?

Thanks in advance,

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
