Subject: Re: [Fwd: type class key]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
In-Reply-To: <26106.1195137716@redhat.com>
References: <1195135075.18480.10.camel@moss-spartans.epoch.ncsc.mil>
	 <473B5928.6090800@redhat.com>
	 <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1194628263.3630.14.camel@vogon>
	 <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil>
	 <24708.1194612682@redhat.com> <22421.1194637689@redhat.com>
	 <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil>
	 <24415.1194697577@redhat.com> <363.1195129061@redhat.com>
	 <26106.1195137716@redhat.com>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 09:52:24 -0500
Message-Id: <1195138344.18480.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-15 at 14:41 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > It's a string.  As an example, see the security_inode_getsecurity() LSM
> > hook and selinux_inode_getsecurity() implementation of it.
> 
> Yeah...  That's along the lines of what I was thinking of.
> 
> > But note that the interface has changed in -mm to avoid the need to pass in
> > an already appropriately sized buffer.
> 
> I'm not sure what you mean by that.  Do you mean the buffer has to be exactly
> the right size?

Previously, the caller had to supply a buffer large enough for the
context string, and the hook copied into that buffer.  In -mm, the hook
allocates an appropriately sized buffer and returns the pointer to it to
the caller.

http://marc.info/?l=linux-fsdevel&m=119392810506870&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
