Message-ID: <42C2F865.2040102@redhat.com>
Date: Wed, 29 Jun 2005 15:37:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Execmem boolean
References: <1119822163.4357.9.camel@localhost.localdomain>	 <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>	 <42C2DB70.2070204@redhat.com>	 <1120070997.3553.172.camel@moss-spartans.epoch.ncsc.mil> <1120071263.20484.45.camel@celtics.boston.redhat.com>
In-Reply-To: <1120071263.20484.45.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>> Strict policy likely
>>shouldn't allow execmod to anything but texrel_shlib_t, and can thus
>>omit the boolean altogether.
>>    
>>
>
>Please don't break strict policy :(
>
>I still have some hope left to be able to 
>run it on my home machine. The level of "strictness"
>should be configurable.
>
>  
>
>We could kill the allow_execmod/allow_execmem booleans,
>allow execmod to texrel, allow exemem for X,
>  
>
Ok.
Should be a boolean allow_X_execmem.  Most people don't need execmem for 
X.  (Only nvidia binary drivers)

>and then have per app booleans for other things we don't trust
>(like Java applets?). 
>
>
>
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
