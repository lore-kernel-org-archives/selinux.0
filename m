Subject: Re: Another change we would like to make to libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux
 <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <4F44EEEF.8090506@redhat.com>
References: <4F3D16EF.6080904@redhat.com>
	 <1329857024.12501.85.camel@moss-pluto> <4F44114F.4080005@redhat.com>
	 <4F44ED53.5040807@tresys.com>  <4F44EEEF.8090506@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Feb 2012 09:08:21 -0500
Message-ID: <1329919701.15569.20.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-02-22 at 08:34 -0500, Daniel J Walsh wrote:
> Well I see for multiple reasons.
> 
> One the stupid algorithm for finding what was the currect policy to
> read was spreading to multiple tools places.  (setools,
> sepolgen-ifgen, load_policy, audit2why, each one doing it slightly
> differently.

So that's an argument for providing an interface that gives that full
pathname of the policy file, not for using the kernel policy file by
default.  BTW, we could likely have libsemanage create a symlink
from /etc/selinux/$SELINUXTYPE/policy/policy to the policy.N file it
just created.  And then you could just always use that pathname.

> We had apps like setroubleshoot that are trying to analyze the policy
> at the time that an AVC happened and potentially analyzing a different
> policy.  (Theoretically try for audit2allow/audit2why also.)

I don't quite understand why that would happen, except for transient
boolean changes, and how often do those occur these days?

> sepolgen-ifgen was not figuring out the correct policy to analyze if
> policy.27 was installed but the kernel was looking at policy.26

How did that happen?  If policy.27 exists and libsepol supports policy
version 27, then load_policy will use policy.27 and downgrade it in
memory before loading into the kernel.  It will not use the policy.26
file.

> We had the ability to analyze the loaded policy and no one was using it.

The only reason we added the kernel policy pseudo file was to support
checking that the loaded kernel policy matched the one on disk.

> I hate the algorithm for finding the path to the policy on disk.  And
> would rather only expose it to one tool load_policy.

This is the same as the first one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
