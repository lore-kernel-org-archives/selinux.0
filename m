Received: from nox.lemuria.org ([213.191.86.30])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02405
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 08:28:34 -0400 (EDT)
Date: Tue, 1 Oct 2002 14:28:32 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy version
Message-ID: <20021001142832.C23651@lemuria.org>
References: <20021001131535.A21503@lemuria.org> <Pine.GSO.4.33.0210010742590.1579-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210010742590.1579-100000@raven>; from sds@tislabs.com on Tue, Oct 01, 2002 at 07:46:43AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 07:46:43AM -0400, Stephen Smalley wrote:
> > I have a totally unusable SELinux system right now, because of policy
> > version conflicts. For reasons I don't understand, checkpolicy creates
> > a binary representation version 12, which load_policy refuses to load
> > because it's version 11.
> 
> This implies that you are still running a kernel with policy version 11,
> but your checkpolicy program has been rebuilt for policy version 12.
> Maybe you need to boot your new kernel (hopefully, you did obtain a new
> kernel, right?)?

I built a fresh kernel from 2.4.19-lsm1 sources today, so the kernel
should actually be newer than the checkpolicy program (actually,
they're both from the August release).

I guess I will take the machine apart in order to mount the harddrive
somewhere else and take a deep look at the kernel sources to verify
this.


I'm not sure what to think about the actual behaviour of the system,
though. I believe it is misbehaving and not failing safely - even
though it can't load the policy, it boots up and lets me log in (into
an unlabeled context). However, even though I'm running in permissive
mode, I get "permission denied" on most file access attempts (including
something as simple as "ls"). IMHO, when it can't load the policy, it
should either panic (enforcing mode) or start up with a "allow all"
default (permissive mode). Feel free to correct me on this, it's just
what I would have expected.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
