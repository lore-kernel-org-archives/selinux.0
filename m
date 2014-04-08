Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s386hAK8027683
 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2014 02:43:10 -0400
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id D63D85E120
 for <selinux@tycho.nsa.gov>; Tue,  8 Apr 2014 02:43:13 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id LZqzm79vY1aT for <selinux@tycho.nsa.gov>;
 Tue,  8 Apr 2014 02:43:12 -0400 (EDT)
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id 701595E10A
 for <selinux@tycho.nsa.gov>; Tue,  8 Apr 2014 02:43:12 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id 4mpR0QU1pkjz for <selinux@tycho.nsa.gov>;
 Tue,  8 Apr 2014 02:43:11 -0400 (EDT)
Received: from rhea.itechfrontiers.com ([10.7.14.47])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: cto@itechfrontiers.com)
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTPSA id EC3165DC57
 for <selinux@tycho.nsa.gov>; Tue,  8 Apr 2014 02:43:10 -0400 (EDT)
Message-ID: <53439A94.2040701@itechfrontiers.com>
Date: Tue, 08 Apr 2014 02:43:32 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What do you mean by a 'domain'.
References: <53426EC3.6020109@gmail.com> <5342920B.3030308@tycho.nsa.gov>
In-Reply-To: <5342920B.3030308@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>




-- 
  Patrick K. Kashi, PhD
  CTO


On 4/7/2014 7:54 AM, Stephen Smalley wrote:
> On 04/07/2014 05:24 AM, dE wrote:
>> Hi!
>>
>> Sorry for the trival question; but on reading various SELinux resources,
>> it appears everyone talks about some 'domain' but no one defines what is
>> it.
>>
>> So I wanna what what is a domain in SELinux.
>
> See:
> http://www.nsa.gov/research/_files/selinux/papers/policy2/x86.shtml
>

The definition of the term "domain" in "Type Enforcement model" is 
security context and attributes assigned to a process BUT not 
necessarily in SELinux:

SELinux internally won't care about domain, it uses type for that matter.

Would you mind to correct me, if I'm wrong?

above document asserts:

QUOTE:
" ... Although the example TE configuration often uses the term domain 
when referring to the type of a process,

the SELinux TE model does not  internally distinguish domains from types."

UNQOUTE


Best regards,


Patrick K.
