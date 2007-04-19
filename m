Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JIWZOj009815
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 14:32:35 -0400
Received: from e34.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JIWYuv024537
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 18:32:34 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3JIWYmt008320
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 14:32:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l3JIWXFT173910
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 12:32:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l3JIWXRW007589
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 12:32:33 -0600
Message-ID: <4627B5C0.7070305@us.ibm.com>
Date: Thu, 19 Apr 2007 13:32:32 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Samba fixes
References: <46277C78.8090200@redhat.com> <46278792.90602@us.ibm.com> <4627AC90.2050502@redhat.com>
In-Reply-To: <4627AC90.2050502@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Michael C Thompson wrote:
>> Daniel J Walsh wrote:
>>> I have been working heavily with the samba team here to get selinux 
>>> policy working well with samba.
>>>
>>>
>>> Most controversial part is
>>> samba_unconfined_script_exec_t
>>>
>>> Which is a directory that administrators can put random scripts into 
>>> and allow samba to execute.
>>
>> So, three questions:
>> 1) What user would be executing these scripts? The 'samba' user?
> Samba Developers say:
> 
> Either the authenticated user or root, it really depends on the script.
> 
> For example, a "preexec" script is run before the share is accessed as
> the user that authenticated to samba (or the forced user as per "force
> user" parameter), while a "root preexec" script would always be run as
> root. Other scripts always run as root or always as auth user depending
> on the action to be performed (ie add user scripts always run as root,
> while print related stuff should always run as user).
> 
>>
>> 2) What is the intention of such functionality? To have samba be able 
>> to run file management tools or something?
>> 3) Is supporting this functionality even a good idea?
> As opposed to setenforce 0/or samba_disable_trans?

That might be better than running with a false sense of security :) Even 
though this is an "administrative restricted" set of scripts, if an 
attacker could place malicious scripts in the directory, then permitting 
samba to exec them as root could be an avenue of attack.


My original point was simply that if its so controversial, that might 
beg the question "is offering this functionality a good idea, in the 
first place?".

Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
