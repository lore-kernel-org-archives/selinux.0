Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2A1Z37019783
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 05:01:38 -0500
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA2A0blL024907
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 10:00:46 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 5B0901E9505
	for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2006 11:01:18 +0100 (CET)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 4921562AC
	for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2006 10:01:18 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21395-07 for <selinux@tycho.nsa.gov>;
 Thu,  2 Nov 2006 11:01:17 +0100 (CET)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 9769C6227
	for <selinux@tycho.nsa.gov>; Thu,  2 Nov 2006 11:01:17 +0100 (CET)
Message-ID: <4549C1E0.6020401@brunel.de>
Date: Thu, 02 Nov 2006 11:01:04 +0100
From: Daniel Gil Mayol <daniel.gil-mayol@brunel.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Policy tests failed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I still have some problems with the policy tests.

I am testing that a domain can execute files that are defined in the 
policy. For example, lets take tripwire. In the policy is defined that:

    can_exec($1_t, shell_exec_t);
    can_exec($1_t, bin_t);

That means that tripwire_t domain is allowed to execute files labeled 
with shell_exec_t and bin_t.

The test first relabel as shell_exec_t a copy that I made previously of 
/bin/ls (this copy is under my test directory):

    [root@cnsu PolicyTest]# chcon -u system_u -r object_r -t shell_exec_t ls

Then I try to execute ls (under the domain tripwire_t) over a file 
called '/policytest' defined as:

    -rw-r--r--  root     root     system_u:object_r:policy_test_t 
    policytest

where policy_test_t is:

    type policy_test_t, file_type;
    allow * policy_test_t:file getattr;

But this execution fail:

    [root@cnsu PolicyTest]# runcon -t tripwire_t ./ls /policytest
    execvp: Permission denied

The /var/log/messages shows this:

Nov  2 11:06:46 cnsu kernel: audit(1162465606.392:25664): avc:  denied  
{ entrypoint } for  pid=27705 comm="runcon" name="ls" dev=hda2 
ino=240308 scontext=root:system_r:tripwire_t 
tcontext=system_u:object_r:shell_exec_t tclass=file

The question is... should I define for all the services this file 
entrypoint or I am doing something wrong in my test?
I would like to avoid to write all these entrypoints.


Thanks for your help

Dani






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
