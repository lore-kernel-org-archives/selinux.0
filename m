Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95LDc8j003670
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 17:13:38 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95LCPhL026162
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 21:12:26 GMT
Message-ID: <45257577.7050709@redhat.com>
Date: Thu, 05 Oct 2006 17:13:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: russell@coker.com.au, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy patch against subversion tree
References: <200610052244.51091.russell@coker.com.au> <1160078114.26418.54.camel@sgc>
In-Reply-To: <1160078114.26418.54.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Merged, with some notes:
>
> On Thu, 2006-10-05 at 22:44 +1000, Russell Coker wrote:
>   
>> Allow unconfined processes to see unlabeled processes in ps.
>>     
>
> Enhanced the kern_unconfined rules in kernel.te instead.
>
>   
>> Removed a redundant rule in samba.te, and some inappropriate permissions in 
>> amavis.te.
>>     
>
> This amavis removals were added from Dan from August, so there needs to
> be some discussion on this.  Dan?
>
>   
Go with Russells changes, I believe the input for some of my changes 
came from him.
>> Removed support for the pre-Fedora Red Hat code to create sym-links in /boot.
>>     
>
> Kept the interface, in case there are 3rd party callers of this
> interface.
>
>   
>> Removed support for devpts_t files in /tmp (there is no way that would ever 
>> work).
>>
>> Allowed postgrey to create socket files.
>>     
>
> Moved this hunk down.
>
>   
>> Made the specs for the /lib and /lib64 directories better support stem 
>> compression.
>>     
>
> Fixed the mailman addition to use an interface.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
