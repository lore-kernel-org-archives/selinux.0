Date: Mon, 2 Jun 2003 23:03:14 +0200
From: Tom <tom@lemuria.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
Subject: Re: Default Policy question?
Message-ID: <20030602230314.C3637@lemuria.org>
References: <3EDB7585.8050308@redhat.com> <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Jun 02, 2003 at 01:21:53PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 02, 2003 at 01:21:53PM -0400, Stephen Smalley wrote:
> security administrator from the system administrator is difficult unless
> you significantly prune what a typical system administrator can do;
> otherwise, the system administrator can subvert the software,
> configuration or environment of the security administrator and
> effectively take control of it.  

But if the secadm_r controls the policy, he should have enough power at
his hands to prevent subversion. Things he would have to protect:

* his home directory (environment)
* policy and policy tools
* kernel and kernel modules

Other than that, all other tools are limited by the policy, aren't
they? The sysadm_r can replace ls with a trojaned binary, but he can't
make it do anything that the normal ls isn't allowed to do.


Please tell me if I'm wrong - I'm seing if it's possible to define a
set of "core tools", defined essentially as "access to any of these means 
game over". I'm not sure if I can invert the process and say that _no_
access to any of them means system integrity still valid, but it
appears so.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
