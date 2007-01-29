Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TFMhJE014246
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 10:22:43 -0500
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TFNjfV026312
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:23:45 GMT
Date: Mon, 29 Jan 2007 10:23:41 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
In-Reply-To: <1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0701291017520.11801@d.namei>
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net>
 <20070127172410.2b041952.akpm@osdl.org>  <1169972718.17469.164.camel@localhost.localdomain>
  <20070128003549.2ca38dc8.akpm@osdl.org> <20070128093358.GA2071@elte.hu>
 <20070128095712.GA6485@elte.hu> <20070128100627.GA8416@elte.hu>
 <20070128104548.a835d859.akpm@osdl.org>  <m1r6tfq7nv.fsf_-_@ebiederm.dsl.xmission.com>
 <1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Jan 2007, Stephen Smalley wrote:

> NAK.  Mapping all sysctls to a single security label prevents any kind
> of fine-grained security on sysctls, and current policies already make
> use of the current distinctions to limit access to particular sets of
> sysctls to particular processes.  As is, I'd expect breakage of current
> systems running SELinux from this patch, because (confined) processes
> that formerly only required access to specific sysctl labels will
> suddenly run into denials on the generic fallback label.

Agreed, 100% NACK.

Please don't just simply remove long-researched & analyzed MAC security 
which has been in the kernel for years, which is being used in the field 
for high assurance systems, because you neglected to consider it during a 
code cleanup.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
