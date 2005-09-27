Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RGpWNs026570
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:51:32 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RGk6pk026887
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 16:46:06 GMT
Message-ID: <43397960.5070905@cornell.edu>
Date: Tue, 27 Sep 2005 12:54:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: selinux@tycho.nsa.gov, "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage-functionality 4/17
References: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com>
In-Reply-To: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

\Karl MacMillan wrote:

>This patch adds semanage.h - this is the new public interface for
>libsemanage.
>  
>
Why is it that you have to keep re-adding the components that I'm 
currently working on. Please leave those out of the semanage.h header 
for now. If you don't approve of my APIs, then you should submit patches 
on top of them, instead of introducing duplicate work. Anything that 
says semanage_mls_* semanage_user_*, semanage_boolean_*, and 
semanage_homedir_* should be left out for now.

1) Users - those will be handled via the user_record data structure, 
which is already in CVS. The implementation is in sepol, but I've 
uninlined the data structure, so the API is now opaque.

2) Booleans - those will be handle via the boolean_record data 
structure. I have no included that in semanage yet, because I'm still 
testing how other records (like the user record) will work, but you can 
look at the data structure in sepol.

3) Homedirs - this part of the API is too unclear to add at this point 
(at least, it's not clear to me yet, and I'll probably be implementing it..)

P.S. Your semanage header should likely draw in my user/port/record 
headers, but please don't do this yet, as those interfaces are in flux. 
Also, I think the handle stuff and the module stuff should go into 
separate headers, and you should include those into semanage.h.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
