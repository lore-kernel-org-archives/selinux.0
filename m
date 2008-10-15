Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9FG2XBM003650
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2008 12:02:33 -0400
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9FG1Epv010691
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2008 16:01:16 GMT
Received: from cpe-66-68-165-162.austin.res.rr.com ([66.68.165.162] helo=[192.168.20.230])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1Kq8pS-0000j3-KB
	for selinux@tycho.nsa.gov; Wed, 15 Oct 2008 16:02:30 +0000
Message-Id: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com>
From: Joe Nall <joe@nall.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Use of optional_policy in templates (compiler bug or feature?)
Date: Wed, 15 Oct 2008 11:02:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is it legitimate to define a type within an optional_policy within a  
template?

I ask because there are a number of compile issues with policy that  
look like:

template(`wm_domain_template',`
...
         optional_policy(`
                 dbus_system_bus_client_template($1_wm,$1_wm_t)
# does not compile
#               dbus_user_bus_client_template($1,$1_wm,$1_wm_t)
         ')
...
')

Looking at the checkmodule source, it looks like type declarations  
declared within optionals are popped off the symbol stack in  
end_optional but left in the symbol table. These symbols later fail an  
is_id_in_scope test and generate an 'duplicate declaration of type/ 
attribute'.

I think this is related to:
http://oss.tresys.com/projects/refpolicy/ticket/43

and earlier complaints about this behavior in the X policy from Dan  
and Eamon in June/July.
http://www.nsa.gov/SeLinux/list-archive/0806/thread_body18.cfm

I'm running libsepol-2.0.33 which has the fix in the above thread.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
