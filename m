Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3Q01KoE026932
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 20:01:20 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3Q00x48020706
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 00:01:00 GMT
Date: Wed, 25 Apr 2007 19:59:12 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, csellers@tresys.com
Subject: Re: [RFC] Ability to allow undefined permissions and classes -v3
In-Reply-To: <1177537171.4221.25.camel@dhcp59-235.rdu.redhat.com>
Message-ID: <Line.LNX.4.64.0704251956270.26475@d.namei>
References: <1177537171.4221.25.camel@dhcp59-235.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Apr 2007, Eric Paris wrote:

> add a new kernel class?  If so I will have a large waste in my array.
> Its already the case that this proposed array is wasting space for all
> of the userspace classes as it stands.

Is this patch against my for-akpm branch?

> +		p->undefined_perms = kzalloc(sizeof(u32)*num_classes, GFP_KERNEL);

Use kcalloc().


Otherwise looks ok to me.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
