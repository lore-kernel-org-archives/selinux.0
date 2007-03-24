Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2O0PmSV016703
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:25:48 -0400
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2O0PlBp019198
	for <selinux@tycho.nsa.gov>; Sat, 24 Mar 2007 00:25:47 GMT
Received: from [144.51.25.7] (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2O0PlNh032709
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:25:47 -0400
Message-ID: <4604700B.1040503@tycho.nsa.gov>
Date: Fri, 23 Mar 2007 20:25:47 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Sample policy language extension supporting per-user policy
References: <4604685B.301@tycho.nsa.gov>
In-Reply-To: <4604685B.301@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Responding to a private message on-list:

 > - This discussion should happen on list,
 > - Human understandability of the source policy is a concern,

I think the language extension would be easier to understand than the 
current m4-based way of accomplishing the same thing.


 > - I don't think we want to encourage automatic type mangling, even for
 > short term implementation, as it will just cause confusion and leak
 > though audit messages and kernel APIs.

The language extension could be implemented at compile-time using 
automatic type mangling.  But if this is not possible then it could be 
built into the policy language itself.  The policy size reduction could 
only happen this way anyway.


 > - We need to make sure we are solving the real problem.

This would not really solve the problem brought up in the private 
discussion, which is how to better integrate user management into 
SELinux.  But it could help, by allowing users to be added in policy 
modules and then having existing policy pick them up.

The major problem it would solve is policy size and complexity of type 
names.


 > - Separation of Linux user management from SELinux policy seems
 > necessary, so it won't get us to the point of per-Linux-user
 > permissions.

The debate over whether or not they should be separated triggered this 
proposal, but I think it could stand on its own even if they do remain 
separated.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
