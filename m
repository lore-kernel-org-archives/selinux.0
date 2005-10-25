Message-ID: <435E56CD.9030003@cornell.edu>
Date: Tue, 25 Oct 2005 12:01:17 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Further users cleanup
References: <435903C2.2050805@cornell.edu>	 <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>	 <4359199A.40303@cornell.edu>	 <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil> <1130252431.17609.326.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130252431.17609.326.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-10-21 at 13:38 -0400, Stephen Smalley wrote:
>   
>> Also need to fix this:
>> $ relinfo.pl src/libsepol.so.1
>> src/libsepol.so.1: 68 relocations, 61 relative (89%), 94 PLT entries, 60 for local syms (63%), 0 users
>>
>> There shouldn't be any for local syms; need to bring over dso.h and
>> hidden_def/hidden_proto stuff from libselinux.
>>     
>
> Attached patch does this for the sepol_bool functions used internally by
> libsepol. 
I'm confused, the bool_record is supposed to be exported out of sepol... 
it's shared with semanage. That could change, based on the current 
discussion of sharing records... but I wasn't sure if that's what you 
intended.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
