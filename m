Message-ID: <5194F142.2080600@tycho.nsa.gov>
Date: Thu, 16 May 2013 10:46:26 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Future of SETools and CIL
References: <5194E01F.2040505@tresys.com>
In-Reply-To: <5194E01F.2040505@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/16/2013 09:33 AM, Steve Lawrence wrote:
> Another discussion we would like to have, which may affect the future of
> SETools/apol, is CIL. Is there still interest in CIL? And if so, have
> there been any thoughts on using and migrating to CIL? Is more work
> needed before this can happen? Has anyone put thought into higher level
> languages that could sit on top of CIL? If there is interest, this may
> affect the SETools changes, for example, syntactic policy analysis for
> CIL is likely very different than current policy.

I am still interested in CIL. In fact, I just got CIL to work on a 
translation of Refpolicy from early 2012. (And by work I mean produce a 
binary policy equivalent, according to sediff, with the binary produced 
by the Refpolicy build.) I just started this week on trying it against a 
recent version of Refpolicy. There are some issues that I need to work 
through; the biggest being how to handle the optional parameters to 
filetrans_pattern() and filetrans_add_pattern(). I hope to make both the 
CIL translation of Refpolicy and my many modifications to CIL available 
shortly.

I am also interested in resurrecting the earlier policy toolchain work 
to convert to the use of source modules and allow the use of CIL for 
policy builds.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
