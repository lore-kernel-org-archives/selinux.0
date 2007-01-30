Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0UEpd0P000562
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 09:51:39 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0UEqfDH004516
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 14:52:41 GMT
Message-ID: <45BF5BB1.1010603@mentalrootkit.com>
Date: Tue, 30 Jan 2007 09:52:33 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Catalin DIMA <dima@univ-paris12.fr>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Problems installing current version of refpolicy with FC6
References: <45BE44FC.8080303@univ-paris12.fr> <45BE4FC6.4090502@mentalrootkit.com> <45BE6262.5080902@univ-paris12.fr> <45BE68BF.3030607@mentalrootkit.com> <20070129225708.M77854@ssl.univ-paris12.fr>
In-Reply-To: <20070129225708.M77854@ssl.univ-paris12.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Catalin DIMA wrote:
> On Mon, 29 Jan 2007 16:35:59 -0500, Karl MacMillan wrote
>> Could you elaborate on where it gets stuck. Does the labeling 
>> happen? 
> 
> No, it crashes before labeling, just after starting udev and the 2nd service
> (don't remember the name, I just left home...).
> 
>> You might try relabeling in permissive.
> 
> I suspect it's not the relabeling process, though I have to check it back
> (tomorrow...)
> 
>>> Btw, forgot to mention the libsepol.sepol_genbools: error while reading 
>>> /etc/selinx/refpolicy/booleans error...
>>>
>> In permissive or enforcing?
> 
> Enforcing.
> 
>>> In permissive refpolicy mode, the only selinux message talks about 
>>> NetworkManager.
>>>
>> Just to clarify, things work fine in permissive mode and you are 
>> only getting a single AVC message, correct? 
> 
> Yes, at least during the booting process. I think I also did a setfiles check
> in permissive, and everything was ok (to be checked tomorrow again).
> 
>> Could you check 
>> /var/log/messages and /var/log/audit/audit.log for avc messages 
>> after a permissive boot. Also check the selinux messages in dmesg 
>> for errors.
> 
> The machine on which I noticed the avc:denied message about the NetworkManager
> does not have setools installed -- I then only looked at /var/log/messages.
> Hope I did not forget what machine I was working on...
> 

Setools is not required - you can just cat the logs (or use ausearch for 
the audit logs). Without some more detailed debugging info I'm not 
certain what the problem is.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
