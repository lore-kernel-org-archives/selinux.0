Date: Fri, 17 Jun 2005 12:08:17 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: horietk@nttdata.co.jp, <selinux@tycho.nsa.gov>
Subject: Re: [RFC]Kernel Built-in IDS extension
In-Reply-To: <1119013351.12524.81.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0506171203270.2902-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Jun 2005, Stephen Smalley wrote:

> Did you consider a userspace implementation, e.g. extend auditd to match
> against avc messages it receives from the kernel (likely using a
> libsepol function to perform the matching), and then having auditd

Why limit the input to the IDS to AVC messages?  There are many ways of
collecting attack signatures, and not necessarily even from the local 
system.

And yes, this definitely does not belong in the kernel.

Also see http://personal.utulsa.edu/~brandon-pollet/DynamicPolicy-BP.pdf


- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
