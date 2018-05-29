To: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>
References: <e5db3333-4185-c009-6faf-4136757f829d@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <213ba37b-6726-d9d5-9202-ce02940c3cf7@tycho.nsa.gov>
Date: Tue, 29 May 2018 14:28:52 -0400
MIME-Version: 1.0
In-Reply-To: <e5db3333-4185-c009-6faf-4136757f829d@debian.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: fixfiles and load_policy moved from /sbin to /usr/sbin
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/29/2018 11:19 AM, Laurent Bigonville wrote:
> Hello,
> 
> While packaging policycoreutils 2.8 I've seen that the fixfiles and load_policy executables were moved from /sbin to /usr/sbin
> 
> Any reasons for this? This seems to me like an involuntary side effect of the cleanup for DESTDIR and PREFIX in the build system.
> 
> For distribution with usr-merge that will not change anything, but for others that could prevent early boot scripts to load the policy
> 
> Shouldn't that be reverted?

Yes, I think that was an oversight.  However, generally policy loading is handled directly by init (both sysvinit and systemd) via libselinux w/o executing the load_policy executable, and libsemanage checks both locations for it, so I wouldn't expect policy loading to be broken.  fixfiles invocation from init scripts may be a different matter.  Likely should revert the location change for both (but not the rest of DESTDIR/PREFIX fixes).
