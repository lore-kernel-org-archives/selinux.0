Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96GOxFQ031457
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 12:24:59 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96GNkQW014090
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:23:46 GMT
Message-ID: <4526835A.2080707@hp.com>
Date: Fri, 06 Oct 2006 12:24:58 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>, vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, chanson@TrustedCS.com
Subject: Re: Labeled Networking For LSPP: Where we are and where we need to
 go	(quickly)
References: <1160150738.10614.116.camel@localhost.localdomain>
In-Reply-To: <1160150738.10614.116.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> Last night I built a new test kernel for labeled networking in RHEL5
> kernels.  That kernel can be found at 
> 
> http://people.redhat.com/sgrubb/files/lspp
> 
> and you want the lspp kernel 51.
> 
> What's in this kernel?  A whole bunch of patches which might just make
> it into RHEL5.  I have until this Monday, Oct 9 to try again.  That
> means that I really really need everything finished very quickly (aka
> today) so we can get some basic testing!  ALL testing needs to be done
> with compat_net = 0 and hopefully in enforcing.  We don't have a good
> policy for this yet, but i'll mention that again later.  In this last
> kernel we have
> 
> -netlabel config auditing patch
> -netlabel cache opps patch

Just a reminder: these first two are bugfixes which should go into RHEL5 regardless.

> -netlabel unlabeled patch

While not a bugfix like the previous two, this is a "logic bug" fix which should
go into RHEL5.

> -secid reconciliation between secmark and xfrm
> -network_t addition
> -secid reconciliation with netlabel
> -1/3 of the complete fix for the ipsec information escape
> 
> This is great, we are getting there.  But, we still need at least 3-4
> more patches before tomorrow!!
> 
> Patch1: finish the error propagation backport for the ipsec leak (Being
> completed by Eric Paris)
> Patch2: audit ipsec config changes (Being completed by Joy Latten)
> Patch3: find and fix current issues with unlabeled_t packets that can't
> be explained (Paul Moore and Venkat)

I'm working on this but it's taking time getting all the right policy bits
sorted so I can differentiate between SECINITSID_UNLABELED and SECINITSID_NETMSG
as they will both show up as "unlabeled_t" in all the released policies (at
least I think so).

Venkat, if you have a policy rpm/clean-patch/tarball something it would be a
help if you could post that or send it to me (I saw your earlier postings, but
only the constraints were really in patch form).  Or if you could verify the
lspp.51 kernel w/o the NetLabel/secid patch (turn off patch 25008, if you want I
can send you a diff to the spec file - it's only two lines).  So far I have not
seen any differences between the stock lspp.51 kernel and the lspp.51 kernel
without the NetLabel/secid patch.

> There also is some question from Joshua Brindle if the object classes
> are correct for a number of things.  These changes also will need to be
> done quickly.  I'm going to call this Patch4.
> 
> Patch4: verify/fix the object class for all netlabel hooks.  (Hopefully
> Venkat will be able to take the lead on this)

Just to clarify, these aren't netlabel specific hooks/changes, these are secid
hooks/changes.  Otherwise, I agree, Venkat has the best understanding of this
work so I believe he should "drive" - I'll do whatever I can to support this work.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
