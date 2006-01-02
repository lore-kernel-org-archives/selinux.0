Message-ID: <43B9761A.3070504@cornell.edu>
Date: Mon, 02 Jan 2006 13:51:06 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
   dwalsh@redhat.com
Subject: Re: [SEMANAGE][SEPOL] Enable ports
References: <43ACADB3.7070509@cornell.edu> <43B97823.3080201@tresys.com>
In-Reply-To: <43B97823.3080201@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>>
>> This brings up an interesting point - if ordering of records matters, 
>> then some thought should go into which way iterate() loops over the 
>> records... (and what order list() returns). Currently for files, the 
>> ordering is backwards to what appears in the file (not sure what 
>> policydb does).
>>
>
> This should be fixed. the policy parser (policy_parse.y) currently 
> preserves the order exactly as specified, with errors in the case of 
> duplicate or shadowed entries.

I think the order in policy should be correct after my list reversal 
patch (see other patches).
The order in the on-disk file is irrelevant for ports - it's just an 
implementation detail of the library.
More detail on this in my other message in response to File Contexts APIs.

>
> I think a good workaround for now is to only expose exact port 
> labeling via libsemanage, that way you can prepend them to the 
> policydb list and not worry about sorting, etc. If the user needs to 
> set multiple ports the client can expose that functionality, and 
> limited intelligence can be added there (error checking and such). the 
> policydb portcons would still have ranges so the fallbacks (1-1024, 
> etc) would still be there.
I think sorting should work after the list reversal patch. It has some 
drawbacks as I've pointed out there, but should work. Adding the 
"limited intelligence" with respect to error checking is much more 
difficult in libsemanage, and I've wasted lots of time on this. It's 
easier to do in the client.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
