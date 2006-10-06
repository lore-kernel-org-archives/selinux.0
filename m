Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96GduAS031956
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 12:39:56 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96GdJru008536
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:39:20 GMT
Message-ID: <452686DB.8070606@hp.com>
Date: Fri, 06 Oct 2006 12:39:55 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com, Joshua Brindle <jbrindle@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, redhat-lspp@redhat.com,
        chanson@TrustedCS.com, selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Re: Labeled Networking For LSPP: Where we are and
 where we need to go	(quickly)
References: <1160150738.10614.116.camel@localhost.localdomain> <4526835A.2080707@hp.com>
In-Reply-To: <4526835A.2080707@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Eric Paris wrote:
>>This is great, we are getting there.  But, we still need at least 3-4
>>more patches before tomorrow!!
>>
>>Patch1: finish the error propagation backport for the ipsec leak (Being
>>completed by Eric Paris)
>>Patch2: audit ipsec config changes (Being completed by Joy Latten)
>>Patch3: find and fix current issues with unlabeled_t packets that can't
>>be explained (Paul Moore and Venkat)
> 
> I'm working on this but it's taking time getting all the right policy bits
> sorted so I can differentiate between SECINITSID_UNLABELED and SECINITSID_NETMSG
> as they will both show up as "unlabeled_t" in all the released policies (at
> least I think so).
> 
> Venkat, if you have a policy rpm/clean-patch/tarball something it would be a
> help if you could post that or send it to me (I saw your earlier postings, but
> only the constraints were really in patch form).  Or if you could verify the
> lspp.51 kernel w/o the NetLabel/secid patch (turn off patch 25008, if you want I
> can send you a diff to the spec file - it's only two lines).  So far I have not
> seen any differences between the stock lspp.51 kernel and the lspp.51 kernel
> without the NetLabel/secid patch.

In case anyone wants to play with the lspp.51 minus the NetLabel/secid patch, I
put up a modified source RPM here:

 * http://free.linux.hp.com/~pmoore/files

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
