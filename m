Subject: Re: Getting started with SELinux and Slackware
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Martin J. Green" <mail@martinjgreen.me.uk>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <54EE10FFA0116B408D3A5172CB52729F01311A12DABD@exchange.home.martinjgreen.me.uk>
References: 
	 <77FD49B9B8D2394FB1B63A63934913126A55770EA8@exchange.home.martinjgreen.me.uk>
	 <54EE10FFA0116B408D3A5172CB52729F012DC48610D7@exchange.home.martinjgreen.me.uk>
	 <54EE10FFA0116B408D3A5172CB52729F01311A12DABD@exchange.home.martinjgreen.me.uk>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 11:24:39 -0400
Message-Id: <1205249079.23866.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 08:22 +0000, Martin J. Green wrote:
> It looks like a number of packages now have patches upstreamed (--with-selinux) - any idea how up to date/complete they are? (Openssh, util-linux & shadow all have --with-selinux configure flags).
> 
> I'm seeing this error:
> 
> sftp.c: In function 'parse_dispatch_command':/usr/lib/gcc/i486-slackware-linux/4.2.3/../../../libselinux.a(load_policy.o): In function `selinux_mkload_policy':
> load_policy.c:(.text+0xbf): undefined reference to `sepol_policy_kern_vers_max'

Why are you linking against libselinux.a (static) rather than using
shared libraries?

You need to link with libsepol too.

> load_policy.c:(.text+0x114): undefined reference to `sepol_policy_kern_vers_min'
> load_policy.c:(.text+0x212): undefined reference to `sepol_policy_file_create'
> load_policy.c:(.text+0x229): undefined reference to `sepol_policydb_create'
> load_policy.c:(.text+0x256): undefined reference to `sepol_policy_file_set_mem'
> load_policy.c:(.text+0x270): undefined reference to `sepol_policydb_read'
> load_policy.c:(.text+0x28f): undefined reference to `sepol_policydb_set_vers'
> load_policy.c:(.text+0x2c0): undefined reference to `sepol_policydb_to_image'
> load_policy.c:(.text+0x2d8): undefined reference to `sepol_policy_file_free'
> load_policy.c:(.text+0x2e7): undefined reference to `sepol_policydb_free'
> load_policy.c:(.text+0x328): undefined reference to `sepol_policy_file_free'
> load_policy.c:(.text+0x337): undefined reference to `sepol_policydb_free'
> load_policy.c:(.text+0x373): undefined reference to `sepol_policy_file_free'
> load_policy.c:(.text+0x382): undefined reference to `sepol_policydb_free'
> load_policy.c:(.text+0x3d8): undefined reference to `sepol_policy_file_free'
> load_policy.c:(.text+0x473): undefined reference to `sepol_genbools_array'
> load_policy.c:(.text+0x4f5): undefined reference to `sepol_genusers'
> load_policy.c:(.text+0x534): undefined reference to `sepol_genbools'
> collect2: ld returned 1 exit status
> make: *** [sshd] Error 1
> make: *** Waiting for unfinished jobs....
> 
> sftp.c:1031: warning: 'n_arg' may be used uninitialized in this function
> sftp.c:1030: warning: 'iflag' may be used uninitialized in this function
> sftp.c:1030: warning: 'lflag' may be used uninitialized in this function
> sftp.c:1030: warning: 'pflag' may be used uninitialized in this function
> 
> Any idea what I'm missing?
> 
> Martin
> 
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Martin J. Green
> Sent: 11 March 2008 03:28
> To: selinux@tycho.nsa.gov
> Subject: RE: Re: Getting started with SELinux and Slackware
> 
> I grabbed a copy of from http://www.filewatcher.com/p/util-linux-2.11y-31.2.src.rpm.1552730/util-linux-selinux.patch.html and had a go at patching it against the 2.12r code to see what was going to patch/what needed fixing, and it appears 2.12r already has some selinux code/support included? (the 2.11y patch creates two files, amongst other things, called selinux_utils.c and .h - these already exist) The MCONFIG file has an option to enable selinux - it appears the patch is already integrated?
> 
> Looking at fedora sources, it looks like they only patch util-linux for pam, not selinux, so this would seem to confirm this is the case (though looking at Timothy Wood's patchset, he's also adding the use_selinux define to MCONFIG).
> 
> So I don't need to do anything to util-linux except enable selinux on compile?
> 
> Login would come from Shadow in any event, so probably need to be looking there...
> 
> M
> 
> From: Stephen Smalley <sds@tycho.nsa.gov>
> 
> The switch from using a direct patch to login to using pam_selinux
> happened back in 2003, so I think Fedora might have always used
> pam_selinux (since Fedora first included SELinux in Fedora Core 2, which
> came out later). You can tell by whether or not the
> util-linux-selinux.patch included a diff to login.c or not.
> 
> 
> Of course, pam_selinux has undergone a lot of changes since that time,
> so you may want to consider just back porting its logic into login.c,
> removing its pam'isms.
> 
> 
> google on util-linux-selinux.patch found a copy that still had the
> login.c mods at:
> http://mirror.caoslinux.org/cAos-1/creation/util-linux-2.11y-31.1/SOURCES/util-linux-selinux.patch
> among other places.
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
