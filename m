Message-ID: <1491923156.14576.1.camel@tycho.nsa.gov>
Subject: Re: refpolicy flask generator script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>, selinux
 <selinux@tycho.nsa.gov>
Date: Tue, 11 Apr 2017 11:05:56 -0400
In-Reply-To: <CAJ2a_DdM3zjexy=pC89BEWLK6BTgk9mo3H+_cF4gXu7=4hjFVA@mail.gmail.com>
References: <CAJ2a_DdM3zjexy=pC89BEWLK6BTgk9mo3H+_cF4gXu7=4hjFVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-11 at 16:47 +0200, Christian Göttsche wrote:
> Is the flask generator script[1] still needed;
> or can it be removed or moved into the kernel repo?
> 
> related: https://github.com/TresysTechnology/refpolicy/issues/49
> 
> [1] https://github.com/TresysTechnology/refpolicy/blob/master/policy/
> flask/flask.py

It should be obsoleted by the dynamic class/perm mapping support (both
kernel and userspace).  The libselinux headers have been shipping with
#warnings for a while now, and the kernel ones are automatically
generated at build time via the genheaders tool in the kernel tree from
the classmap.h definitions instead.
