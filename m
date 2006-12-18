Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBIGOAnn024677
	for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2006 11:24:10 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBIGOjZo008705
	for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2006 16:24:46 GMT
Message-ID: <4586C0C5.4010502@hp.com>
Date: Mon, 18 Dec 2006 11:24:37 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] A bugfix patchset for NetLabel
References: <20061215214926.018950000@hp.com> <XMMS.LNX.4.64.0612151840370.26929@d.namei>
In-Reply-To: <XMMS.LNX.4.64.0612151840370.26929@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 15 Dec 2006, paul.moore@hp.com wrote:
>  
>>This patch set fixes two bugs that were found recently when adding new CIPSOv4
>>DOI definitions.  These patches are pretty small and have been tested by a few
>>different people on several different platforms.
> 
> Applied to git://git.infradead.org/~jmorris/selinux-2.6#fixes

Thanks.

>>Please apply these for 2.6.20 and they should probably be pushed to the 2.6.19
>>stable tree as well; is there anything special I need to do for that?
> 
> I'm not sure that they qualify.
> 
> The first is a privileged operation, right?

Yes it is, you need CAP_NET_ADMIN.  I guess this probably isn't that important
for 2.6.19 then ...

> For the second, what are the implications of mapping to zero?
> 
> Also review Documentation/stable_kernel_rules.txt.

[Thanks for the pointer, didn't know that file was there]

... however, I still think this might qualify for the 2.6.19 stable kernel.
When a MLS sensitivity level or category maps to zero then whenever the NetLabel
subsystem is called to resolve the security attributes of a packet it will, in
certain configurations, return security attributes/contexts which are incorrect.

Please let me know if you think that has merit for the stable tree and I'll send
the patch to the stable mailing list.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
