Subject: Re: Enable selinux in SLES 11
From: Stephen Smalley <sds@tycho.nsa.gov>
To: imsand@puzzle.ch
Cc: selinux@tycho.nsa.gov
In-Reply-To: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Aug 2010 11:49:11 -0400
Message-ID: <1282578551.26282.46.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-08-23 at 15:23 +0200, imsand@puzzle.ch wrote:
> Hello Everybody
> 
> For quite a while I've been trying to enable selinux in SLES11, but
> sestatus always show DISABLED.
> 
> The following steps I've already done:
>   * installed all *selinux* packages from yast2
>   * add the following boot parameters to the kernel: security=selinux
> selinux=1 enforcing=0
>   * created /etc/selinux/config file with the that content:
>     SELINUX=enforcing
>     SELINUXTYPE=targeted
> 
> What I've noticed is, that /selinux doesn't exit. I can't create that
> mountpoint manually because selinuxfs filesystem doesn't exist.
> 
> Does anybody knows if that could be the reason? and if so, how do i get
> selinux work on SLES 11.
> (As far as I know SLES 11 should be prepared to use selinux as technical
> preview).

Others have been able to enable SELinux on recent OpenSUSE releases
(11.2, 11.3), but I don't know how much if any of that work has fed back
into SLES 11 so far.

Some prior discussions of OpenSUSE SELinux support:
http://marc.info/?l=selinux&w=2&r=1&s=opensuse&q=b

A posting and blog by a Novell employee who seems to be responsible for
SELinux integration in OpenSUSE:
http://marc.info/?l=selinux&m=126641568218140&w=2
http://thetoms-random-thoughts.blogspot.com/

Some relevant bugzillas on OpenSUSE:
https://bugzilla.novell.com/show_bug.cgi?id=594041
https://bugzilla.novell.com/show_bug.cgi?id=582366
https://bugzilla.novell.com/show_bug.cgi?id=581505

You likely need to install a policy of your own, e.g. build refpolicy
and install it, as I don't think SLES provides one.  Is there anything
under /etc/selinux/targeted?

Then the next question is whether the sysvinit or initrd in SLES 11 has
been instrumented to load the policy.

To get any changes in SLES itself, you likely need to go through your
Novell rep and file bugzillas.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
