Message-ID: <4384732F.90808@cornell.edu>
Date: Wed, 23 Nov 2005 08:48:31 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Check if policy file is MLS enabled
References: <438452BD.30101@cornell.edu> <43846B71.6000806@tresys.com>
In-Reply-To: <43846B71.6000806@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> A much better way to do this would be to extract the header reading 
> from policydb_read and make a helper function that does it. You will 
> still be able to do a partial parse of the binary but only 1 function 
> will have to be changed when a format change happens.
That's true.. will fix.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
