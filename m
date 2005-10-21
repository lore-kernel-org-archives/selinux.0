Message-ID: <4359547D.3050001@cornell.edu>
Date: Fri, 21 Oct 2005 16:50:05 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Context interface cleanup
References: <43595049.2@cornell.edu>
In-Reply-To: <43595049.2@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> - removes the sepol_ prefix, which I use to indicate whether a 
> function is exported or not
Actually, can that still create a namespace conflict during static linking?
Would it make a difference if it was marked 'static' ?

What should I name all those things...
I want sepol_context_* to be reserved for the record that represents a 
context..
I wanted context_* for the internal structure, for consistency with 
other code (but the other code is static_inline...).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
