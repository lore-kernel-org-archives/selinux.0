Message-ID: <1490119264.2050.1.camel@tycho.nsa.gov>
Subject: Re: net_admin audit for setsockopt SO_SNDBUFFORCE
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cgzones <cgzones@googlemail.com>, selinux <selinux@tycho.nsa.gov>
Date: Tue, 21 Mar 2017 14:01:04 -0400
In-Reply-To: <CAJ2a_DdNpZ5vLtCmzC+o94zQrCGWwRYar5xYa4jyxohxnu7AZA@mail.gmail.com>
References: <CAJ2a_DdNpZ5vLtCmzC+o94zQrCGWwRYar5xYa4jyxohxnu7AZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-03-21 at 16:06 +0100, cgzones wrote:
> Hi list,
> this thread[1] about setsockopt(...,...,SO_SNDBUFFORCE), which
> triggers widely due to systemd, let me think about the recent SELinux
> kernel fixes: the reordering of dac_read_search and dac_override and
> also the cap_wake_alarm fix.
> 
> Would it make sense to test, if the send buffer is really set to a
> higher value than wmem_max, before testing for the cap_net_admin
> permission[2]?
> (might also apply to SO_RCVBUFFORCE)

Probably not, since SO_SNDBUFFORCE only exists to allow a process with
CAP_NET_ADMIN to override the wmem_max limit per the man page.  IOW,
only processes with CAP_NET_ADMIN should ever use that option. 
dontaudit'ing that does not seem like a good idea either; I think you
have to allow it or risk silent breakage.

What would perhaps be better would be to introduce LSM hooks to allow
finer-grained distinctions to be made among the different CAP_NET_ADMIN
cases, ala issue #26.  Then the impact of allowing net_admin would be
less significant.


> 
> Best regards,
>     Christian Göttsche
> 
> 
> [1] http://oss.tresys.com/pipermail/refpolicy/2017-March/009185.html
> [2] https://github.com/torvalds/linux/blob/ae50dfd61665086e617cc9e554
> a1285d52765670/net/core/sock.c#L715
> 
> 
> p.s.: friendly ping on https://marc.info/?l=selinux&m=148944677530753
> &w=2
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
