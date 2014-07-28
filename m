Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6S9Dhau020225
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 05:13:43 -0400
From: "Andy Warner" <warner@rubix.com>
To: "'Dominick Grift'" <dominick.grift@gmail.com>,
 "'selinux'" <selinux@tycho.nsa.gov>
References: <1406536400.32528.7.camel@x220.localdomain>
In-Reply-To: <1406536400.32528.7.camel@x220.localdomain>
Subject: RE: do user space object managers really provide mandatory access
 control
Date: Mon, 28 Jul 2014 11:13:41 +0200
Message-ID: <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

MAC is usually defined as not being discretionary (it is mandatory). That
is, the enforcement of the policy is not at the discretion of a user or
owner. In my experience it is not defined as "being enforced by the kernel."
Generally MAC also implies (and sometimes demands) implementation principles
like encapsulation and non-bypassibility, which a kernel based
implementation might satisfy, but it is not a requirement of MAC to be
implemented in the kernel.

I work in MAC based DBMS's which from your perspective could just be
considered an application layer, but it is implementing real MAC.  One
reason it cannot be totally implemented in the kernel is that the MAC is
arbitrating access to non-OS objects, such as database rows, tables, etc.
The DBMS can cooperate with the kernel and use the kernel for MAC based
decisions (if the MAC policy objectives are the same) but it cannot be
totally implemented in the kernel. At least, not without lots of tricky
theoretical work, which was my research topic years ago in grad school.
Enforcement of the policy is a key difficult issue. 

-----Original Message-----
From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Dominick
Grift
Sent: Monday, July 28, 2014 10:33 AM
To: selinux
Subject: do user space object managers really provide mandatory access
control

I admit that my knowledge of this leaves much to be desired but i will ask
anyway:

If one defines mandatory as "enforced by the kernel", then do user space
object managers provide mandatory access control?

from my understanding user space object managers enforce security decisions
made by the Linux security server.

So can a compromised user space object manager ignore these security
decisions made by the Linux security server?

In other words are user space object manager really a way to enforce MAC or
are they just another application layer access control when push comes to
shove.

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
