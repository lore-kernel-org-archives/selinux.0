Date: Mon, 28 Mar 2005 14:27:46 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Ivan Gyurdiev <ivg2@cornell.edu>, <dwalsh@redhat.com>,
   <selinux@tycho.nsa.gov>
Subject: Re: [ PATCH ] hal - create netlink socket
In-Reply-To: <1112029488.2914.103.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0503281427160.4150-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Mar 2005, Stephen Smalley wrote:

> NETLINK_KOBJECT_UEVENT, which is used by lib/kobject_uevent.c.  Looks
> like it is purely a kernel-to-userspace notification mechanism, so we
> might want a separate class for it to allow access to such notifications
> but we don't need any nlmsg_read/write checking for it.  James, what do
> you think?


Agreed, add a new class but we don't need to look inside the messages.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
