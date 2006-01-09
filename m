Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k09KOKXf003000
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 15:24:21 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k09KOINp021018
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 20:24:18 GMT
Message-ID: <43C2C671.2030306@redhat.com>
Date: Mon, 09 Jan 2006 15:24:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Latest policy diffs, very large
References: <43BAD603.5060209@redhat.com> <1136829416.29815.97.camel@sgc>
In-Reply-To: <1136829416.29815.97.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2006-01-03 at 14:52 -0500, Daniel J Walsh wrote:
>   
>> ftp://people.redhat.com/dwalsh/SELinux/policy-20060103.patch
>>     
>
> I've merged most of this in so far, but I have several questions.
>
>   
>> Added selinux policy man pages.
>>     
>
> I merged this, but in the long run I think it would be better if we
> eventually move the information into the XML documentation, and write a
> tool that will generate the man pages from the XML, so that there aren't
> any possible synchronization problems between the XML and the man pages.
>
>   
I agree, similarly we need to look into a way of documenting the 
booleans so that system-config-securitylevel and the soon
to be created system-config-selinux can get a human description from 
policy of the boolean, to be displayed to the user.  And potentially 
translated.
>> Many minor changes...
>>     
>
> * why does automount need net_bind_service? it doesn't have any rules
> for binding sockets.
>   

> * there are comments about readahead in initrc distro_redhat; however,
> readahead has a policy now, so why are these rules still needed?
>   
No these should be removed.
> * several daemons added cron_system_entry(), cron, cups, apm, why is
> this needed?
>   
So that cron will transition to those domains when executing the app.  
Otherwise cron needs access to these domains logs and other files.
> * why is dev_read_raw_memory(hald_t) needed?
>   
Asking package maintainer if he knows what it is doing?
> * why is noatsecure needed for the kernel to run init on an MLS system?
>   
Transition fails without it, Not sure why.  Stephen or TCS Guys  any ideas?
> * why does mount_t need to rw all terminals?
>
>   
I am not sure if you can dontaudit this.  Basically when I execute mount 
command it wants to output to the tty, I guess.  Although
I see the output along with the failures in the log file.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
