Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4EFaMA026262
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 09:15:36 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA4EA7Zc005293
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 14:10:07 GMT
Message-ID: <436B6E9E.4050108@cornell.edu>
Date: Fri, 04 Nov 2005 09:22:22 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use	libsemanage
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu> <1131110455.23420.187.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131110455.23420.187.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'm not sure I understand the question.  load_policy is supposed to
> preserve current boolean settings across a reload so that a transient
> boolean change isn't affected by a policy update.  Examples of transient
> boolean changes might include setting of booleans from cron jobs for
> time-of-day policies, manual setting of booleans without -P by an admin
> to reflect some external event, setting of booleans by an IDS in
> response to some detected attack, etc.  That behavior isn't supposed to
> change even with the introduction of libsemanage and the use of
> SETLOCALDEFS=0 (which only turns off setting the booleans from the
> booleans* files upon initial policy load, as they are now set in the
> generated kernel binary policy file by libsemanage).
>   
So, how do I specify that this is not a transient change, and I want my 
booleans loaded into policy immediately?
>> Note2: if I go and force libsemanage to pass -b flag, it works just 
>> fine, but takes forever (10sec) to complete. It's not my fault, the 
>> module expand function is just really really slow.
>>     
>
> echo "expand-check = 0" >> /etc/selinux/semanage.conf, as I noted
> earlier, for development/debugging purposes.  We may want to allow
> setting the expand check state on a per-handle basis to disable for
> certain kinds of transactions, just as one can presently disable
> immediate reload for certain transactions.
>   
I think I'll try to add all kinds of shortcuts by tracking exactly what 
the user is trying to do...
If there are no module changes, we can reuse the old "base.expanded" file.
If there are no policy changes, we can skip rebuilding the policy. So, 
if only seusers
were changed, we only need to read the policy.kern, instead of 
reconstructing it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
