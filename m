Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DLatRM001878
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 17:36:56 -0400
Received: by mail-oi0-f47.google.com with SMTP id p188so77143672oih.2
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 14:36:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <570E9E79.9000105@tycho.nsa.gov>
References: <CADs1-60DRNHOU2-k93oOTRRmYk4YtXP=af6cRhsK=Kwd+_t_3A@mail.gmail.com>
 <570E99A8.5000101@tycho.nsa.gov> <570E9E79.9000105@tycho.nsa.gov>
Date: Wed, 13 Apr 2016 17:36:53 -0400
Message-ID: <CAHC9VhRGLbjN-U0-_Cx1j7Wmuz1u0JT1o4U0uf5aQeYLXamUpA@mail.gmail.com>
Subject: Re: Failure in sel_netport_sid_slow()
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Greg <gkubok@gmail.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 13, 2016 at 3:31 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Looking at the sel_netport_sid_slow() code, I don't see why we need to
> fail hard if the kzalloc() of the new node fails; we just won't be able
> to cache the result but can still obtain and return the SID.  Paul, do
> you see any reason we can't just move up the call to security_port_sid()
> and only fail if that fails?  In the common case, that won't require
> memory allocation at all (only needs it if it hasn't previously mapped
> the resulting context to a SID).  In the same manner, we do not fail
> just because we cannot add an entry to the AVC.  The same should apply
> to netnode and netif caches.

Sounds reasonable to me, I'll post a RFC patch in just a minute ... it
will be RFC because it will be completely untested, once I've had a
chance to test it I'll merge it.

> That said, it seems hard to envision that kzalloc() failing and being
> able to complete the bind() operation at all, but maybe it is a
> transient failure.

Agreed, although it might be that the rest of the allocations in the
network stack are done with something other than GFP_ATOMIC, not sure
off the top of my head.

-- 
paul moore
www.paul-moore.com
