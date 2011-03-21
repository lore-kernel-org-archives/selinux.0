From: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
To: Yao <yffbrave@163.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Date: Mon, 21 Mar 2011 08:31:18 +0000
Subject: RE: Re:Re: about ss
Message-ID: <A9F5079BABDEE646AEBDB6831725762C52B53C8A84@EUEXCLU01.EU.NEC.COM>
References: <1300456978.25429.29.camel@moss-pluto>
 <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
 <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
In-Reply-To: <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> At 2011-03-18，"Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> 
> >On Fri, 2011-03-18 at 08:43 +0800, Yao wrote:
> >> Hi, all
> >> I looked at linux-2.6.36/security/selinux/ss/*.c and found most source
> >> files include <linux/***.h>
> >> I know security server need to use some of kernel data structures.
> >> But does ss use kernel fuctions?
> >> Is it possible to modify security server and make it self-contained if
> >> ss used kernel function?
> >
> >The original security server code was developed for another OS
> >(Fluke/Flask) and then ported to Linux.  There are a small number of
> >fundamental dependencies on the runtime environment, like memory
> >allocation, logging/auditing, locking, etc.  Over time, the security
> >server code in Linux has become increasingly "nativized" for Linux so
> >you may find further dependencies in the current code.
> >
> so, it's hard to modify ss to make it self-contained, right?
> I just wonder if there is a security module without invoking kernel function
> but to support flask, though kernel data is permitted...

The libselinux provides a set of interfaces to invoke security server in
kernel space. Please see the manpage of security_compute_av(3).
The security_context_t as these arguments are just an alias of char *,
so all you need to do is call this function with security context of
subject/object with a set permissions to be asked.

> Is AppArmor fit to my desire?

It seems to me you walk away from where you want to go. :-)

Thanks,
--
NEC Europe Ltd, Global Competence Center
KaiGai Kohei <kohei.kaigai@eu.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
