Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1IMhoRb025489
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 17:43:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1IMhmc5021843
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 22:43:49 GMT
Date: Wed, 18 Feb 2004 14:43:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org,
   linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: [SELINUX] Event notifications via Netlink
Message-ID: <20040218144346.B22989@build.pdx.osdl.net>
References: <20040218125545.6c499296.davem@redhat.com> <Xine.LNX.4.44.0402181621390.28705-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0402181621390.28705-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Feb 18, 2004 at 04:22:51PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Morris (jmorris@redhat.com) wrote:
> +static int selnl_msglen(int msgtype)
> +	default:
> +		BUG();
> +static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *data)
> +	default:
> +		BUG();

Is BUG() the best error here, or too draconian?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
