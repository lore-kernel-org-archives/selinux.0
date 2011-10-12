Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CDeUDB013567
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 09:40:30 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CDeSHv010271
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 13:40:29 GMT
Message-ID: <4E9598C0.9080700@tresys.com>
Date: Wed, 12 Oct 2011 09:40:16 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I am working to further shrink the size of policy in Fedora 17.
References: <4E8F43CE.7010605@redhat.com>
In-Reply-To: <4E8F43CE.7010605@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/07/11 14:24, Daniel J Walsh wrote:
> Right now, every domain that transitions to another domain gets the
> following rule written.
> 
>    dontaudit SOURCE TARGET : process { noatsecure siginh rlimitinh } ;
> 
> In Fedora 17 policy right now we have 2152 rules, out of Dontaudit:
>      9415
> 
> 
> sesearch --dontaudit -p noatsecure | wc -l
> 2152
> 
> We could rewrite this with one rule.
> 
> dontaudit domain domain:process { noatsecure siginh rlimitinh } ;
> 
> Of course this is more lenient then what we have now, although since
> it is dontaudit rules, not sure it matters.
> 
> Comments?

I'm on the fence.  On one hand, I hate to overspecify the policy, but on the other hand, these perms can only be hit on a domain transition.  How much does this save?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
