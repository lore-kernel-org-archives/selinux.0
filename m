Subject: Re: [ PATCH ] hal - create netlink socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1112029334.3350.2.camel@cobra.ivg2.net>
References: <1111905173.3520.8.camel@cobra.ivg2.net>
	 <1112016475.2914.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1112026129.3040.1.camel@cobra.ivg2.net>
	 <1112026381.2914.95.camel@moss-spartans.epoch.ncsc.mil>
	 <1112029334.3350.2.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 12:04:48 -0500
Message-Id: <1112029488.2914.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 12:02 -0500, Ivan Gyurdiev wrote:
> > Ah, we don't get the desired information because it is being passed by
> > address for the socketcall multiplexer.  Maybe run hald under strace (in
> > permissive mode, of course).
> 
> Does this help?
> 
> socket(PF_NETLINK, SOCK_DGRAM, 15)      = 7

Yes.  Per include/linux/netlink.h, protocol 15 is
NETLINK_KOBJECT_UEVENT, which is used by lib/kobject_uevent.c.  Looks
like it is purely a kernel-to-userspace notification mechanism, so we
might want a separate class for it to allow access to such notifications
but we don't need any nlmsg_read/write checking for it.  James, what do
you think?  In the meantime, you can allow hald access to netlink_socket
in the policy, but we'll ultimately want to replace that with a finer-
grained rule once the new class is in place.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
