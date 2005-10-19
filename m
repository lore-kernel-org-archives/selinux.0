Message-ID: <4355954C.9080206@cornell.edu>
Date: Tue, 18 Oct 2005 20:37:32 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu>
In-Reply-To: <43559474.1080905@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oh... and if we'll only be loading things into the policy by rebuilding, 
should I drop the del_user function from sepol?
(and either the add or modify one?)

If we only support one type of load function - should be called "load," 
or should it correspond to the semanage definition (add vs modify vs 
set)? I sent a patch that renamed things to the specific name some time 
ago, but I can change that back if you prefer (but there's not much 
point to changing things back and forth - maybe specific name is better).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
