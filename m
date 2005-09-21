Message-ID: <433186CE.30007@cornell.edu>
Date: Wed, 21 Sep 2005 12:14:06 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
References: <200509202048.j8KKm4Ys001478@gotham.columbia.tresys.com>	 <43307A1D.3070806@cornell.edu> <1127312484.2550.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127312484.2550.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Then I think you need to hide this type aliasing and interface aliasing
>within libsemanage, and not make it visible in its public headers.
>
Ok, the records will be un-inlined as requested.

I'll also be adding an avrule record soon. Another planned record is one 
for the file_context format. This one is clearly semanage-only, since 
the file_contexts specification does not live in policy. I'm not sure 
how that will be used at this point, but I think it will become 
important when we have to deal with labeling home directories. In 
general, it would be nice to be able to edit the file_contexts 
programmatically (maybe clear dependencies after module removal - not 
sure how tresys deals with things like that currently...probably better 
to use per-module file_contexts).

>  And
>I'm still not clear whether libsemanage should be exporting these
>particular interfaces directly to its users, versus higher level
>interfaces that are internally implemented in terms of the libsepol
>primitives.  Do you expect libsemanage clients to be directly doing
>things like semanage_port_compare?
>  
>
Probably not, but those interfaces don't do any harm - now you can check 
whether two opaque records represent the same data element, without 
knowing their structure.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
