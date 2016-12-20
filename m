Message-ID: <1482236048.2203.3.camel@nonadev.net>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: paul@paul-moore.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
 john.johansen@canonical.com, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Tue, 20 Dec 2016 13:14:08 +0100
In-Reply-To: <201612202013.DBD12445.OOSHFMQLJOFVtF@I-love.SAKURA.ne.jp>
References: <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQOjXUYxRaHcgxwiTFwwNsUuf646O-gDq7Bm_0aToMtgQ@mail.gmail.com>
 <28224bb8-425e-5dec-472f-105c5cd7e098@schaufler-ca.com>
 <CAHC9VhRcHxEMjTwjq6ZiAjHcAyveWOnRdRayoq86tdUsD_OdMw@mail.gmail.com>
 <1482230211.2203.1.camel@nonadev.net>
 <201612202013.DBD12445.OOSHFMQLJOFVtF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le mardi 20 décembre 2016 à 20:13 +0900, Tetsuo Handa a écrit :
> Jose Bollo 
> > Please explain first the relationship that you are supposing true:
> > 
> >     writing /proc/pid/attr/.. == writing creds
> > 
> > 
> > I'm feeling that there is here a weird logic.
> > 
> > I can agree that the use of creds that I made is wrong and must be
> > changed. But how can I agree that writing to /proc/pid/attr/... is
> > not
> > good when for my purpose it is a valuable and working solution?
> 
> Regarding TOMOYO, "writing creds" == "writing
> /sys/kernel/security/tomoyo/self_domain".

Hi Tetsuo,

It confirms what I wanted to point out, there is no real link between
writing creds and writing /proc/.../attr. But here it is for SELF so it
doesn't brakes the creds.

> I didn't choose /proc/pid/attr/ interface from the beginning, for I
> wanted to allow
> enabling multiple LSM modules concurrently and I thought existing
> userspace programs
> will be confused when multiple concurrent LSM modules are fully
> supported.
> 
> You can check Casey's "LSM: module hierarchy in /proc/.../attr"
> patches at
> http://lkml.kernel.org/r/00f80c77-9623-7e9e-8980-63b362a4f16c@schaufl
> er-ca.com .
> Since PTAGS is not yet in-tree, I think it is less harder (in other
> words, now
> is a chance) to reconsider the interface for PTAGS.

I agree that it can be a chance. You pointed out the limitations in
using existing /proc/.../attr implmentation and thank you for that.

But PTAGS is specifically bound to tasks.

So /proc/pid..., with its DAC and its MAC access control, with its
already existing implementation PID of namespace is the natural place
where control interface for PTAGS should occur.

I would really welcome proposal for other place but I guess that it
would be of lesser evidence and that the implmentation would be much
complicated.

I followed what Casey proposed and that you cite. It is a good proposal
in its idea. It makes things a little more complicated than what
already exist and I doubt a little that in a day (or a night ;) SELinux
 Smacks Tomoyo. However it would makes things cleaner: a command like
'id' would be easier to implement.

Best regards
José
