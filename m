Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k97Ef5EX029658
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 10:41:05 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k97EeRrs022957
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 14:40:28 GMT
Date: Sat, 7 Oct 2006 10:41:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com,
        eparis@redhat.com, sgrubb@redhat.com, jbrindle@tresys.com
Subject: Re: [PATCH 1/1] selinux: Null-out secmark after use - V.02
In-Reply-To: <4526CF73.1070200@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0610071040190.21320@d.namei>
References: <4526CF73.1070200@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Oct 2006, Venkat Yekkirala wrote:

> This nulls out the secmark field on the skb after

This doesn't apply to an upstream tree.

Please indicate which tree it is for and also whether you want it applied 
or reviewed.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
