Subject: Re: [patch 0/2] policy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: tmiller@tresys.com, selinux@tycho.nsa.gov, method@manicmethod.com,
        dwalsh@redhat.com, cpebenito@tresys.com, kmacmillan@mentalrootkit.com
In-Reply-To: <200801081205.25197.paul.moore@hp.com>
References: <20071206213852.083412876@tresys.com>
	 <200801081205.25197.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 14:01:37 -0500
Message-Id: <1199818897.9393.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-01-08 at 12:05 -0500, Paul Moore wrote:
> On Thursday 06 December 2007 4:38:52 pm tmiller@tresys.com wrote:
> > Updated policycap patch set based on recent discussion.  The
> > consensus seems to be to only allow policycaps in the base module. 
> > This is now enforced by the checkpolicy/checkmodule parser.
> 
> I haven't heard much about this patch lately - what is the current 
> status?  I know Stephen had some minor comments but other than that I 
> didn't see any objections ...

It was merged.  checkpolicy 2.0.7 and libsepol 2.0.18.
But you now need a base module re-built with the capabilities defined.
So we need to get a policy patch that does that if/when we are ready to
turn on the new networking controls for real.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
