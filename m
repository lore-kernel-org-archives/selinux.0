Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UJIuI4006486
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 15:18:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3UJIhVf003597
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 19:18:43 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id h3UJIg4D003594
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 19:18:42 GMT
Message-ID: <3EB0218D.8060806@redhat.com>
Date: Wed, 30 Apr 2003 15:18:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Francois Leclerc <leclerc@houston.sema.slb.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SUDO package
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com> <200304181408.55003.russell@coker.com.au> <3EA021A5.4020603@redhat.com> <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil> <3EA5A040.40107@redhat.com> <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil> <3EAFEECA.1090107@redhat.com> <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil> <3EB01E40.69B72141@houston.sema.slb.com>
In-Reply-To: <3EB01E40.69B72141@houston.sema.slb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Francois Leclerc wrote:

>Hello,
>what would be the value added of sudo when you have the SELinux ability 
>	to set roles
>	allocate roles to people
>	to set information domains
>	to avoid the "root" overpowerful model
>	to extend the policies?
>
>Regards,
>--FL
>
>  
>
SELinux does not remove root, it complements it.  So now you have two 
security models at the same time.
So anything that required root privaledge on your non SELinux system 
still requires root privs on the SELinux
system.  It also requires you to assume a role within SELinux that 
allows you to complete the task.  So a
sudo that allows you to execute commands as root and run under the 
required role would be benificial.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
