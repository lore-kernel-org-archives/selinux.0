Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HEiXvh025418
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 10:44:33 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HEiVbS005510
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:44:32 GMT
Date: Tue, 17 Jul 2007 10:44:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
In-Reply-To: <1184594240.5860.5.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0707171025160.5764@d.namei>
References: <1184594240.5860.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Jul 2007, Mimi Zohar wrote:

> This is a first attempt to verify and measure file integrity, by
> adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> We are planning on posting the corresponding LIM and IMA patches to
> LKML, but would like comments/suggestions here first, particularly
> in regards to the policy checking code in selinux_measure() called 
> from selinux_inode_permission().

Can you please post the integrity code being called? (Perhaps I missed it, 
or should we look at your older patches?)

One general issue is that I think there's a related need to be able to 
cryptographically bind security labels to objects to protect against 
inappropriate offline manipulation with or without the availability of 
TPM.  This is a potentially complex area, and I would not expect that you 
address it directly, although I think it should be taken into 
consideration, and that the integrity framework be capable of greater 
generalization.

There are also potentially more (or at least, extended) models for 
integrity measurement & verification, e.g. verifying code at any point 
during execution.

Also, how do you see this being used in a practical, general purpose 
sense?  How would we convince, e.g. the Fedora project to adopt and 
support this ?

Example use-cases for general corporate or personal users would certainly 
be useful.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
