Message-ID: <1405002183.661.17.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 16:23:03 +0200
In-Reply-To: <53BE9F2A.9050906@tycho.nsa.gov>
References: <53BD9646.6030303@tresys.com> <53BE9F2A.9050906@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-07-10 at 10:11 -0400, Stephen Smalley wrote:

> Is the classorder bug?
> $ su <hangs forever>
> $ dmesg
>  systemd[1]: SELinux policy denies access.
> 

Is that with handle-unknown set to deny?

if so then this is due to a missing av permission for the system class
in the fedora policy

Else it may be indeed related to classorder but i think its the former
