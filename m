Message-ID: <46FBF229.4030609@manicmethod.com>
Date: Thu, 27 Sep 2007 14:10:49 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 1/2] [SELINUX] Add a capabilities bitmap to	SELinux
 policy version 22
References: <20070926212810.15998.58788.stgit@flek.americas.hpqcorp.net>	 <20070926213218.15998.48463.stgit@flek.americas.hpqcorp.net>	 <46FADC17.8070606@manicmethod.com> <1190893010.27038.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190893010.27038.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-09-26 at 18:24 -0400, Joshua Brindle wrote:
>   
>> Paul Moore wrote:
>>     
>>> Add a new policy capabilities bitmap to SELinux policy version 22.  This bitmap
>>> will enable the security server to query the policy to determine which features
>>> it supports.
>>> ---
>>>
>>>  security/selinux/include/security.h |   15 +++++-
>>>  security/selinux/selinuxfs.c        |   90 +++++++++++++++++++++++++++++++++--
>>>  security/selinux/ss/policydb.c      |   18 +++++++
>>>  security/selinux/ss/policydb.h      |    2 +
>>>  security/selinux/ss/services.c      |   39 +++++++++++++++
>>>  5 files changed, 158 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>>> index 83bdd4d..d7e6ed2 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -25,13 +25,14 @@
>>>  #define POLICYDB_VERSION_MLS		19
>>>  #define POLICYDB_VERSION_AVTAB		20
>>>  #define POLICYDB_VERSION_RANGETRANS	21
>>> +#define POLICYDB_VERSION_CAPBITMAP	22
>>>  
>>>   
>>>       
>> I didn't like this name (I almost used it myself) because it sounds like 
>> we are doing something with linux capabilities, I ended up using 
>> POLICYDB_VERSION_PCAPS (for policy capabilities)
>>     
>
> Doesn't help much; PCAP sounds like process capabilities, and
> CAP_SETPCAP ;)  I don't think the name matters either way.
>
>   

Fair enough, I'll just use what Paul does next time he releases a 
patchset (no pressure on you to pick the perfect name Paul ;) )

>>>  /* Range of policy versions we understand*/
>>>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>>>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>>>  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>>>  #else
>>> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
>>> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_CAPBITMAP
>>>  #endif
>>>  
>>>  struct netlbl_lsm_secattr;
>>> @@ -39,8 +40,19 @@ struct netlbl_lsm_secattr;
>>>  extern int selinux_enabled;
>>>  extern int selinux_mls_enabled;
>>>  
>>> +/* Policy capabilities */
>>> +enum {
>>> +	POLICYDB_CAPABILITY_NETPEER,
>>> +	__POLICYDB_CAPABILITY_MAX
>>> +};
>>> +#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>> +
>>>   
>>>       
>> Hrm, I just used an ebitmap and didn't set a max at all.
>>     
>
> ebitmaps are a security server internal construct; you have to export
> them in a different form to users of the security server, like
> selinuxfs, the hook functions, etc.  Or you'd have to move them out a
> layer.
>
>
>   

Oops, yea, I forgot that ebitmaps were private to the security server, 
disregard all comments pertaining to them :)


>> Shouldn't this just check if policyvers > POLICYDB_VERSION_CAPBITMAP? it 
>> could be inlined too.
>>     
>
> It can't be inlined as it is a security server interface.
>
> I suppose you could check the version first to see if it is < 22 and
> always return 0 in that case without having to take the rdlock.
>
> You could also extract the first word of the bitmap to a simple unsigned
> long in the policydb at load time and do a direct bit test on it if
> req_cap < (sizeof(unsigned long) * 8), without taking policy rdlock.
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
