Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BEPgTO011550
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 10:25:42 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BEP24H011393
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 14:25:02 GMT
Message-ID: <4AAA5DDC.7060403@redhat.com>
Date: Fri, 11 Sep 2009 10:25:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Elia Pinto <andronicus.spiros@gmail.com>
CC: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: Re: Policy file and Selinux Policy question
References: <51af93b70909110541w1bef874h22931a6421388028@mail.gmail.com>
In-Reply-To: <51af93b70909110541w1bef874h22931a6421388028@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/11/2009 08:41 AM, Elia Pinto wrote:
> In creating an selinux policy i can define the type of policy (strict,
> targeted, MLS and a custom : e,g make NAME=selinuxvariant -f
> /usr/share/selinux/devel/Makefile) to which the policy file has to be
> applied.
> 
> But given  a policy file (policy.pp) as it is possible to understand via
> some API interface at which policies the policy file relate ? In other
> words, it is redundant to have the information elsewhere on the type of
> policy to which the policy file you referring to? Also the information that
> the policy file is a base or loadable policy is in policy file ? If yes, how
> to inquiry via selinux API ?
> 
> Thanks a lot  in advance
> 
I guess the question I would raise, is what is varying between the policies that you feel is necessary.

option_policy(
)
Should handle the case where an interface is different.  The only case I currently know of where you migh vary is on 
file context MLS Level.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
