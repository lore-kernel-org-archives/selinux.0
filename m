Subject: Re: Removing DAC.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cinthya aranguren <cinthya.aranguren@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 08:20:41 -0400
Message-Id: <1206361241.3302.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2008-03-23 at 12:54 -0300, cinthya aranguren wrote:
> Hi,
> 
> Is there any way to avoid o remove DAC controls ? I'd like to have
> only one security scheme in my system. I mean a pure SElinux system.
> not DAC + MAC. only MAC.

Not recommended - see prior discussions on this list.

Russell Coker has run SELinux systems with published root password
before, which approximates the above, but only for demonstration
purposes - I wouldn't recommend that for production use.

If you really wanted to do it, you'd need to patch and build your own
kernel.  Options there include:
1) Drop out capabilities altogether - just remove the secondary_ops
calls from the SELinux module.  That makes SELinux always authoritative
on capable() calls.  In which case you better make sure that your policy
is configured very tightly.
2) Use the authoritative capabilities patch I posted last summer.  That
makes SELinux selectively authoritative on capable() calls when you add
new allow rules on the cap_override class, so it has no immediate impact
but you can gradually convert over to having SELinux grant capabilities.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
