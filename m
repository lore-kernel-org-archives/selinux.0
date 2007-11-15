Subject: Re: [Fwd: type class key]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
In-Reply-To: <26342.1195138409@redhat.com>
References: <473B5928.6090800@redhat.com>
	 <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1194628263.3630.14.camel@vogon>
	 <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil>
	 <24708.1194612682@redhat.com> <22421.1194637689@redhat.com>
	 <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil>
	 <24415.1194697577@redhat.com>   <26342.1195138409@redhat.com>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 09:56:49 -0500
Message-Id: <1195138609.18480.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-15 at 14:53 +0000, David Howells wrote:
> Daniel J Walsh <dwalsh@redhat.com> wrote:
> 
> > David, we need a method of querying the keyring to see what the selinux
> > context that is associated with it.  For debugging purposes.  Currently
> > we can not tell whether the policy is correct or not, since we have no
> > way to ask the keyring for its label.
> 
> Does it need to be accessible from kernel space?  Can I pass a userspace
> buffer pointer through to the LSM?

Yes to the first (likely will be wanted for audit eventually), no to the
second (preferably).  getprocattr and inode_getsecurity deal only with
kernel buffers themselves.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
