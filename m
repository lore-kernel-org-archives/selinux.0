Message-ID: <4411B5F2.6060702@hp.com>
Date: Fri, 10 Mar 2006 12:22:58 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Query MLS info outside of SELinux/LSM?
References: <4411AFCB.60401@hp.com> <1142010664.25454.128.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142010664.25454.128.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-03-10 at 11:56 -0500, Paul Moore wrote:
> 
>>Is there a way to query the number of MLS sensitivity levels and 
>>categories outside of the SELinux LSM?  I haven't seen anything, but 
>>thought I would ask before I started looking at alternatives ... which 
>>brings me to my next question - would anyone have an objection to adding 
>>this functionality?
> 
> The goal is to keep information about the specific security models
> encapsulated in the security server (security/selinux/ss/*.c).  The rest
> of the SELinux code then remains policy-independent, as does the rest of
> the kernel.
> 

The only concern I have with the above statement is that in some cases, 
i.e. labeled networking, some of that security model information such as 
MLS limits is important outside the security server.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
