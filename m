Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1DDNMOg030510
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 08:23:23 -0500
Received: from mfo11.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1DDNJfw003799
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 13:23:20 GMT
Date: Wed, 13 Feb 2008 22:19:24 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: "Todd Miller" <Tmiller@tresys.com>
Cc: himainu-ynakam@miomio.jp, "Daniel J Walsh" <dwalsh@redhat.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: Disabling SELinux by kernel vulnerability
Message-Id: <20080213221924.9c8048a9.himainu-ynakam@miomio.jp>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880181F709@exchange.columbia.tresys.com>
References: <20080212234339.40551955.himainu-ynakam@miomio.jp>
	<47B1B440.7030701@redhat.com>
	<6FE441CD9F0C0C479F2D88F959B015880181F709@exchange.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Feb 2008 10:45:41 -0500
"Todd Miller" wrote:

> Daniel J Walsh wrote:
> > So this exploit, don't you neet to write to /proc?  xguest_t should
> > not be allowed to do this?
> 
> No, you don't need to be able to write to /proc to exploit the bug.
> Having read access /proc/kallsyms just makes things a little easier
> for the attacker.  Removing the address of selinux_enforcing from
> kallsyms doesn't stop the attack, it just makes the attacker work
> a little harder.
Yes, we do not need write access to /proc/kallsyms.

> Note that the modified exploit that uses kallsyms to find the address
> of vmsplice and then opens /dev/kmem read/write to do its work would
> be stopped by SELinux.
Default xguest_t does not allow execution of program on /home
so, exploit program can not be executed.
I tried exploit with boolean allow_xguest_exec_content on.

However, in this case, 
it is easy to guess address of selinux_enforcing,
because the address of selinux_enforcing is the same in another machine,
as long as the same kernel binary is used.


> 
>  - todd

Regards,
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
