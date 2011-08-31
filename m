Subject: Re: CentOS 5 RBAC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Roy Badami <roy.badami@roboreus.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E5E68DB.1030101@roboreus.com>
References: <4E5E68DB.1030101@roboreus.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Aug 2011 13:24:44 -0400
Message-ID: <1314811484.6850.30.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-31 at 18:01 +0100, Roy Badami wrote:
> Just out of interest, I then went and tried the strict policy.  Yet this 
> policy doesn't even have a secadm_r and again I don't understand why.  
> The specfile builds it with NAME=strict TYPE=strict-mcs and from my 
> reading of the makefile an -mcs policy should again set enable_mls.    
> And kernel.ke continas the following, so I don't quite see why the 
> policy doesn't end up containing these roles.
> 
> ifdef(`enable_mls',`
>          role secadm_r;
>          role auditadm_r;
> ')

At least in the policy sources I am looking at, a policy type that
includes the mcs suffix causes the policy to be built with -D
enable_mcs, not -D enable_mls.  Thus those roles don't get included in
the mcs policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
