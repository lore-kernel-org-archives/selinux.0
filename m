Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9IDFWNs008310
	for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2005 09:15:32 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9IDCbqp028896
	for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2005 13:12:37 GMT
Message-ID: <4354F4DB.5000805@tresys.com>
Date: Tue, 18 Oct 2005 09:12:59 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Dynamic discover of object classes
References: <200510171328.30452.csellers@tresys.com> <Pine.LNX.4.63.0510171649190.24028@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.63.0510171649190.24028@excalibur.intercode>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Mon, 17 Oct 2005, Chad Sellers wrote:
> 
> 
>>We would like to begin implementing option 1, as this seems to be the 
>>cleanest.  Any feedback would be appreciated.
> 
> 
> selinuxfs sounds cleaner.  There's no guarantee that there will be a 
> binary policy on disk.
> 
> Also, what about some form of namespace separation for different object 
> managers?
> 
> 
> - James

The class namespace supports the dot notation, though there is no 
hierarchy definition in that namespace. That would allow all the X 
classes to be X.<something>. This would give the additional advantage of 
being able to label all the X classes with the same type using policycon 
(for the policy server).

The policy server already uses the dot notation to seperate all of its 
object classes (policy.type, policy.user and so on).

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
