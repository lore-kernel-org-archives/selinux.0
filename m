Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7THBILa027589
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 13:11:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7TH9mpQ021482
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 17:09:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h7TH9mQX021478
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 17:09:48 GMT
Subject: Re: Q on Internals & Data Structures
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200308291222.23424.wlsel@verizon.net>
References: <200308291222.23424.wlsel@verizon.net>
Content-Type: text/plain
Message-Id: <1062177075.5432.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Aug 2003 13:11:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-29 at 12:22, Bill Laut wrote:
> I'm beginning work on my first experimental implementation of a security-aware 
> X, using the paper "Securing the X Window System with SELinux" 
> [KilSalVanNAI2003] as a guide.  To facilitate this, I would like to prepare 
> an informal reference document that schematically charts all of the kernel 
> data structures used within SELinux, along with a chart tracing the execution 
> thread of the security services from start to finish.  Of particular interest 
> is the format of the compiled policy as it sits in the kernel, and how it is 
> interrogated to arrive at a yes/no decision.
> 
> Has any documentation of this sort been created, and if so where can I find 
> it?  I already have "Configuring the SELinux Policy" and "Implementing 
> SELinux as a Linux Security Module," but while good they are not what I'm 
> looking for.

The Integrating Flexible Support... technical report (not to be confused
with the conference paper of the same name) is out of date, but you can
still glean quite a bit of useful information from it.  It described the
original SELinux implementation, and remains the only description of
certain aspects of the system.  The Flask architecture background paper
describes the security architecture and how the components interact, but
not at the level of detail you may want.

You don't actually need to re-invent the base security services, as the
modified X server can simply invoke the security policy API exported by
the kernel (and wrapped by libselinux).  But you will ultimately need
the following supporting components:

1) A userspace access vector cache (AVC), likely as an addition to
libselinux.  This can be a trivial port of the kernel AVC code, adapting
it to use the security policy API functions already provided by
libselinux to interact with the kernel security server.  The major
missing element is a notification interface from the kernel security
server to flush userspace AVCs upon policy changes, but that isn't
critical to basic operation.

2) Extensions to the socket API so that the X server can obtain the
security contexts of clients.  The overhaul of the SELinux API for
mainline integration caused us to lose our extended socket calls, so we
do not presently have an interface for that purpose.  To be accepted
into the mainline, the API extensions would need to be more consistent
with existing kernel interfaces, e.g. a SCM_CREDENTIALS control message
for sendmsg/recvmsg or a new option for getsockopt rather than extended
versions of the base socket calls.

We would likely implement the notification interface for the userspace
AVC and the socket API extensions ourselves if there were someone
helping to drive the requirements for them.  Their current absence is
mostly a reflection of the lack of any users for them.  The X server
modifications could be done in parallel, with some scaffolding until the
supporting components were ready.

Are you just working on this yourself, or as part of a larger project?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
