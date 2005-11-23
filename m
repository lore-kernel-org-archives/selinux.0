Message-ID: <43848B72.1010603@cornell.edu>
Date: Wed, 23 Nov 2005 10:32:02 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL] Remove defrole from sepol
References: <437EBD3A.7090606@cornell.edu>
In-Reply-To: <437EBD3A.7090606@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm starting to question the need for this interface at all... it's an 
interface for a very narrow user base - genhomedircon... which is 
probably a mistake. I would prefer genhomedircon to find its way into 
libsemanage, which is its only user (does it have another one?). Then 
there would be no reason for an external interface for default roles and 
hacks to move genhomedircon before one lock is released, and after the 
other is released, and things like that would not be necessary. 
Genhomedircon encapsulates an implementation detail of user/seuser 
updates. Is there another reason for it being outside libsemanage, other 
than python being easy to work with?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
