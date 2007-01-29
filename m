Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TK9SB6029175
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:09:28 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TKAUF5018048
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 20:10:30 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l0TK5CeO005328
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:05:12 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l0TK5CHG005327
	for selinux@tycho.nsa.gov; Mon, 29 Jan 2007 15:05:12 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net>
	<20070127172410.2b041952.akpm@osdl.org>
	<1169972718.17469.164.camel@localhost.localdomain>
	<20070128003549.2ca38dc8.akpm@osdl.org>
	<20070128093358.GA2071@elte.hu> <20070128095712.GA6485@elte.hu>
	<20070128100627.GA8416@elte.hu>
	<20070128104548.a835d859.akpm@osdl.org>
	<m1r6tfq7nv.fsf_-_@ebiederm.dsl.xmission.com>
	<1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil>
	<Pine.LNX.4.64.0701291017520.11801@d.namei>
Date: Mon, 29 Jan 2007 10:55:51 -0700
In-Reply-To: <Pine.LNX.4.64.0701291017520.11801@d.namei> (James Morris's
	message of "Mon, 29 Jan 2007 10:23:41 -0500 (EST)")
Message-ID: <m14pq9lntk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris <jmorris@namei.org> writes:

> On Mon, 29 Jan 2007, Stephen Smalley wrote:
>
>> NAK.  Mapping all sysctls to a single security label prevents any kind
>> of fine-grained security on sysctls, and current policies already make
>> use of the current distinctions to limit access to particular sets of
>> sysctls to particular processes.  As is, I'd expect breakage of current
>> systems running SELinux from this patch, because (confined) processes
>> that formerly only required access to specific sysctl labels will
>> suddenly run into denials on the generic fallback label.
>
> Agreed, 100% NACK.
>
> Please don't just simply remove long-researched & analyzed MAC security 
> which has been in the kernel for years, which is being used in the field 
> for high assurance systems, because you neglected to consider it during a 
> code cleanup.

Please don't shoot the messenger when a weakness is found in your code.
Systems that increase security without worry that their implementation
is correct do not impress me, but I do understand that security has
little to do with correctness and everything to do with making it
_expensive_ for the other guy to do what he isn't supposed to.

This code path was always in the selinux code for when /proc was
compiled out.  I could see no way to preserve it so I removed
it.

Not knowing if it was a problem, or if we needed to do something more
I copied the people who did, at the first available opportunity.
Before this code makes it's way into peoples production systems.

Of course after all of the rants against path based security I was
amazed to find a code path that was using exactly that in selinux.
Equally I'm amazed that all of that long-researched and analysis of
the MAC security has not found these issues where you integrate with
the rest of the linux kernel.

I'm trying to make things correct, and simple and will be happy to
work with you in a way to achieve what you need in a way that does
not conflict with the rest of the kernel.

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
