Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i974U2rT011553
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 00:30:02 -0400 (EDT)
Date: Thu, 7 Oct 2004 00:29:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <01d201c4ac15$381334d0$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0410070024010.3021-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Oct 2004, Kaigai Kohei wrote:

> > > # And, I wondered if 'sel_netif_total' is really necessary.
> > 
> > This prevents the cache from growing without bounds.
> 
> But a result of sel_netif_insert() was not checked in the original code.

Looks like a bug, thanks for pointing it out.

> It's assumed the number of 'netif' is less than SEL_NETIF_HASH_MAX.
> And, Its upper limitation is the number of the real network interfaces.
> Why do you think the cache may grow without bounds?

It will keep growing until the maximum number of interfaces, which we have 
no control over in this part of the code.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
