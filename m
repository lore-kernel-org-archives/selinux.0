Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56DLpia003462
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 09:21:51 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l56DLnI6018174
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 13:21:50 GMT
Date: Wed, 6 Jun 2007 09:21:47 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, drepper@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        chrisw@redhat.com, sds@tycho.nsa.gov, sgrubb@redhat.com
Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
In-Reply-To: <1181111433.3978.48.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0706060919560.28120@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
 <20070603205653.GE25869@devserv.devel.redhat.com>
 <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
 <1181075666.3978.31.camel@localhost.localdomain>  <Line.LNX.4.64.0706051658170.23379@d.namei>
  <20070605211616.GE23291@devserv.devel.redhat.com>
 <1181111433.3978.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Jun 2007, Eric Paris wrote:

> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "mmap_min_addr",
> +		.data		= &mmap_min_addr,
> +		.maxlen         = sizeof(unsigned long),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,

proc_doulongvec_minmax

(I can fix this in my tree rather than a resend just for this, if
there are some acks & no other problems).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
