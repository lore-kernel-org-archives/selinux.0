Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VDjZbr007285
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 09:45:35 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VDjXtC028577
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 13:45:33 GMT
Date: Thu, 31 May 2007 09:45:30 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, drepper@redhat.com,
        alan@redhat.com, roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, chrisw@redhat.com
Subject: Re: [PATCH] SELinux protection for exploiting null dereference using
 mmap
In-Reply-To: <1180590362.3969.11.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0705310943170.23949@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
 <Line.LNX.4.64.0705301954080.19731@d.namei> <1180590362.3969.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 31 May 2007, Eric Paris wrote:

> suggestions for a better name from anyone? 

system? kernel?

> It doesn't address the question of 'is 1 page enough'   Anyone with a
> good suggestion of how much is enough?  Or a reasonable idea on how to
> make something like this configureable if we can't agree on a single
> number?

For SELinux, have a default and allow the value to be set via a selinuxfs 
node.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
