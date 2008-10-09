Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99KOueK001194
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 16:24:56 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99KOt8h017010
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 20:24:56 GMT
Message-ID: <48EE688E.8040507@manicmethod.com>
Date: Thu, 09 Oct 2008 16:24:46 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: per role template confusion
References: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com>
In-Reply-To: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> Can someone explain the per role template implementation? I am confused.
>
> During policy compilation, a .mod.role file is created that just 
> references the roles in /usr/share/selinux/devel/include/rolemap 
> regardless of the roles defined via semanage. Should semanage add 
> roles to rolemap? Is there additional magic in semodule?
>
> joe 

Roles aren't created by semanage, only user->role mappings. The 
per_role_template creates derived types for each role (eg., 
staff_mozilla_t, sysadm_mozilla_t). These roles are defined in the 
policy only.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
