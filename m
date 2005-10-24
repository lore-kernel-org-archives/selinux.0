Message-ID: <435CF602.6060100@cornell.edu>
Date: Mon, 24 Oct 2005 10:56:02 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Context interface cleanup
References: <43595049.2@cornell.edu>  <4359547D.3050001@cornell.edu> <1130158079.17609.13.camel@moss-spartans.epoch.ncsc.mil> <435CF3F5.9040504@cornell.edu>
In-Reply-To: <435CF3F5.9040504@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>>
>> Note that libselinux provides context_* interfaces for context string
>> manipulation by security-aware applications (man context_new).
>>   
>
> Hmm... so many ways to represent a context!
>
> Should I be going the other way instead (i.e., leave sepol_ctx_struct 
> alone (but still do the other changes - move to internal header, 
> etc..)). Then in the future move context_* -> sepol_ctx_struct ?

Actually I think "hidden" is what I want... I've already marked the 
port/iface ones "static"... but the context functions have callers in 
multiple files.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
