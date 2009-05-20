Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20090520072118.226550@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <1242651013.29973.197.camel@localhost.localdomain>
	 <1242651553.1057.0.camel@notebook2.grift.internal>
	 <4A1374D5.6080504@tycho.nsa.gov>  <20090520072118.226550@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 07:46:49 -0400
Message-Id: <1242820009.20082.374.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 09:21 +0200, Dennis Wronka wrote:
> Hello folks,
> 
> currently I am experiencing quite a strange problem during system-boot.
> The problem is that the policy only gets loaded when I boot into enforcing-mode. Booting into permissive mode (doesn't matter if via kernel-parameter or config-file) does not load the policy at all.
> 
> I am using Kernel 2.6.29.3 and Reference Policy 2.20081210.
> Did anything change in the latest kernel or policy that triggers this? Is it possible to create a policy that cannot be loaded in permissive mode?
> 
> Any help or suggestion would be great.

What mechanism are you using to perform the initial policy load (Fedora
originally patched /sbin/init then migrated to performing the load from
the initrd; Ubuntu does the load from initrd but in a different manner;
Debian still uses a patched init I believe)?

Can you post the logic for your initial policy load, whether it is a
patch to /sbin/init or an initrd script?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
