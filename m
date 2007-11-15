Subject: Re: [Fwd: type class key]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
In-Reply-To: <363.1195129061@redhat.com>
References: <473B5928.6090800@redhat.com>
	 <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1194628263.3630.14.camel@vogon>
	 <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil>
	 <24708.1194612682@redhat.com> <22421.1194637689@redhat.com>
	 <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil>
	 <24415.1194697577@redhat.com>   <363.1195129061@redhat.com>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 08:57:55 -0500
Message-Id: <1195135075.18480.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-15 at 12:17 +0000, David Howells wrote:
> Daniel J Walsh <dwalsh@redhat.com> wrote:
> 
> > David, we need a method of querying the keyring to see what the selinux
> > context that is associated with it.  For debugging purposes.  Currently
> > we can not tell whether the policy is correct or not, since we have no
> > way to ask the keyring for its label.
> 
> That's probably easy enough.  What form does a context take?

It's a string.  As an example, see the security_inode_getsecurity() LSM
hook and selinux_inode_getsecurity() implementation of it.  But note
that the interface has changed in -mm to avoid the need to pass in an
already appropriately sized buffer.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
