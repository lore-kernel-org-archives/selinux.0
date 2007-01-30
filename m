Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0UHImYe007195
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 12:18:48 -0500
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0UHJoG1016297
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 17:19:50 GMT
Date: Tue, 30 Jan 2007 09:19:39 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
To: Christoph Hellwig <hch@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20070130102508.GA10526@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <822578.32683.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jan 29, 2007 at 11:08:39AM -0800, Casey
> Schaufler wrote:
> > Alternativly you could move the SELinux specific
> > bits out of /proc/self/attr into an equivalent
> > /selinux/self/attr and avoid that /proc
> dependency.
> 
> Why?

To avoid the dependency and remove the issue.
Just a thought. Weigh the advantages and
disadvantages and do what seems right.

> procfs is essential for any kind of fullblown
> linux system,

Kids!

> and the selinux actually fits into the original
> procfs intention,

Yes, it does. It's a good use of /proc.

> unlike all the other junk we've added over the
> years.

You won't get any arguements from me there.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
