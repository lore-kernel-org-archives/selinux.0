Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0MLTHBI032273
	for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2007 16:29:17 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0MLUEpf016240
	for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2007 21:30:14 GMT
Received: by py-out-1112.google.com with SMTP id a78so759822pyh
        for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2007 13:30:14 -0800 (PST)
Message-ID: <45B52CE2.8070303@gmail.com>
Date: Mon, 22 Jan 2007 15:30:10 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Linda Knippers <linda.knippers@hp.com>
CC: selinux@tycho.nsa.gov
Subject: Re: polyinstantiation, what should happen?
References: <cadfc0e40701171501j5ebbc57fn6ea9c652fbcc946b@mail.gmail.com>	 <45AEB5DC.9060105@hp.com> <cadfc0e40701181146w56e7df81s1cb4476bde74bcee@mail.gmail.com> <45B1182B.1090005@hp.com>
In-Reply-To: <45B1182B.1090005@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Linda Knippers wrote:
> Xavier Toth wrote:
>   
>> I changed namespace.conf to use 'level' and created a new user and
>> them su'd to that new user 'test' but as you'll see below the
>> directory that gets created is simply named 'test'.
>>
>> Jan 18 13:14:55 localhost su: pam_unix(su:session): session opened for
>> user test by root(uid=0)
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): open_session -
>> start
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Parsing
>> config file /etc/security/namespace.conf
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Configured poly
>> dirs:
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): dir='/tmp'
>> iprefix='/tmp-inst/' meth=1
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 0
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 3
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 500
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session):
>> dir='/var/tmp' iprefix='/var/tmp/tmp-inst/' meth=1
>>     
>
> If you have "level" as the method then you should have meth=3 in the above line.
> meth=1 means "user", which doesn't even match what you sent as your original
> namespace.conf file.  "user" is the default if SELinux isn't configured or if
> the pam_namespace module decides that there's no context change, which I guess
> would be the case for 'su'. 

I had done a newrole before the su so there was a context change. I'm 
still unclear where "meth=1" is coming from.

>  What happens if you log in as that user?  And
> then use newrole?
>   

Logging in as the user followed by newrole causes directories to be 
named with the context.

> -- ljk
>
>   
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 0
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 3
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 500
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session):
>> dir='/home/test' iprefix='/home/test/test.inst/' meth=1
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 0
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 3
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): override user 500
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Set up
>> namespace for pid 5761
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Checking for
>> ns override in dir /tmp for uid 503
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Need poly ns
>> for user 503 for dir /tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Checking for
>> ns override in dir /tmp for uid 503
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Setting poly
>> ns for user 503 for dir /tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): cwd is outside
>> /tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Unmount of
>> /tmp failed, Invalid argument
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Set namespace
>> for directory /tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): poly_name test
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Inst ctxt
>> (null) Orig ctxt system_u:object_r:tmp_t:SystemLow-SystemHigh
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): instance_dir
>> /tmp-inst/test
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Checking for
>> ns override in dir /var/tmp for uid 503
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Setting poly
>> ns for user 503 for dir /var/tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): cwd is outside
>> /var/tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Unmount of
>> /var/tmp failed, Invalid argument
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Set namespace
>> for directory /var/tmp
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): poly_name test
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Inst ctxt
>> (null) Orig ctxt system_u:object_r:tmp_t:SystemLow-SystemHigh
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): instance_dir
>> /var/tmp/tmp-inst/test
>> Jan 18 13:14:55 localhost su: pam_namespace(su:session): Checking for
>> ns override in dir /home/test for uid 503
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): Setting poly
>> ns for user 503 for dir /home/test
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): cwd is
>> outside /home/test
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): Unmount of
>> /home/test failed, Invalid argument
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): Set namespace
>> for directory /home/test
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): poly_name test
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): Inst ctxt
>> (null) Orig ctxt root:object_r:user_home_dir_t:SystemLow
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): instance_dir
>> /home/test/test.inst/test
>> Jan 18 13:14:56 localhost su: pam_namespace(su:session): namespace
>> setup ok for pid 5761
>>
>> On 1/17/07, Linda Knippers <linda.knippers@hp.com> wrote:
>>
>>     
>>> Xavier Toth wrote:
>>>       
>>>> I'm running the lspp.63 kernel along with the latest pam and newrole
>>>> off of Dan Walsh' people page.
>>>>
>>>> I've configured polyinstantiation but it doesn't work the way I
>>>> thought it would so either I don't understand or I've got it
>>>> configured wrong. In namespace.conf I've specified that I want context
>>>> to be used for the polyinstantiated instance directories but I only
>>>> getting the user name. Shouldn't the directory name contain the entire
>>>> an context?
>>>>         
>>> Perhaps.  I think the method field specifies when you want to
>>> polyinstantiate,
>>> not necessarily what the instance names are, although it makes sense that
>>> the directories would be named using the context and the user name.
>>> I use "level" instead of "context" on my system and I get directory
>>> names that
>>> have the full context, including level, plus the user name.  By
>>> specifying
>>> "level" but I only get a new instance when I change levels, not when I
>>> change
>>> roles.
>>>
>>> My namespace.conf looks like this, if you want to give that a try:
>>> /tmp     /tmp/tmp-inst/         level      root,adm
>>> /var/tmp /var/tmp/tmp-inst/     level      root,adm
>>> $HOME    /home/home.inst/       level      root,adm
>>>
>>> Do you have any interesting messages in /var/log/secure?  Since you have
>>> the the debug option on your pam_namespace.so lines you should see
>>> messages
>>> when it creates an instance directory.
>>>
>>> -- ljk
>>>
>>>       
>>>> Also I'm running X so I followed the instructions on the pam_namespace
>>>> man page but wasn't sure whether /etc/pam.d/gdm needed unmnt_remnt as
>>>> su and newrole do?
>>>>
>>>> Ted
>>>>         
>>>       
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
