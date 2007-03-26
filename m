Message-ID: <4607E9AC.80408@redhat.com>
Date: Mon, 26 Mar 2007 11:41:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Refpolicy: allow netlabelctl to be run at boot
References: <20070309203327.709750017@hp.com> <20070309203513.357373998@hp.com> <1174922303.28830.24.camel@sgc> <200703261129.51045.paul.moore@hp.com>
In-Reply-To: <200703261129.51045.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Monday, March 26 2007 11:18:23 am Christopher J. PeBenito wrote:
>   
>> On Fri, 2007-03-09 at 16:33 -0400, Paul Moore wrote:
>>     
>>> Allow the NetLabel management tools to be run at boot from the init
>>> scripts.
>>>       
>> Is this actually a daemon or just a regular application?  If its not a
>> daemon it should be using init_system_domain() instead.
>>     
>
> Check our email from last Friday (3/23).  It's okay, it's Monday morning ;)
>
> I agree, knowing what I know now it should be init_system_domain(), there is 
> probably another change needed as this patch seemed to introduce a bug (or 
> flush out an old one) which Dan fixed in selinux-policy-2.4.6-47 for RHEL5.  
> Unfortunately, I can't get at the RPM right now (got a pointer Dan?) so I 
> can't do a diff and see what changed ...
>
> It is probably best to hold on this for now, sorry for the confusion, but I 
> was hoping to have the fix for this by now.
>
>   
RHEL5 and Rawhide policy are identical.  I have no problem changing to 
init_system_domain.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
