Subject: Re: Re:Re: about ss
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yao <yffbrave@163.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20612ede.799c.12ef9f5493c.Coremail.yffbrave@163.com>
References: <1301057007.22099.11.camel@moss-pluto>
	 <1300886666.26747.15.camel@moss-pluto>
	 <1300710582.29422.12.camel@moss-pluto>
	 <1300456978.25429.29.camel@moss-pluto>
	 <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
	 <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
	 <b41b75.151b.12ee0439347.Coremail.yffbrave@163.com>
	 <1b9e718.65d4.12eeba32854.Coremail.yffbrave@163.com>
	 <20612ede.799c.12ef9f5493c.Coremail.yffbrave@163.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Mar 2011 08:49:29 -0400
Message-ID: <1301316569.23818.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-03-28 at 08:55 +0800, Yao wrote:
> At 2011-03-25，"Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> 
> >On Fri, 2011-03-25 at 14:11 +0800, Yao wrote:
> >> Well, my idea is based on a paper "Secure In-VM Monitoring Using
> >> Hardware Virtualization"(CCS'09). I will appreciate if you spend some
> >> time to look through the content & check if what I did is right.
> >
> >If I understand correctly, that paper is about co-locating a monitoring
> >service in the same VM as the operating system being monitored.  But the
> >security server is not a monitoring service; it is a policy engine
> >invoked by the kernel.  So I don't think this applies.
> Oh, I thought the security server is an implementation of server monitor. Figure 2 in the paper shows overall design. Kernel hooks invoke entry gates, which in turn invoke handlers. And linux kernel has many hooks too. After selinux registered into the kernel, those hooks will invoke handlers in selinux. Finally, those functions reside in ss will be invoked, for example, "security_compute_av".
> Is that any difference? 
> If I want to put sim into use, how do I tune the selinux to meet the requirements? Should I put all selinux into sim address space?
> If it is impossible, what "service monitor of flask arch" can I use to achieve my goals?

The security server is a policy engine for access control decisions to
be enforced by the kernel over applications.  It is not a monitor for
the kernel itself.  You likely want something more like:
"Linux kernel integrity measurement using contextual
inspection" (STC'07)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
