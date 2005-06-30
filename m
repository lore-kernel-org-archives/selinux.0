Subject: Re: RFC: jail functionality
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Colin Walters <walters@verbum.org>
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
   linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1120137574.4524.70.camel@nexus.verbum.private>
References: <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0506291402040.12494-100000@thoron.boston.redhat.com>
	 <20050629184224.GC19299@serge.austin.ibm.com>
	 <1120137574.4524.70.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:23:11 -0400
Message-Id: <1120137791.11798.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 09:19 -0400, Colin Walters wrote:
> But you should be aware that for a lot of the zone use cases, resource
> management is very important, and SELinux doesn't provide that.  You
> mention CKRM, but that's a whole other kernel patch.  Xen definitely
> seems to be the approach that's winning here.

IMHO, CKRM should be integrated with SELinux to allow policy control
over resource management.

For strict isolation (which does seem to be the theme of jail) as well
as complete transparency of that isolation, virtualization make sense.
But for controlled sharing, you will ultimately need OS-level controls.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
