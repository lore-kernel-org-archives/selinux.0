Message-ID: <4FD255F9.4030904@tresys.com>
Date: Fri, 8 Jun 2012 15:43:53 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] Add SELinux policy capability for always checking
 packet class.
References: <1339093682-5113-1-git-send-email-cpebenito@tresys.com> <2776660.gCfiz8ed08@sifl> <4FD2445C.3070704@tresys.com> <20928751.8CTdyDzEWU@sifl>
In-Reply-To: <20928751.8CTdyDzEWU@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/08/12 14:55, Paul Moore wrote:
> On Friday, June 08, 2012 02:28:44 PM Christopher J. PeBenito wrote:

>>>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>>>> index 3ad2902..cb893f9 100644
>>>> --- a/security/selinux/selinuxfs.c
>>>> +++ b/security/selinux/selinuxfs.c
>>>> @@ -44,7 +44,8 @@
>>>>
>>>>  /* Policy capability filenames */
>>>>  static char *policycap_names[] = {
>>>>  
>>>>  	"network_peer_controls",
>>>>
>>>> -	"open_perms"
>>>> +	"open_perms",
>>>> +	"always_check_network"
>>>>
>>>>  };
>>>
>>> Similarly, I think "network_always" is more consistent.
>>
>> Earlier discussions concluded with this capability name.  (to be specific
>> the discussion resolved with always_check_packets, but that was before the
>> peer class was included)
> 
> Once again, I don't believe I ever commented on the name of the capability, 
> but I am now.  Disregard my comments or incorporate them, that is up to you, 
> and ultimately Eric, to decide.

My apologies, you did not comment on the capability name in the previous thread.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
