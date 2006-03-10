Message-ID: <4411D08A.7050600@hp.com>
Date: Fri, 10 Mar 2006 14:16:26 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Cc: James Morris <jmorris@namei.org>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Query MLS info outside of SELinux/LSM?
References: <4411AFCB.60401@hp.com>	 <1142010664.25454.128.camel@moss-spartans.epoch.ncsc.mil>	 <4411B5F2.6060702@hp.com>	 <1142012234.25454.139.camel@moss-spartans.epoch.ncsc.mil>	 <4411B9A9.5020102@hp.com>	 <1142013189.25454.152.camel@moss-spartans.epoch.ncsc.mil>	 <BDEE5CBC-F62F-4B14-BCD3-42B7215987DD@nall.com> <1142018132.25454.190.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142018132.25454.190.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-03-10 at 13:03 -0600, Joe Nall wrote:
> 
>>If there is a naming convention for system high you can ask for a  
>>translation of SystemHigh and look the the level and categories  
>>returned. Use of CIPSO could be dependent on certain names or aliases  
>>being available in setrans.conf.
> 
> I think he means his NetLabel kernel component, not a userspace
> component, so he isn't dealing with translations at all there.  Just the
> raw kernel representation.
> 

Yep, Stephen is correct.  It's academic at this point anyway as I've 
worked around it.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
