Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65JH6gA025381
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:17:06 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65JEWSt001510
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 19:14:33 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j65JFCmX022011
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:15:12 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j65JFBV03711
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:15:11 -0400
Received: from [172.16.83.117] (dhcp83-117.boston.redhat.com [172.16.83.117])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j65JFBcs002912
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:15:11 -0400
Message-ID: <42CADC3F.8000206@redhat.com>
Date: Tue, 05 Jul 2005 15:15:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Groups in the alternative user solution
References: <20050630191417.26186.qmail@web31611.mail.mud.yahoo.com>
In-Reply-To: <20050630191417.26186.qmail@web31611.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok we are actually  trying to code something up to deal with this 
discussion.  This is our current thoughts on
handling users.  We have not come to a decent way of handling 
file_contexts.    We are attempting in this
example to limit the number of file_context/user files.

Example policy for a hospital would have 5 types of SELinux users.

cat /etc/selinux/strict/users/local.users
user doctor_u { user_r nurse_r labtech_r doctor_r };
user labtech_u { user_r labtech_r };
user nurse_u { user_r nurse_r };
user user_u { user_r };
user staff_u { staff_r sysadm_r secadm_r };


Then we create a file called map.users

cat /etc/selinux/strict/users/map.users
staff_u: dwalsh,ivan
doctor_u: green,welby,spock
nurse_u: cratchet,nightengale
labtech_u: grissom
user_u:  *


As far as file_context files are concerned, only dwalsh and ivan would 
need to
have user specific file_context.homedir files be created, since all 
other users
on the system would map to the "user" type.

Some how we need to make the system smart enough to know that SELINUX 
Users map
to a default role/type;

So when "grissom" logs in his id -Z will show

labtech_u:user_r:user_t

He then can:

newrole -r labtech_r

And can run labtech applications.

Dr. Green would login as

doctor_u:user_r:user_t

He could then run newrole and change to any of doctor_r, nurse_r, or 
labtech_r
and run the associated applications.

The only time home directory file context would need to change would be 
if the
user became an admin.

This would potentially eliminate the 1000's of file contexts files problem,
since almost all users would map to the default user_r and user_home_t...
for his home dir file context.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
