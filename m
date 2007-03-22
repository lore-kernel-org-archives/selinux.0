Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2MNna3E006060
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 19:49:36 -0400
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2MNnZEE004652
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 23:49:35 GMT
Date: Thu, 22 Mar 2007 19:49:30 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Joy Latten <latten@austin.ibm.com>
cc: David Miller <davem@davemloft.net>, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, vyekkirala@TrustedCS.com
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
In-Reply-To: <1174598630.3085.285.camel@faith.austin.ibm.com>
Message-ID: <Line.LNX.4.64.0703221943110.24461@d.namei>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
 <20070322.120139.74735307.davem@davemloft.net> <1174598630.3085.285.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Mar 2007, Joy Latten wrote:

> > I would look at this patch differently if there were some
> > security level key being checked for a match here, which is
> > an input key to the flush, but that is not what is happening
> > here as the object is being looked at by itself.
> 
> Yes, I understand what you are saying.
> I was concerned about having to check each entry
> to flush database.
> 
> I did this patch because we check for authorization
> when deleting single specified entries from the SAD/SPD. It
> seem like a hole to me that we check for this, but that same
> user/process can delete the entire database with no checks.

Indeed.  Removing an entry is modifying MAC policy, which requires 
appropriate authorization.

The security label is encapsulated with the object, which is why it's 
passed to the security layer.

Perhaps a better semantic would be to fail the entire flush operation if 
one of the security checks failed.  e.g. loop through for permissions 
first, then if all ok, loop through for deletion.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
