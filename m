Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1MF420I026613
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2006 10:04:02 -0500
Subject: Re: [PATCH] context based audit filtering (take 3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dustin Kirkland <dustin.kirkland@gmail.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@namei.org>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <d9c105ea0602212217g2f255fd8gbf6ac190d7ccd751@mail.gmail.com>
References: <43F49805.2000109@trustedcs.com>
	 <43FB86DD.2020708@trustedcs.com> <43FBA962.5090904@trustedcs.com>
	 <d9c105ea0602212217g2f255fd8gbf6ac190d7ccd751@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 10:09:27 -0500
Message-Id: <1140620967.31467.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-22 at 00:17 -0600, Dustin Kirkland wrote:
> > - printk a warning and ignore invalid selinux rules (but still hang on to them
> >   so they may be activated with a later policy reload).
> 
> Interesting...  Is this the recommended approach by the SELinux folks?

Not by me, but Darrel thought it would be important to allowing audit
filters to survive across policy reloads and later revived as
appropriate without needing to reload the audit filters as well.  I'm
not clear that it matters in production environments (versus just policy
development boxes).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
