Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MJnrgA009184
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:49:53 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MJiHKk008360
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 19:44:17 GMT
Message-ID: <42E14CB5.6020402@tresys.com>
Date: Fri, 22 Jul 2005 15:44:53 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Dropping unused booleans
References: <1122061096.13068.152.camel@sgc.columbia.tresys.com>
In-Reply-To: <1122061096.13068.152.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>While testing reference policy, I realized that there are booleans that
>weren't being used -- they were declared but not actually used in an
>if() statement.  In my case, I was testing a targeted policy, and all of
>the policies that did use the booleans were excluded.  It seems that
>this is a bad thing.  Since conditional policy is used as a
>configuration for setting, it provides the system operator/admin with an
>option which has no effect, and thus is extremely misleading.  It seems
>especially important to not have useless options showing up since this
>affects operators, which may know nothing about the policy.
>
>I think the best place to happen would be in checkpolicy/libsepol, since
>it has the complete policy's true and false lists for each bool.  It
>would drop the boolean and throw a non-fatal warning message.  Thoughts?
>  
>
I think this is correct, this sounds like something post-expand since a 
module could declare a boolean that is used by another module (therefore 
you can't determine unused booleans until after linking and expanding)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
