Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JNmRrT014393
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 19:48:27 -0400 (EDT)
Received: from sccrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JNlT2w002560
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 23:47:29 GMT
Message-ID: <414E1AC3.2070209@gentoo.org>
Date: Sun, 19 Sep 2004 19:48:19 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux <selinux@tycho.nsa.gov>,
   "pebe >> Chris PeBenito" <pebenito@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
References: <414DA0A7.1000708@gentoo.org> <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org> <200409200729.50087.russell@coker.com.au>
In-Reply-To: <200409200729.50087.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Mon, 20 Sep 2004 07:11, Joshua Brindle <method@gentoo.org> wrote:
>  
>
>>goal is to make the system secure, and if need be break legacy
>>behaviour. These are radical differences.
>>    
>>
>
>In Red Hat we are breaking legacy behaviour when necessary.  For example by 
>moving away from FAM.
>
>  
>
I wouldn't call FAM legacy behavior.. having something for one release 
and cutting it means it was a mistake, not legacy. The legacy behavior I 
speak of is the sentiment that sysadm should be able to modify files all 
over the system, and users should be able to use any/all resources on 
the machine, etc, etc. The stuff that the targeted policy avoids 
altogether thus preserving said legacy behavior. There are numerous 
instances of this sort of thing in the strict policy as well (like 
widespread (ab)use of sysadmfile).

>>The Current CVS policy is heavily biased toward Redhat (and their
>>SELinux goals). This leaves no room for others (such is why I'm
>>suggesting this)
>>    
>>
>
>I was writing SE Linux policy for Debian long before anyone who was employed 
>by Red Hat was doing any SE Linux work.  Now I work for Red Hat writing SE 
>Linux policy and write Debian policy in my spare time.
>
>  
>
The policy was slanted toward Redhat long before you started working 
there. When I started using SELinux there were already policies for 
Redhat apps like anaconda, all packages were available primarilly as 
rpm's, etc.

>I don't think that distributions other than Red Hat are being squeezed out.
>
>  
>
I didn't say that, but I am saying that the changes we desire to make 
are not ones Redhat would be interested in and therefore would not get 
included in the upstream policy.
(except perhaps as distro tunables which I've already said I believe are 
flawed)

>The Debian goals are closer to Gentoo goals than that of Fedora.  For example 
>there is no targeted policy in Debian.
>
>  
>
Thats great, then having the Gentoo policy in a more centralized place 
that is accessible would be helpful to you in your capacity as Debian 
policy writer.

>>>OK, try maintaining a separate Gentoo policy patch for another year or so
>>>and see if you still think that distribution specific tunables are a bad
>>>idea.  ;)
>>>      
>>>
>>PeBenito has maintained our policy for longer than that.  Distro
>>tunables (and indeed many many of the current tunables) are
>>fundamentally flawed.
>>Think about the difficulty of analyzing policy with X number of
>>tunables. To do it properly you'd have to analyze X! permutations. Then
>>take into account conditionals, and optional modules.
>>    
>>
>
>To be pedantic it would be 2^X not X!.
>  
>
oops, I don't know what I was thinking :) 2^X is what I meant.

>But you don't need to analyse those combinations.  The people who make the 
>distribution need to analyse the default options and the recommended 
>configurations (of which there should be a small number), and anyone who 
>wants to customise their policy has to analyse it themself.
>
>  
>
If you want to be comprehensive in the analysis of the policy yes you 
would need to analyze them all. If you are unwilling to analyze certain 
tunables they should not exist.

>>>The problem is that vendors will introduce bad patches.  Without the
>>>requirement to get the policy checked off by Steve the quality will drop
>>>while the number of unmerged patches steadily increases.
>>>      
>>>
>>eh? vendors would introduce bad patches to their own policy. Obviously
>>this can already be done, I'm not sure what you are getting at here.
>>    
>>
>
>If the difference between the vendor policy and the NSA policy is small then 
>there is less scope for error.
>
>  
>
The same argument could be held for the kernel (and is probably more 
dangerous)  but the FC2 kernel ...
3008 files changed, 183715 insertions(+), 106139 deletions(-)

>>If vendors are concerned about their patches they'd still be able to
>>post them to the list (also the changesets would be available at a
>>specific central place for everyone so it would be far easier to see
>>what people are doing to the policies, and the differences, etc)
>>    
>>
>
>How big are the patches between the Gentoo policy and the NSA policy?
>
>  
>
I'm not totally sure at this moment, Chris will have to say something here
We do have the desire to make sweeping changes to the current policy 
however, these changes would not be possible to merge into the upstream 
policy (though past feedback here suggests they wouldn't be appreciated 
anyway)

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
