Subject: Re: FIrst pass at genhomedircon patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43724F25.1000502@redhat.com>
References: <43724F25.1000502@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 15:31:48 -0500
Message-Id: <1131568308.20591.591.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 14:33 -0500, Daniel J Walsh wrote:
> This is just using the seusers file and will use the python bindings 
> when they are available.
> Just truncating off the _u and using this as the role, for now
> 
> No longer using users.local, system.users and also removed backwards 
> compatibility with FC3.

It ends up not including anything for /root, so /root is then reset to
default_t.  Naturally, you can't just use the same approach for root
since he is mapped to SELinux user root in the policy, so you need
special handling there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
