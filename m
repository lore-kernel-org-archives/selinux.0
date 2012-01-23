Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0NIGEBs010557
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2012 13:16:14 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0NIGD3U008210
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2012 18:16:13 GMT
Message-ID: <4F1DA3E5.5030608@redhat.com>
Date: Mon, 23 Jan 2012 13:16:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux with initramfs
References: <20120114142001.GA5632@siphos.be> <20120114143421.GB5632@siphos.be> <4F11A36F.1050001@gentoo.org> <4F143862.9050107@redhat.com> <20120121192447.GA5909@siphos.be>
In-Reply-To: <20120121192447.GA5909@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/21/2012 02:24 PM, Sven Vermeulen wrote:
> On Mon, Jan 16, 2012 at 09:46:58AM -0500, Daniel J Walsh wrote:
>> In RHEL and Fedora, we relabel the parts of /dev that are created
>> in the initramfs and restart udev so it is a child of
>> init/systemd.
> 
> When do you relabel them? When I call setfiles before the
> load_policy, I get an 'Operation not supported' on /dev as if it
> was a kernel that doesn't support extended attributes on tmpfs
> (which isn't the case). Trying to call it afterwards doesn't work,
> since the kernel_t domain doesn't allow relabeling (I think, output
> is also missing since /dev/console is wrongly labeled).
I think /sbin/init on Fedora is doing the relabeling, so init_t.  On
older RHEl versions, udev is doing the relabeling udev_t.
> 
> I'm quite close to have support for both putting the policy in the
> initramfs itself (and call load_policy as one of the first things
> done on the initramfs environment) and supporting booting in
> permissive mode and have a switch to enforcing which can't be
> undone afterwards (goal is to boot in enforcing).
> 
> The first support option probably allows for such a sane boot but
> requires the policy to be in the initramfs. The other one allows us
> to boot properly and I just toggle "setenforce 1" with the
> secure_mode_policyload boolean enabled afterwards.
> 
> But both sound hackish - If I could only understand why I can't use
> setfiles on /dev before calling load_policy...
> 
> Wkr, Sven Vermeulen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8do+MACgkQrlYvE4MpobOWTACeMBaS6jKz9PH4ktXiNnxSmJ9o
OlYAoIq3NxnzXFjewmxbKML94z+DkQPx
=7XVq
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
