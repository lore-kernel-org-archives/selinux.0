Message-ID: <8bc89c25b294c9c48aa0c64abbe3e9c5b660e0fe.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 peter.enderborg@sony.com, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Jul 2018 19:58:48 -0700
In-Reply-To: <CAHC9VhTRmWnobxqjffSwvUQfjOP0mo-qOVF_CAd5po_8tGpR5A@mail.gmail.com>
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
 <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
 <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
 <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com>
 <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
 <CAHC9VhTRmWnobxqjffSwvUQfjOP0mo-qOVF_CAd5po_8tGpR5A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2018-07-02 at 22:41 -0400, Paul Moore wrote:
> > It still applies today to -next.
> 
> It doesn't apply cleanly to the selinux/next branch, I believe because
> there are other trees which have made changes under security/selinux/*
> (I believe there was some fs related work from David Howells that
> touched some SELinux/LSM code).
> 
> As I said earlier, if you want me to apply your patches to the SELinux
> tree, please base them either against the selinux/next tree or against
> Linus' tree.

Rather than create more conflicts against changes
that are going to be merged soonish, it can wait.
