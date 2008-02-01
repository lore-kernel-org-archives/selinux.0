Subject: RE: UNCLASSIFIED - Realtime Scheduling...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "HAWKER, Dan 2 (external)" <Dan.HAWKER@uk4.astrium.eads.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7F6B06837A5DBD49AC6E1650EFF5490601C64C1B@auk52177.ukr.astrium.corp>
References: 
	 <7F6B06837A5DBD49AC6E1650EFF5490601C64C1B@auk52177.ukr.astrium.corp>
Content-Type: text/plain
Date: Fri, 01 Feb 2008 10:31:29 -0500
Message-Id: <1201879889.26036.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-31 at 19:03 +0000, HAWKER, Dan 2 (external) wrote:
> 
> > 
> > At present, SELinux acts as an orthogonal mechanism to Linux 
> > discretionary controls, and thus you must be authorized by 
> > both Linux DAC and by SELinux MAC checks to perform any 
> > operation.  So to invoke a call that requires privilege (in 
> > Linux, "capability"), your program has to at least start with 
> > uid 0 in addition to running in a SELinux domain that is 
> > allowed the capability by policy.  The program can shed uid 0 
> > upon startup while retaining certain capabilities; you can 
> > see an example of that in newrole.  If your kernel supports 
> > file capabilities, you could try using that instead of setuid 0.
> > 
> > We have previously proposed a patch to selinux that would 
> > allow it to authoritatively grant a capability to a non-uid-0 
> > process based on policy (see mailing list archives), and we 
> > may proceed with that patch to support that kind of need, but 
> > it isn't in any distro kernels today.
> 
> Hi Stephen,
> 
> Thanks for that, its as I thought. I'll pass on the info to the
> developer.
> 
> Regarding the patch, I see that was back in June 07, (not that far back
> admitedly, but SELinux moves apace), however I presume it *does what it
> says on the tin* and applies simply enough???
> 
> I'll take a look and see how we get on.

I deferred submitting it for mainline because there was a fair amount of
concern from others about the implications of the change, as you can see
from the responses.

Nonetheless, I think it would be a useful feature for certain user
communities, so we should likely re-base and submit it.

It won't apply cleanly against the latest kernel because the class value
I used for it has since been taken for another class.

Unless you are already using a patched kernel for some reason, I think
you'd be better off just using the mechanisms present in your existing
kernel, e.g. make the program setuid, have it shed unnecessary
capabilities and uid 0 at startup, and use policy to protect and confine
it.  See newrole for an example.  Otherwise you have to carry the patch
yourself, deal with any side effects, invalidate any support agreements
you might have with the vendor, etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
