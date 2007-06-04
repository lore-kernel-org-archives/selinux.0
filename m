Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l54Jirqh007577
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 15:44:53 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l54JiqXk007882
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 19:44:52 GMT
Date: Mon, 4 Jun 2007 15:44:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, selinux@tycho.nsa.gov,
        Joy Latten <latten@austin.ibm.com>
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
In-Reply-To: <1180983953.3950.37.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0706041544230.13341@d.namei>
References: <200703262321.l2QNLZlR014240@faith.austin.ibm.com>
 <1180983953.3950.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 4 Jun 2007, Eric Paris wrote:

> Some time ago this thread bounced back and forth and seemed to come to
> rest with the patch below, I cleaned up the comments and put all the
> ACKs it received in one place below, but so much time has passed I doubt
> if they should still count for free.  I also rediffed the patch against
> the latest miller tree.  Is the idea or patch in any way flawed or
> unacceptable to people at the moment?
> 
> Anyone willing to step up an re-ack the patch to get it moving into the
> tree?

Looks good to me.

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
