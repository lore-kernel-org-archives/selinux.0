Message-ID: <466724DE.4010302@manicmethod.com>
Date: Wed, 06 Jun 2007 17:19:26 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: vyekkirala@TrustedCS.com, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com> <200706061537.49417.paul.moore@hp.com> <466719B7.6090003@manicmethod.com> <200706061648.37402.paul.moore@hp.com>
In-Reply-To: <200706061648.37402.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Wednesday, June 6 2007 4:31:51 pm Joshua Brindle wrote:
>   
>>> The proposal here is to introduce a static external label for single
>>> label networks where the remote domain is not explicitly labeling it's
>>> network traffic.  This is a common request from people with existing
>>> trusted OS installations and would be a nice compliment to the existing
>>> labeling mechanisms, both internal and external.
>>>       
>> Is this info going to be stored in the policy ala ocontexts? How are you
>> planning to manage it? Adding it to libsemanage and semanage seems like
>> the best route to take here.
>>     
>
> As I envision it right now this new static external label would be managed via 
> NetLabel (it is a framework after all, not just CIPSO) so we wouldn't need to 
> introduce any more per-packet access checks, similar to how 
> iptables/netfilter manages the SECMARK labels.  The impact to the SELinux 
> kernel code should be quite minimal using this approach.
>
> Policy integration is still open in my mind, although considering the lessons 
> learned from integrating the SECMARK iptables commands into policy I wonder 
> if we are best off leaving the labeling details out of the policy itself and 
> leaving it in the hands of the NetLabel tools and perhaps libsemanage.
>   
I'm fine with that, I didn't even think about the netlabel tools 
handling it (possibly because I never used them ;) )

The unfortunate part is that we are going to have all these systems for 
managing different kinds of external labels, it would be nice if there 
was a centralized management system, even if the backends are spread all 
over the place. I don't mean a GUI here either (not that a GUI would be 
bad) but more along the lines of a central management library that can 
handle it all that a GUI could later use. I'm not sure if libsemanage is 
the place for this either, particularly with ipsec where management 
really means updating SPD entries to have contexts, I don't know how 
people currently manage SPD entries so I'm not sure where we can 
interject ourselves without disturbing users..

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
