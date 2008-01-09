Subject: Re: UNCLASSIFIED - Developing Policies for SELinux on Embedded
	Systems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "HAWKER, Dan 2 (external)" <Dan.HAWKER@uk4.astrium.eads.net>
Cc: selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Dave Sugar <dsugar@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <7F6B06837A5DBD49AC6E1650EFF5490601C64BEB@auk52177.ukr.astrium.corp>
References: 
	 <7F6B06837A5DBD49AC6E1650EFF5490601C64BEB@auk52177.ukr.astrium.corp>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 11:10:24 -0500
Message-Id: <1199895024.9393.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 15:11 +0000, HAWKER, Dan 2 (external) wrote:
> 
> Hi All,
> 
> Not 100% sure if this is the right list to enquire about this, if not
> can someone point me towards somewhere that might be :)
> 
> Have been tasked with generating a series of SELinux policies for some
> embedded Linux devices we are developing. Naturally, time is not in
> abundance :(
> 
> The target system is a special stripped-down FC4 variant (i386, about
> 80MB footprint), we have developed in-house for our embedded platform
> and runs a custom 2.6.12ish kernel with some modifications for the
> target hardware.
> 
> I planned to start with the base reference policy, strip out the bits we
> don't need (it only runs our own apps plus the minimum to boot) and then
> add policies for our apps. All presuming the relatively old kernel we
> are using can handle the ref policy and subsequent libselinux, etc
> updates of course.

You can configure what policy version is generated to match what your
kernel supports (as reported by /selinux/policyvers) by setting
OUTPUT_POLICY= in build.conf for a monolithic policy build or by setting
policy-version= in /etc/selinux/semanage.conf for a modular policy.
Looks like 2.6.12 supported policy.19, so it shouldn't be a problem to
build such a policy from a modern refpolicy.

I'm not sure that you need updated libselinux and friends on the
target/embedded system as long as you just build a monolithic policy on
the build host.

Not sure what SLIDEremote requires on the target/test box - Chad or Dave
can probably speak to that.

> Obviously with time being of the essence, I'd like a quick and easy way
> of developing the appropriate policies. I have looked at the tools that
> are available at present (SLIDE, SETools, etc) however tbh am a bit
> confused about what would be the best way forward and whether it'll all
> work as expected before I spend days/weeks of development time down a
> dead end.
> 
> Naturally the embedded nature of the hardware means I am unable to
> develop directly on the target and as such SLIDE seems a good tool and
> with the SLIDERemote, would seem a good fit, (install SLIDE on my RHEL5
> DevBox and connect to my remote target, which has network access but
> limited onboard resources). However am just unsure as to whether it will
> work as expected or indeed if there is another better route or toolset I
> should take.
> 
> Any ideas/insights gratefully received :)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
