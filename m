Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03155
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 09:30:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA18906
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:28:30 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id NAA18888 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:28:28 GMT
Date: Tue, 1 Oct 2002 15:30:15 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy version
Message-ID: <20021001153015.A24185@lemuria.org>
References: <20021001142832.C23651@lemuria.org> <Pine.GSO.4.33.0210010841280.1579-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210010841280.1579-100000@raven>; from sds@tislabs.com on Tue, Oct 01, 2002 at 08:50:25AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 08:50:25AM -0400, Stephen Smalley wrote:
> > I built a fresh kernel from 2.4.19-lsm1 sources today, so the kernel
> > should actually be newer than the checkpolicy program (actually,
> > they're both from the August release).
> 
> Not if you are using policy version 12.  That change didn't occur until
> the aforementioned patch that I posted, when the access vector definitions
> changed.  If that patch was merged into the Debian selinux packages, then
> you should have a new kernel that uses policy version 12.  If you are
> building the old kernel sources from the release but trying to use a newer
> checkpolicy+policy, then you naturally have a problem.

That would make sense, though the Debian selinux packages (tools and
lsm patches) are all labeled 2002_08_23. Maybe the patches were 
backported and I'm just confused.

I'm currently rebuilding from scratch on a new system to verify that
Brian's new packages are clean and the mistake was somewhere on my
side.



> If you build your kernel without the development module option (i.e.
> always in enforcing mode, no way to switch into permissive mode), then it
> will panic if it cannot load a policy after mounting the root filesystem.
> If you build your kernel with the development module option, then it only
> issues a warning if it cannot load a policy and SELinux is effectively
> off until you either explicitly load a policy via load_policy or you try
> to toggle into enforcing mode via avc_toggle.  I suppose that we could
> change the latter case so that if you boot with enforcing=1, then it will
> also panic if no policy is present.  I don't see the behavior that you
> describe when booting without a valid policy.

My kernel is built with development module, and I don't trigger
avc_toggle during bootup either (I just verified this). After replacing
the base system from a woody CD, I can access the filesystem again.

However, one 100% reliable denial remains in the networking code,
namely that I do not have any networking at all. All network access
(ping, http, ftp, etc) throws an error about "unlabeled packet". This
is in permissive mode. And the kernel does not even have labelled IP
networking enabled.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
