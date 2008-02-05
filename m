Subject: Re: segfault in checkpolicy stable
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1202238014.27371.83.camel@moss-spartans.epoch.ncsc.mil>
References: <1202236461.7533.55.camel@gorn>
	 <1202238014.27371.83.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 14:02:26 -0500
Message-Id: <1202238146.27371.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-05 at 14:00 -0500, Stephen Smalley wrote:
> On Tue, 2008-02-05 at 13:34 -0500, Christopher J. PeBenito wrote:
> > With all of the newest stable userland:
> > 
> > libsepol-1.16.10
> > libselinux-1.34.14 
> > libsemanage-1.10.9
> > checkpolicy-1.34.4
> > 
> > I'm getting a segfault in checkpolicy.
> > 
> > Compiling refpolicy policy.21
> > /usr/bin/checkpolicy policy.conf -o policy.21
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > make: *** [policy.21] Segmentation fault
> > 
> > 
> > Steps to reproduce:
> > 
> > 1. check out refpolicy trunk
> > 2. # make conf
> > 3. # make policy
> 
> Thanks, should be fixed in libsepol 1.16.11.

Note that you'll need to rebuild checkpolicy against it since it uses
the static lib.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
