Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jASGlOMA005379
	for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2005 11:47:24 -0500 (EST)
Received: from lon-del-02.spheriq.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jASGhE7d012217
	for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2005 16:43:15 GMT
Received: from lon-out-01.spheriq.net ([195.46.50.129])
        by lon-del-02.spheriq.net with ESMTP id jASGht1I003950
        for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2005 16:43:55 GMT
Received: from lon-cus-01.spheriq.net (lon-cus-01.spheriq.net [195.46.50.37])
        by lon-out-01.spheriq.net with ESMTP id jASGhswa018365
        for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2005 16:43:54 GMT
Message-ID: <438B3418.2070600@st.com>
Date: Mon, 28 Nov 2005 17:45:12 +0100
From: Guillaume PETITJEAN <guillaume.petitjean@st.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: link between roles and domains
References: <438183C1.5070403@st.com> <1133192777.348.117.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133192777.348.117.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for your answer.

It's basically what I understood and I'm still missing something : in 
the example policy (may be it is not representative of a real system ?) 
there are very few role transitions. And domain transition rules don't 
take into account the role. Then it seems to me that once a process has 
been associated the first time to a domain (the domain of the first 
security context in the default_contexts list) its role isn't used 
anymore since only domain transitions occur. Or do roles only aim to 
define the first domain of a process ?
Where is my mistake ?

Cheers,
Guillaume

Stephen Smalley wrote:

>On Mon, 2005-11-21 at 09:22 +0100, Guillaume PETITJEAN wrote:
>  
>
>>Hello,
>>
>>I'm new to SELinux.
>>
>>I have a question regarding the management of users and roles.
>>
>>I understood that a user is associated with a role (or several roles) 
>>and that each role is allowed to enter a set of domain. I understood  
>>how access control permissions are defined on couple of domains and the 
>>process of domain transitions. But I didn't understand which domain 
>>(among the set of domains allowed for a role) is selected at any time.
>>
>>In other terms let's say you have a process foo belonging to the role 
>>user_r and suppose user_r is allowed for (domain1_t, domain2_t, 
>>domain3_t), how does the policy decides to which domain will belong the 
>>process in practice in order to compute security decisions ?
>>    
>>
>
>The security context of a user process is set up by some "entrypoint"
>program, like login or sshd, by querying libselinux for an ordered list
>of reachable security contexts from the entrypoint process for the user.
>libselinux consults the kernel security server via selinuxfs as well as
>a default_contexts configuration to generate and order this list.  The
>kernel security server computes reachability based on process transition
>permission from the context of the entrypoint process to contexts for
>the user.
>
>Once the security context has been initially set for the user process,
>any subsequent domain transitions are governed by the policy based on
>the usual (file:execute, process:transition, file:entrypoint) triple.
>Any accesses by a process are governed by the domain stored in its
>security context.  A process may only have a single domain in its
>security context at any given time.
>
>  
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
