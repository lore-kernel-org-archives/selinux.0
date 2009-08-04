Subject: Re: A question about selinux userspace tools
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 08:13:33 -0400
Message-Id: <1249388013.9193.52.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-04 at 03:11 +0000, TaurusHarry wrote:
> Hi all,
> 
> I am a newcomer to SELinux and have a question about the latest
> SELinux userspace tools.
> 
> Before I try to install the latest refpolicy-20090730 from tresys
> website on Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed
> the below latest SELinux userspace tools on the laptop:
> 
> libsepol-2.0.37
> libselinux-2.0.85
> libsemanage-2.0.33
> policycoreutils-2.0.69
> checkpolicy-2.0.19
> sepolgen-1.0.17
> 
> If I specify MONOLITHIC=n in build.conf and compile refpolicy-20090730
> by the latest SELinux userspace tools and then do "make load", I would
> run into following error message in the end:
> 
> libsepol.sepol_module_package_read: out of memory
> libsemanage.semanage_load_module: Error while reading from module
> file /etc/selinux/refpolicy-20090730/modules/tmp/base.pp.
> /usr/sbin/semodule:  Failed!
> make: *** [load] Error 1
> 
> The same error would crop up when I try out following
> second-to-the-latest SELinux userspace tools(also ! from tresys
> website):
> 
> libsepol-2.0.36
> libselinux-2.0.79
> libsemanage-2.0.31
> policycoreutils-2.0.62
> checkpolicy-2.0.19
> sepolgen-1.0.16
> 
> Only if I degrade libsemanage from 2.0.31 to 2.0.27, and
> policycoreutils from 2.0.62 to 2.0.55, would the "make load" finish
> uneventfully, then I could do "semanage login/user -l" and "semodule
> -l" successfully.
> 
> So far I have very shallow experience on SELinux userspace tools
> implementation and couldn't find out the reason  why the latest stable
> version would have above error message on my laptop, has anyone run
> into the same problem before? Any suggestions are greatly appreciated!

Things that would help debug:
1) A copy of the base.pp file on which it failed,
2) The amount of memory and swap configured on your laptop,

Possibly this could be due to the introduction of policy module
compression (bzip) support in libsemanage 2.0.31.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
