Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2E7m0v026732
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 09:07:48 -0500
Received: from mailgate1.arcor-ip.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA2E67QC015240
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 14:06:08 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id B59301F7990
	for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2006 15:07:36 +0100 (CET)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 0CC2962EB
	for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2006 14:07:36 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29399-06 for <selinux@tycho.nsa.gov>;
 Thu,  2 Nov 2006 15:07:35 +0100 (CET)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 4DD8A62E6
	for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2006 15:07:35 +0100 (CET)
Message-ID: <4549FB9E.3030104@brunel.de>
Date: Thu, 02 Nov 2006 15:07:26 +0100
From: Daniel Gil Mayol <daniel.gil-mayol@brunel.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Policy tests failed
References: <4549C1E0.6020401@brunel.de> <1162475440.22051.23.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1162475440.22051.23.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-11-02 at 11:01 +0100, Daniel Gil Mayol wrote:
>   
>> Hello, I still have some problems with the policy tests.
>>
>> I am testing that a domain can execute files that are defined in the 
>> policy. For example, lets take tripwire. In the policy is defined that:
>>
>>     can_exec($1_t, shell_exec_t);
>>     can_exec($1_t, bin_t);
>>
>> That means that tripwire_t domain is allowed to execute files labeled 
>> with shell_exec_t and bin_t.
>>
>> The test first relabel as shell_exec_t a copy that I made previously of 
>> /bin/ls (this copy is under my test directory):
>>
>>     [root@cnsu PolicyTest]# chcon -u system_u -r object_r -t shell_exec_t ls
>>
>> Then I try to execute ls (under the domain tripwire_t) over a file 
>> called '/policytest' defined as:
>>
>>     -rw-r--r--  root     root     system_u:object_r:policy_test_t 
>>     policytest
>>
>> where policy_test_t is:
>>
>>     type policy_test_t, file_type;
>>     allow * policy_test_t:file getattr;
>>
>> But this execution fail:
>>
>>     [root@cnsu PolicyTest]# runcon -t tripwire_t ./ls /policytest
>>     execvp: Permission denied
>>
>> The /var/log/messages shows this:
>>
>> Nov  2 11:06:46 cnsu kernel: audit(1162465606.392:25664): avc:  denied  
>> { entrypoint } for  pid=27705 comm="runcon" name="ls" dev=hda2 
>> ino=240308 scontext=root:system_r:tripwire_t 
>> tcontext=system_u:object_r:shell_exec_t tclass=file
>>
>> The question is... should I define for all the services this file 
>> entrypoint or I am doing something wrong in my test?
>> I would like to avoid to write all these entrypoints.
>>     
>
> SELinux distinguishes between an executable that can be used to enter a
> given domain (entrypoint) and an executable that can be subsequently
> executed by that domain.  can_exec() only gives permissions for the
> latter.  domain_trans() and domain_auto_trans() gives permissions for a
> domain transition, including the entrypoint permission between the new
> domain and the executable.  Example:
> 	domain_trans(unconfined_t, shell_exec_t, $1_t)
> 	domain_trans(unconfined_t, bin_t, $1_t)
>
> Reference policy splits the entrypoint permission into a separate
> macro/interface, domain_entry_file(), but that wouldn't exist in your
> base policy.
>
>   
And how can we test in our script this (that tripwire can execute types 
of shell_exec_t and bin_t) without define a domain_trans?
We don't want to allow this only for the test.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
