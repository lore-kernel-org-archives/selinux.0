Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k77GKGpp004257
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 12:20:16 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k77GK0ME007126
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 16:20:00 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k77GKFpF007031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 12:20:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k77GKFL9295598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 12:20:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k77GKE0n024681
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 12:20:15 -0400
Subject: hierarchical roles
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: dwalsh@redhat.com
Cc: klaus@atsec.com, selinux@tycho.nsa.gov
In-Reply-To: <1154965823.8936.46.camel@localhost.localdomain>
References: <1154965823.8936.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 12:20:09 -0400
Message-Id: <1154967609.8936.55.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I sent the following to the redhat-lspp mailing list. I should
have sent it to this mailing list since it involves a question
about core selinux and not necessarily lspp. Dan/Klaus, sorry 
for the duplication. 

Thanks.

-Janak

On Mon, 2006-08-07 at 11:50 -0400, Janak Desai wrote:
> As part of testing rbac evaluation requirements, I have been 
> trying to create a loadable policy module that creates
> a new role that dominates a few of the existing roles. I am able 
> to create a role using the dominance statement and "semanage user"
> correctly assigns other roles (which the new role dominates) to a
> user when that user is assigned the new role. From what I can
> see, I still have to setup needed access rights for the new
> domain associated with this new role. That makes sense, since
> roles only allow you access to a domain and are not involved in
> the access decision. So hierarchical roles only give you the
> ability to change into roles that you dominate but do not give
> you aggregate access rights of roles that you dominate, is that
> correct or am I missing something? 
> 
> Let me explain what I am asking with an example. strict-mls 
> policy has roles sysadm_r and secadm_r. I created a new role 
> cnorris_r that dominates these two roles and runs in the 
> default domain cnorris_t. A user xyz is assigned the cnorris_r.
> Now the user xyz can use newrole to switch into sysadm_r
> or secadm_r, to perform actions that those roles are allowed.
> However, as cnorris_r in cnorris_t domain, xyz cannot perform
> actions that they could as sysadm_r or secadm_r. Is that
> correct or am I missing some policy magic that will allow
> cnorris_r to perform sysadm_r/secadm_r duties directly (without
> newrole'ing to them)?
> 
> Thanks.
> 
> -Janak
> 
> --
> redhat-lspp mailing list
> redhat-lspp@redhat.com
> https://www.redhat.com/mailman/listinfo/redhat-lspp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
