Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27HqLeh001243
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 12:52:21 -0500
Received: from mxout5.cac.washington.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k27HqIRX008211
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 17:52:19 GMT
Received: from smtp.washington.edu (smtp.washington.edu [140.142.33.9])
	by mxout5.cac.washington.edu (8.13.5+UW05.10/8.13.5+UW05.09) with ESMTP id k27HqI04019967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 09:52:19 -0800
Message-ID: <440DC850.8070105@u.washington.edu>
Date: Tue, 07 Mar 2006 09:52:16 -0800
From: Brad Willson <bwil150n@u.washington.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: SEL+RHEL4+Amanda, targeted policy 18, enforcing
References: <440D21C1.30401@u.washington.edu> <1141737506.19447.214.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141737506.19447.214.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Stephen Smalley wrote:

>On Mon, 2006-03-06 at 22:01 -0800, Brad Willson wrote:
>  
>
>>Running SELinux enforcing mode does not allow amanda to connect and do
>>backups.
>>
>>I'm a newbie at SELinux in dire need of some straightforward answers.
>>    
>>
>
>What 'avc:  denied' messages are you getting in /var/log/messages
>or /var/log/audit/audit.log?
>
>  
>
That depends on the machine.  One box reports no 'avc:  denied' messages 
whatsoever while on another there are over 4000 entries, both using 
policy.18.  Is there a quick and dirty way of turning on auditing?  
Neither machine has an audit.log.

>>Following the logic that named.fc needs a companion named.te, the first
>>thing I have noticed is the lack of an amanda.te file in this particular
>>distribution.  What I find odd is there are several diffs on this list
>>specifically for amanda.te.  I have located what appears to be a
>>complete amanda.te file from another distribution, but when I try to
>>recompile the policy, it spews errors then fails, e.g.
>>    
>>
>
>RHEL4 targeted policy didn't include the amanda policy.  Targeted policy
>started as a very small subset of the overall example policy, but has
>grown significantly since RHEL4 was released (but those changes are
>feeding into Fedora and should be included in future RHEL releases, not
>RHEL4 updates, IIUC).  See 
>http://fedoraproject.org/wiki/SELinux/
>
>  
>
>>Building file_contexts ...
>>/usr/bin/checkpolicy -o policy.18 policy.conf
>>/usr/bin/checkpolicy:  loading policy configuration from policy.conf
>>domains/program/amanda.te:143:ERROR 'syntax error' at token
>>'can_network_server' on line 4181:
>>    
>>
>
>This reflects the fact that the amanda.te file you grabbed uses a macro
>(can_network_server) that didn't exist in the policy at the time RHEL4
>was created.
>  
>
Makes good sense. 

>  
>
>>Since the first send bounced back, I also tried strict/enforcing and 
>>found myself in even deeper trouble, but still without a successful 
>>backup.  My next test is to relax targeted policy to permissive so I can 
>>audit the errors for clues.
>>    
>>
>
>Just check for avc denied messages in your logs and report them.
>
>  
>
Strict/enforcing has the amanda policy, but it locked root out of bash 
(not a happy situation) so that's not an option on the remote machines.  
The other edge of the sword is targeted/enforcing is running on a 
firewall; I don't want to drop guard on that one albeit relaxed from 
strict.  I have to resolve backup, monitoring, public services, and 
remote access issues before I unleash this on the firewalls.

Thanks!

-- 
Brad Willson
Sr. Computer Specialist
UW GeneTests, http://www.genetests.org
EM: bwil150n@u.washington.edu
W: 206.221.4674, C: 425.891.2732



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
