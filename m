Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l54NDDBn019386
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 19:13:13 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l54NDCR1007024
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 23:13:12 GMT
Date: Mon, 4 Jun 2007 19:13:10 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>, "David S. Miller" <davem@davemloft.net>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Joy Latten <latten@austin.ibm.com>
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
In-Reply-To: <Line.LNX.4.64.0706041544230.13341@d.namei>
Message-ID: <Line.LNX.4.64.0706041911480.15240@d.namei>
References: <200703262321.l2QNLZlR014240@faith.austin.ibm.com>
 <1180983953.3950.37.camel@localhost.localdomain> <Line.LNX.4.64.0706041544230.13341@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've applied this patch to 

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-davem


Dave, feel free to pull from that branch.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
