Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJEt6Rb012175
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 09:55:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBJEsFjx015679
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 14:54:15 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
	by jazzswing.ncsc.mil  with ESMTP id hBJEs2SR015665
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 14:54:02 GMT
Message-ID: <3FE31239.3090209@tresys.com>
Date: Fri, 19 Dec 2003 09:59:05 -0500
From: "David A. Caplan" <dac@tresys.com>
MIME-Version: 1.0
To: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>
CC: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Subject: Re: Domain Transitions (or the Exim4 policy)
References: <20031219024548.GA24510@cm.nu>	<200312191647.45107.russell@coker.com.au> <20031219070905.GA32075@cm.nu>
In-Reply-To: <20031219070905.GA32075@cm.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shane Wegner wrote:
>
>  it does indeed transition to user_mail_t though
> I can't figure out how.  

For future reference, I'd suggest the Reverse Domain Transition analysis 
function in apol (http://www.tresys.com/selinux/) to easily find the 
exact rules in policy.conf that allow a domain to transition to the 
domain in question.

In regard to your other question:
 > I'm seeing user_mail_domain in policies
 > but don't see user_mail_t anywhere save a minor mention
 > in attrib.te.

You can also use apol to find all TE rules related to a type and include 
those rules using the type's attributes by using the Include Indirect 
Matches option under the Policy Rules tab in apol.  The search results 
also provide hyper links into policy.conf so you can trace back where 
the rules came from.  The Policy Components tab can show you all the 
types that use a given attribute.

David
-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
