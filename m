Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84BM2rT013607
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 07:22:03 -0400 (EDT)
Message-ID: <4139A554.9020604@redhat.com>
Date: Sat, 04 Sep 2004 07:21:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Please review openssh patch for selinux
References: <200408241818.40064.russell@coker.com.au>	 <41371628.2020408@redhat.com>	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>	 <200409022338.20644.russell@coker.com.au>	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>	 <413741A3.3070305@redhat.com>	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>	 <41377927.3080703@redhat.com>	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>	 <41377E8A.2030707@redhat.com> <1094215690.19206.73.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094215690.19206.73.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-09-02 at 16:11, Daniel J Walsh wrote:
>  
>
>>New SSH patch.
>>
>>Provides the capability of doing
>>
>>ssh hostname -l root/sysadm_r
>>
>>suggested by Collin. 
>>
>>I used the / instead of : to preserve the BSD syntax.
>>    
>>
>
>As per the earlier discussion on the list, I think we want a new
>libselinux function similar to get_default_context() that also takes the
>optional role, and rather than simply substituting the role (if
>specified) and its default type, it would check the array returned by
>get_ordered_context_list for the first entry that matches the role and
>return the entry or fail if no such entry exists.  That would ensure
>that we immediately abort if the role is not reachable by sshd, and also
>allow an admin to prevent use of this feature for a given role simply by
>not listing it in the sshd entry in defualt_contexts.
>
>  
>
Ok, can you create the function?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
