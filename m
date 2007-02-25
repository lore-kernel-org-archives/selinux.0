From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: I think this is equivalent to what we have =?utf-8?q?now=09and=09more=09efficient=2E?=
Date: Sun, 25 Feb 2007 14:36:38 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <45DDAA80.80603@redhat.com> <200702221156.49050.sgrubb@redhat.com> <1172234092.14363.468.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172234092.14363.468.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702251436.38681.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 23 February 2007 07:34:52 Stephen Smalley wrote:
> Do we want to use this or just use fgets_unlocked?
>
> I'd prefer to convert all uses of fgets* to getline and let glibc handle
> the allocations; we are already performing allocation on that code path
> (just prior to the loop),

I had already created a patch assuming we wanted to go with fgets where it 
used a stack variable to avoid the overhead of malloc/free. In the case of 
scanning /proc/filesystems, you can expect it to be well behaved since its 
controlled by the kernel. However, in the case of scanning /proc/mounts, you 
have to be very careful. Someone could create a path that is close to 
PATH_MAX in size.

> and getline can handle it more intelligently and dynamically based
> on the actual sizes.

I think the underlying mechanism is about the same for these two cases.

> Ulrich originally introduced  use of getline into libselinux and converted
> some functions, so remaining cases of fgets* are legacy.

That was to avoid having to do strlen after receiving the buffer more than 
anything else. Getline saves us in that respect. I'll re-code the patch with 
getline so its consistent.

> So I suppose we need to retain the getcon() test.  Or institute a more
> direct test of whether policy is loaded, e.g. new selinuxfs node that is
> accessible to all so that it can always be read to see whether policy
> has been loaded.

What about /selinux/policyvers ? When selinux is disabled, it does not exist. 
When its enabled, should it tell you the version of policy that was 
successfully loaded?

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
