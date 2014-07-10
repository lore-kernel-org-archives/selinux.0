Message-ID: <1404996778.661.4.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 14:52:58 +0200
In-Reply-To: <53BE889C.9050909@tycho.nsa.gov>
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain>
 <53BE889C.9050909@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-07-10 at 08:35 -0400, Stephen Smalley wrote:

<snip>

> Thanks for testing it.  How did it look from a performance POV, wrt
> memory use and runtime?
> 

I have not (yet) really focused on that but i suppose there was no real
noticeable slow down or speed up.

Any tips on how i could provide useful benchmarks?

I suppose i could enable the neverallow check
in /etc/selinux/semanage.conf and i would bet it is now much faster than
it used to be (in fact ill try that)
