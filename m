Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27JDp2I003585
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 14:13:51 -0500
Received: from mxout2.cac.washington.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k27JDmRX027315
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 19:13:48 GMT
Message-ID: <440DDB64.8090109@u.washington.edu>
Date: Tue, 07 Mar 2006 11:13:40 -0800
From: Brad Willson <bwil150n@u.washington.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: SEL+RHEL4+Amanda, targeted policy 18, enforcing
References: <440D21C1.30401@u.washington.edu>	 <1141737506.19447.214.camel@moss-spartans.epoch.ncsc.mil>	 <440DC850.8070105@u.washington.edu> <1141757023.19447.267.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1141757023.19447.267.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley wrote:

>That's fine; you only need the avc messages from /var/log/messages then.
>If you had been running auditd, then they would have gone to audit.log
>instead, and possibly been supplemented with syscall audit records, but
>that isn't required.
>
>  
>
Starting up auditd just solved another issue, thanks!  I'm tailing both 
/var/log/messages and /var/log/audit/audit.log to see what happens.

>Ultimately you want to resolve all of the avc messages, but possibly you
>should just start by posting the first few or the ones that seem most
>relevant to amanda itself (but try to avoid duplicates).
>
>  
>
A slice at a time is fine with me.  There seems to be a quantum leap 
between targeted and strict. 

>Note that since you are using RHEL, you should also be reporting this to
>Red Hat so that any ultimate fix can be included in a RHEL update;
>otherwise you may end up hitting the problem repeatedly.  Filed a
>bugzilla there yet? 
>
>  
>
I've not submitted a report yet; I try to gather as much information 
about a bug as I can before I send a report. 

Meanwhile I wait for my SELinux book from O'Reilly...due in tomorrow!

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
