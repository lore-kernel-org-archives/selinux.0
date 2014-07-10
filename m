Message-ID: <1405001166.661.15.camel@x220.localdomain>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 16:06:06 +0200
In-Reply-To: <53BE9AAF.9050701@tycho.nsa.gov>
References: <53BD9646.6030303@tresys.com> <53BE9AAF.9050701@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-07-10 at 09:52 -0400, Stephen Smalley wrote:

> Is this expected:
> # ./selinux/libsemanage/utils/semanage_migrate_etc_to_var.py
> Migrating from /etc/selinux/targeted/modules/active to
> /var/lib/selinux/targeted/active
> Attempting to rebuild policy from /var/lib/selinux
> sysnetwork: Warning: 'else' blocks in optional statements are
> unsupported in CIL. Dropping from output.
> 

Maybe, but this particular one (in sysnetwork) seem to me a bug in
policy or at least not optimal, maybe even redundant. I encountered the
issue earlier, looked at it and i could not make sense out of it.

I concluded that similar result could be achieved without that "else"
