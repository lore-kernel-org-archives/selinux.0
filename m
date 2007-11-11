Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lABMYUlW011710
	for <selinux@tycho.nsa.gov>; Sun, 11 Nov 2007 17:34:30 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lABMYSdw021056
	for <selinux@tycho.nsa.gov>; Sun, 11 Nov 2007 22:34:28 GMT
Date: Mon, 12 Nov 2007 09:34:27 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v6 09/13] SELinux: Better integration between peer
 labeling subsystems
In-Reply-To: <20071109212439.31738.39168.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0711120932370.7114@us.intercode.com.au>
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
 <20071109212439.31738.39168.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Nov 2007, Paul Moore wrote:

> +	/* Between selinux_compat_net and selinux_policycap_netpeer this is
> +	 * starting to get a bit messy - we need to setup a timetable for
> +	 * deprecating some of this old/obsolete functionality so we can
> +	 * reclaim some level of sanity in this function. */

I don't think we can do anything which could potentially break userspace 
now.

So, this one really needs to be right :-)


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
