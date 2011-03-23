Subject: Re: Re:Re: Re:Re: about ss
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yao <yffbrave@163.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <b41b75.151b.12ee0439347.Coremail.yffbrave@163.com>
References: <1300710582.29422.12.camel@moss-pluto>
	 <1300456978.25429.29.camel@moss-pluto>
	 <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
	 <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
	 <b41b75.151b.12ee0439347.Coremail.yffbrave@163.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 09:24:26 -0400
Message-ID: <1300886666.26747.15.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-03-23 at 09:10 +0800, Yao wrote:
> Maybe I should explain. We think kernel is untrusted, ss is trusted.
> we protect the security server through gerenating a separate address
> space. When we need to use ss, we switch to this space. If untrusted
> kernel code can be executed, what we do became meaningless. That's why
> we want the ss self-contained. And our work should apply to flask
> architecture, that's why we chose selinux.
> Is it possible to fulill my goal without modifying ss excessively?

The kernel has to be trusted - it runs in ring 0.
And the security server is just a policy engine - it just provides
policy decisions to the kernel upon request.  The kernel performs the
policy enforcement of those decisions.

In Fluke/Flask, the security server ran in userspace, but that was a
microkernel-based OS.  And even there, we weren't trying to protect the
security server from the (micro)kernel.

It doesn't make sense to try to protect the security server apart from
the rest of the kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
