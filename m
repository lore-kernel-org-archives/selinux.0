To: jobol@nonadev.net
Cc: paul@paul-moore.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
 john.johansen@canonical.com, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] proc,
 security: move restriction on writing /proc/pid/attr nodes to proc
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQOjXUYxRaHcgxwiTFwwNsUuf646O-gDq7Bm_0aToMtgQ@mail.gmail.com>
 <28224bb8-425e-5dec-472f-105c5cd7e098@schaufler-ca.com>
 <CAHC9VhRcHxEMjTwjq6ZiAjHcAyveWOnRdRayoq86tdUsD_OdMw@mail.gmail.com>
 <1482230211.2203.1.camel@nonadev.net>
In-Reply-To: <1482230211.2203.1.camel@nonadev.net>
Message-Id: <201612202013.DBD12445.OOSHFMQLJOFVtF@I-love.SAKURA.ne.jp>
Date: Tue, 20 Dec 2016 20:13:40 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Jose Bollo 
> Please explain first the relationship that you are supposing true:
> 
>     writing /proc/pid/attr/.. == writing creds
> 
> 
> I'm feeling that there is here a weird logic.
> 
> I can agree that the use of creds that I made is wrong and must be
> changed. But how can I agree that writing to /proc/pid/attr/... is not
> good when for my purpose it is a valuable and working solution?

Regarding TOMOYO, "writing creds" == "writing /sys/kernel/security/tomoyo/self_domain".
I didn't choose /proc/pid/attr/ interface from the beginning, for I wanted to allow
enabling multiple LSM modules concurrently and I thought existing userspace programs
will be confused when multiple concurrent LSM modules are fully supported.

You can check Casey's "LSM: module hierarchy in /proc/.../attr" patches at
http://lkml.kernel.org/r/00f80c77-9623-7e9e-8980-63b362a4f16c@schaufler-ca.com .
Since PTAGS is not yet in-tree, I think it is less harder (in other words, now
is a chance) to reconsider the interface for PTAGS.
