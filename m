Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3D7AKUC013175
	for <selinux@tycho.nsa.gov>; Mon, 13 Apr 2009 03:10:20 -0400
Received: from atoll.udmvt.ru (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3D7AIdr006644
	for <selinux@tycho.nsa.gov>; Mon, 13 Apr 2009 07:10:19 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n3D7AEX0052485
	for <selinux@tycho.nsa.gov>; Mon, 13 Apr 2009 12:10:16 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Mon, 13 Apr 2009 12:10:14 +0500
From: Alexey S <selinux@udmvt.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Alexey S <selinux@udmvt.ru>, James Carter <jwcart2@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Policy infrastructure problems and improvement
Message-ID: <20090413071014.GP9889@ruber.office.udmvt.ru>
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil> <20090410124318.GM9889@ruber.office.udmvt.ru> <1239367506.16752.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239367506.16752.3.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 10, 2009 at 08:45:06AM -0400, Stephen Smalley wrote:
> On Fri, 2009-04-10 at 17:43 +0500, Alexey S wrote:
> > ...
> > And if libqpol-based tools would be able to use that mapping when displaying
> > their results.
> > Otherwise it is too confusing to see @ttr0121 instead of domain_type during policy
> > analysis, especially when numbers change after module (re|un|)load.
> 
> policy.24 already makes this change (preservation of attribute names in
> the types symtab in the final kernel policy).
Great! I really missed that thing. I have ever tried to hack policy compiler to
write the attributes mapping to the stderr...

> 
> You can however already see the attribute names with policy < 24 by
> running apol and friends on the modular policy rather than the final
> kernel policy.
There are some use-cases where there is no modules on the local machine.
And thus the policy is not "managed". And still it is not complete and needs
some analysing/understanding.
By the way, is it impossible to add some cryptographics signature to the binary policy
(and perhaps to the modules)? I would like to block REloading of policies without proper
signature (btw, it is very useful in the mentioned use-cases). I think it is some
infrastructure piece that is missing too.



-- 
Alexey S

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
