Message-ID: <44188541.9030809@redhat.com>
Date: Wed, 15 Mar 2006 16:21:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <rcoker@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problem with semodule mls policy
References: <44182410.1030003@redhat.com>	 <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>	 <44183A48.7010005@tresys.com>	 <1142440539.4933.6.camel@moss-spartans.epoch.ncsc.mil>	 <441842C2.8070706@tresys.com>	 <1142441886.4933.13.camel@moss-spartans.epoch.ncsc.mil>	 <44185659.3050403@tresys.com> <1142446762.4933.51.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142446762.4933.51.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-03-15 at 13:00 -0500, Joshua Brindle wrote:
>   
>> I can buy this, as well as nodecons having different levels. The strange 
>> thing is that you don't know what the levels are exactly, you just know 
>> their relationships to each other. ie: eth0 is s1 and eth1 is s5 so eth1 
>> is higher sensitivity even though I don't know what that sensitivity 
>> means. How big of an issue is this? Chad?
>>
>> writing down files of different levels from within libsemanage means any 
>> libsemanage client must be mls trusted, which may or may not be an 
>> issue, I'm not sure.
>>
>> So, if this is an issue then both seusers and policy.20 need to be 
>> labeled differently.. should this be done through libsemanage config or 
>> some appconfig in the policy?
>>     
>
> libsemanage could call matchpathcon and just use the returned context,
> as long as we guarantee an initial installed file_contexts file for
> bootstrapping.  semanage.conf is not an option I suppose since it now
> lives directly in /etc/selinux and is policy-independent.  
>
>   
If you don't have an initial file_contexts file at install time,  you 
are going to have a lot more problems than this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
