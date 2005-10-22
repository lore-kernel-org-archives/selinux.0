Message-ID: <435A110C.7010707@cornell.edu>
Date: Sat, 22 Oct 2005 06:14:36 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Context interface cleanup
References: <43595049.2@cornell.edu> <4359547D.3050001@cornell.edu>
In-Reply-To: <4359547D.3050001@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> - removes the sepol_ prefix, which I use to indicate whether a 
>> function is exported or not
> Actually, can that still create a namespace conflict during static 
> linking?
> Would it make a difference if it was marked 'static' ?
>
> What should I name all those things...
> I want sepol_context_* to be reserved for the record that represents a 
> context..
> I wanted context_* for the internal structure, for consistency with 
> other code (but the other code is static_inline...).
Allright - well I still don't know if this namespace issue is a problem, 
but:

- the other changes are valid (like hiding those functions in an 
internal header, and removing services.c relay), and
- this is more consistent with the rest of the code - in other words, if 
the prefix is changed in one place, it should likely be changed 
everywhere instead (so context_cpy -> [new_prefix]_cpy, instead of only 
changing those new functions to something else).
- I want to write more patches over the weekend based on this one

So, let me know what you want to do, and if necessary I'll send a 
followup patch to set naming to the right thing.
In the meantime - there's other things to fix.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
