Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3AChPbw027593
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 08:43:25 -0400
Received: from atoll.udmvt.ru (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3AChNvR004843
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 12:43:24 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n3AChIQ7091268
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 17:43:20 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Fri, 10 Apr 2009 17:43:18 +0500
From: Alexey S <selinux@udmvt.ru>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Policy infrastructure problems and improvement
Message-ID: <20090410124318.GM9889@ruber.office.udmvt.ru>
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 09, 2009 at 11:28:03AM -0400, James Carter wrote:
> I am looking at improving the policy infrastructure.  The ultimate goal
> is to make SELinux policy writing, policy customization, policy
> management, and administration easier and less confusing. My focus will
> be on the userspace parts of SELinux. 
> 
> My plan to do this is as follows:
> (1) Determine and enumerate the existing problems of the current
> infrastructure.
> (2) Determine the desired capabilities and architecture of the ideal
> infrastructure.
> (3) Determine the changes needed to the current architecture to fix the
> current problems and to provide the desired capabilities.
> (4) Make the policy infrastructure as close to the ideal as possible
> while providing some kind of backwards compatibility and taking other
> practicalities into consideration.
> 
> I have had some informal discussions with others internally and at
> Tresys, and the five emails to follow have my summary of the problems
> that have been identified in those discussions.
> 
> My hope is that there will be a good discussion and that others on the
> list will identify other problems and provide more details or examples
> to the problems already identified.

May I put my 5cents?
It would be great if mapping of domain attributes to numbers be preserved
somewhere during linking/expanding of modules into binary policy.
And if libqpol-based tools would be able to use that mapping when displaying
their results.
Otherwise it is too confusing to see @ttr0121 instead of domain_type during policy
analysis, especially when numbers change after module (re|un|)load.

PS: Could binary policy have 'debug' segments, that are not loaded into kernel,
but persist in a file?
PPS: Have I missed something somewhere? It is so obviously inconvenient, so
I don't believe it's only me requesting this thing.

Thanks.
-- 
Alexey S.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
