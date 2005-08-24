Message-ID: <36282A1733C57546BE392885C06185920572F2@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "'Stephen Smalley '" <sds@tycho.nsa.gov>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Cc: "'Daniel J Walsh '" <dwalsh@redhat.com>,
   "'SE Linux '"
	 <selinux@tycho.nsa.gov>
Subject: RE: Ok I plead ignorance to the way MLS works.
Date: Wed, 24 Aug 2005 15:11:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
The kernel should be treated as a system high process and everything it does
as system high. I think making the kernel system low is bad because the
kernel shouldn't need overrides to access data and objects it has direct
access to.

-Chad


-----Original Message-----
From: Stephen Smalley
To: Darrel Goeddel
Cc: Daniel J Walsh; SE Linux
Sent: 8/24/2005 12:56 PM
Subject: Re: Ok I plead ignorance to the way MLS works.

On Wed, 2005-08-24 at 11:44 -0500, Darrel Goeddel wrote:
> I think you would want to run the kernel would at s0:c0.c127.
> Then, do a "range_transition kernel_t init_exec_t s0" to get the whole
> of userspace started off with no categories present.

Why not just have the kernel start out at s0 (no categories), and just
give its domain the necessary attributes to override MLS?  Then you
don't need to transition at all.  Otherwise, you also have to deal with
any other kernel-invoked helpers, e.g. hotplug.

> I'm sure about the compilation error, I did a similar statement with a
> toolchain that is are pre-modules - that worked.  I'm updating an FC4
box
> now so I at least have something up-to-date.

I just tried adding the range_transition listed by Dan to a policy.conf
and rebuilding with checkpolicy -M (latest cvs), and it worked for me.
But note that s0 - s0 is unnecessary; it is the same as just s0.  The
high level defaults to the low level if it isn't specified.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
