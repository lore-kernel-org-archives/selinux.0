Date: Tue, 3 Jun 2003 08:30:59 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Default Policy question?
Message-ID: <20030603083059.A4056@lemuria.org>
References: <3EDB7585.8050308@redhat.com> <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil> <20030602230314.C3637@lemuria.org> <200306030951.59964.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200306030951.59964.russell@coker.com.au>; from russell@coker.com.au on Tue, Jun 03, 2003 at 09:51:59AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 03, 2003 at 09:51:59AM +1000, Russell Coker wrote:
> > * his home directory (environment)
> > * policy and policy tools
> > * kernel and kernel modules
> 
> So who runs debugfs/fdisk/mkfs?

Note that I'm not trying to protect against DESTRUCTION of the system,
but against subversion.


> > Other than that, all other tools are limited by the policy, aren't
> > they? The sysadm_r can replace ls with a trojaned binary, but he can't
> > make it do anything that the normal ls isn't allowed to do.
> 
> When "ls" is run by any userdomain it does not trigger a domain transition.  
> If ls is compromised it's game-over, ls can do lots of interesting things 
> other than list the stats of files if it wants to...

But if I control the policy, I can add an auto_trans rule. bin_exec_t
could auto_trans to sysadm_t so the sysadm gains nothing by trojaning
any binary. :)

I didn't say the default policy is good enough for this. I'm just
trying to figure out whether it's possible at all.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
