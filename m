Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99DqZvb017493
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 09:52:35 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99DpIv2002673
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 13:51:19 GMT
Date: Mon, 9 Oct 2006 09:52:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: Re: [PATCH 0/1] selinux: secid reconciliation fixes V01
In-Reply-To: <452A3ED6.9060403@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0610090949580.28179@d.namei>
References: <452A3ED6.9060403@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Oct 2006, Venkat Yekkirala wrote:

> 3. Label igmp traffic with the igmp_packet initial context.

Why is IGMP being handled separately?  How many other protocols will need 
their own specific hooks?

> + * @igmp_classify_skb:
> + *	Sets the skb's secid to the igmp initsid.

This explanation is SELinux-specific.

Your patches need to be against the latest net-2.6 tree.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
