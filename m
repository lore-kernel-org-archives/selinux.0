Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02654
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 08:51:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA16236
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:49:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA16230 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:49:37 GMT
Date: Tue, 1 Oct 2002 08:50:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: policy version
In-Reply-To: <20021001142832.C23651@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210010841280.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Tom wrote:

> I built a fresh kernel from 2.4.19-lsm1 sources today, so the kernel
> should actually be newer than the checkpolicy program (actually,
> they're both from the August release).

Not if you are using policy version 12.  That change didn't occur until
the aforementioned patch that I posted, when the access vector definitions
changed.  If that patch was merged into the Debian selinux packages, then
you should have a new kernel that uses policy version 12.  If you are
building the old kernel sources from the release but trying to use a newer
checkpolicy+policy, then you naturally have a problem.

> I'm not sure what to think about the actual behaviour of the system,
> though. I believe it is misbehaving and not failing safely - even
> though it can't load the policy, it boots up and lets me log in (into
> an unlabeled context). However, even though I'm running in permissive
> mode, I get "permission denied" on most file access attempts (including
> something as simple as "ls"). IMHO, when it can't load the policy, it
> should either panic (enforcing mode) or start up with a "allow all"
> default (permissive mode). Feel free to correct me on this, it's just
> what I would have expected.

If you build your kernel without the development module option (i.e.
always in enforcing mode, no way to switch into permissive mode), then it
will panic if it cannot load a policy after mounting the root filesystem.
If you build your kernel with the development module option, then it only
issues a warning if it cannot load a policy and SELinux is effectively
off until you either explicitly load a policy via load_policy or you try
to toggle into enforcing mode via avc_toggle.  I suppose that we could
change the latter case so that if you boot with enforcing=1, then it will
also panic if no policy is present.  I don't see the behavior that you
describe when booting without a valid policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
