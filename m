Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OMjaRb026876
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 17:45:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OMi1lK017970
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 22:44:01 GMT
Received: from lakemtao08.cox.net (lakemtao08.cox.net [68.1.17.113])
	by jazzswing.ncsc.mil  with ESMTP id i1OMi1OX017967
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 22:44:01 GMT
Message-ID: <403BD40A.4010200@snu.edu>
Date: Tue, 24 Feb 2004 16:45:30 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: =?UTF-8?B?TWFnb3PDoW55aSDDgXJww6Fk?= <mag@bunuel.tii.matav.hu>,
   James Morris <jmorris@redhat.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [selinux] Re: identity
References: <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>	 <1077634629.21221.80.camel@moss-spartans.epoch.ncsc.mil>	 <1077653032.22405.36.camel@kusturica> <1077655261.21221.191.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1077655261.21221.191.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2004-02-24 at 15:03, Magosányi Árpád wrote:
> 
>>I tend to view "auditing framework" as a subset of "security framework",
>>and think that separating access control and audit is either unfeasible
>>or impossible, given that most of the stuff to be audited is access
>>control decision. Plus the access control logic can benefit from the
>>additional data which should be available for auditing purposes.
>>First it is a PITA that one have to dig out file name or IP address,
>>but you will soon realise that you can do access control decisions
>>based the data just mined out if you want.
>>
>>On the other hand, there are some data (those which have to be used
>>for access control decisions) which should be dug out twice if you
>>want to separate auditing from access control.
>>
>>And on the third hand:
>>Just tell me that FAU_GEN is not an aim of SELinux, and I will forget
>>the project forever.
> 
> 
> An aim of SELinux itself?  No.  See the overview
> (http://www.nsa.gov/selinux/), FAQ  
> (http://www.nsa.gov/selinux/faq.cfm#I12), and prior postings to this
> list on the topic of auditing, e.g.
> http://marc.theaimsgroup.com/?l=selinux&m=97907408104978&w=2.  We agree
> that auditing is important, and would encourage integration of SELinux
> with an auditing framework (which can benefit both SELinux and the
> auditing framework), but SELinux itself is not intended to meet auditing
> requirements.  Note that LSM cannot meet auditing requirements, and the
> right solution is not to bloat LSM into a universal hook framework but
> instead to provide a separate framework for auditing.  The additional
> state requested by Russell (including an immutable user identity for
> audit records) belongs in an audit context, not the SELinux context.
> 

On this note, are any of the selinux distro guys looking at integrating 
any specific auditing framework with selinux? We've looked at SAL a 
while back but it was very unsuitable at the time, and have plans to 
look at snare, are there others? If someone is alreay working on this 
let me know as I'd like to help.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
