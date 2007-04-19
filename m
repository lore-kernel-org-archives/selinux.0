Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JHrWRR006828
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 13:53:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JHrVuv018065
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 17:53:31 GMT
Message-ID: <4627AC90.2050502@redhat.com>
Date: Thu, 19 Apr 2007 13:53:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Samba fixes
References: <46277C78.8090200@redhat.com> <46278792.90602@us.ibm.com>
In-Reply-To: <46278792.90602@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> Daniel J Walsh wrote:
>> I have been working heavily with the samba team here to get selinux 
>> policy working well with samba.
>>
>>
>> Most controversial part is
>> samba_unconfined_script_exec_t
>>
>> Which is a directory that administrators can put random scripts into 
>> and allow samba to execute.
>
> So, three questions:
> 1) What user would be executing these scripts? The 'samba' user?
Samba Developers say:

Either the authenticated user or root, it really depends on the script.

For example, a "preexec" script is run before the share is accessed as
the user that authenticated to samba (or the forced user as per "force
user" parameter), while a "root preexec" script would always be run as
root. Other scripts always run as root or always as auth user depending
on the action to be performed (ie add user scripts always run as root,
while print related stuff should always run as user).

>
> 2) What is the intention of such functionality? To have samba be able 
> to run file management tools or something?
> 3) Is supporting this functionality even a good idea?
As opposed to setenforce 0/or samba_disable_trans?
>
> Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
