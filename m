Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0LJP97k009131
	for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2012 14:25:09 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0LJP8rd013828
	for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2012 19:25:08 GMT
Received: by eaal1 with SMTP id l1so577809eaa.12
        for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2012 11:25:08 -0800 (PST)
Date: Sat, 21 Jan 2012 20:24:48 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux with initramfs
Message-ID: <20120121192447.GA5909@siphos.be>
References: <20120114142001.GA5632@siphos.be>
 <20120114143421.GB5632@siphos.be>
 <4F11A36F.1050001@gentoo.org>
 <4F143862.9050107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4F143862.9050107@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 16, 2012 at 09:46:58AM -0500, Daniel J Walsh wrote:
> In RHEL and Fedora, we relabel the parts of /dev that are created in
> the initramfs and restart udev so it is a child of init/systemd.

When do you relabel them? When I call setfiles before the load_policy, I get
an 'Operation not supported' on /dev as if it was a kernel that doesn't
support extended attributes on tmpfs (which isn't the case). Trying to call
it afterwards doesn't work, since the kernel_t domain doesn't allow
relabeling (I think, output is also missing since /dev/console is wrongly
labeled).

I'm quite close to have support for both putting the policy in the initramfs
itself (and call load_policy as one of the first things done on the
initramfs environment) and supporting booting in permissive mode and have a
switch to enforcing which can't be undone afterwards (goal is to boot in
enforcing).

The first support option probably allows for such a sane boot but requires
the policy to be in the initramfs. The other one allows us to boot properly
and I just toggle "setenforce 1" with the secure_mode_policyload boolean
enabled afterwards.

But both sound hackish - If I could only understand why I can't use setfiles
on /dev before calling load_policy...

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
