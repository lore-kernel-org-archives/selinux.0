Message-ID: <430C8309.9090507@redhat.com>
Date: Wed, 24 Aug 2005 10:24:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com>	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>	 <430C75B4.3020008@redhat.com> <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-08-24 at 09:27 -0400, Daniel J Walsh wrote:
>  
>
>>I still want at least the set_comp diff to allow me to set level to 
>>NULL, so it does not show up.
>>    
>>
>
>Hmm...I dropped the set_comp diff entirely from the original patch
>because I didn't want the change to allow whitespace in the context, as
>per our earlier discussion on the list.  I didn't notice that you were
>also changing it to allow NULL.  Potential issue there is that your
>change would allow setting a NULL for any field, whereas context_str
>won't handle a NULL gracefully in any field other than the last.
>
>  
>
Which is too bad since object_r is totally useless in ls output :^).    
Well we can either make sure it is that last field or not allow it.  As 
I play with MCS, I am not sure whether we want this info or not, my 
problem with this field and object_r is that they give no info and take 
up a lot of screen space.  (Although, probably an Engineer problem and 
not a real world problem.)

>With regard to clearing the context pointers on entry to the raw
>functions, I don't see why it is necessary given my earlier patch.
>
>  
>
Ok, you can forget about them.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
