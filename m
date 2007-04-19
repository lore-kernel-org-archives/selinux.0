Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JFFbEQ027839
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:15:52 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JFFW9K009027
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:15:33 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3JFFVGj026422
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:15:31 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l3JFFVEH532366
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:15:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l3JFFVPA031632
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 11:15:31 -0400
Message-ID: <46278792.90602@us.ibm.com>
Date: Thu, 19 Apr 2007 10:15:30 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Samba fixes
References: <46277C78.8090200@redhat.com>
In-Reply-To: <46277C78.8090200@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I have been working heavily with the samba team here to get selinux 
> policy working well with samba.
> 
> 
> Most controversial part is
> samba_unconfined_script_exec_t
> 
> Which is a directory that administrators can put random scripts into and 
> allow samba to execute.

So, three questions:
1) What user would be executing these scripts? The 'samba' user?
2) What is the intention of such functionality? To have samba be able to 
run file management tools or something?
3) Is supporting this functionality even a good idea?

Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
