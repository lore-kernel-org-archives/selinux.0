Message-ID: <1405003392.661.23.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 16:43:12 +0200
In-Reply-To: <53BEA25D.8090501@tycho.nsa.gov>
References: <53BD9646.6030303@tresys.com> <53BE9F2A.9050906@tycho.nsa.gov>
 <1405002183.661.17.camel@x220.localdomain> <53BEA25D.8090501@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-07-10 at 10:25 -0400, Stephen Smalley wrote:

> 
> No, this is a stock system, so semanage.conf has the defaults, i.e. no
> expand-check and no handle-unknown.
> 
> 

I see, If this only happened right after policy was (re) loaded and
after that it was gone. Then i might have hit the same issue (not with
this test though but yesterday with my e145 policy built using latest
secilc) when i loaded my policy with the classorder added (i am not
saying that classorder is causing this though)

I started seeing dbus denials for a short period (even though the rules
were in the policy). Soon after they disappeared and everything was
fine.

It probably going to take a little time for me to be able to reproduce
this if i can reproduce it at all.
