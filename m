Message-ID: <47A76189.9050606@jhu.edu>
Date: Mon, 04 Feb 2008 14:03:37 -0500
From: "Seth D. Guikema" <sguikema@jhu.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: reindexing time for SELinux?
References: <47A71F79.1020300@jhu.edu> <1202137767.3070.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1202137767.3070.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just rebooted, and the box seems to be working fine. It seems to have 
hung in the shutdown sequence. The files were relabeled successfully 
when I rebooted the box. Thank you all.
Seth

Stephen Smalley wrote:
> On Mon, 2008-02-04 at 09:21 -0500, Seth D. Guikema wrote:
>   
>> I am trying to set up SELinux on my Fedora Core 7 workstation. I am 
>> using the pre-installed GUI SELinux configuration tool in FC7. I 
>> selected a targeted set-up. I was warned that the workstation would need 
>> to reindex the files at the next reboot and that this would take a 
>> while. I clicked ok. I rebooted the workstation Saturday morning at 
>> about 10am. It is still unresponsive (and not available for remote 
>> connections) and working hard this morning, almost 48 hours later. How 
>> long should reindexing take? The workstation is new. It has 2 1TB disks 
>> (RAID mirrored), but there isn't much on them yet - perhaps 30MB plus 
>> the OS and other programs installed by the manufacturer (ASL). Does 
>> reindexing really take this long? This is my first attempt at SELinux, 
>> and any help is appreciated. Thank you.
>>     
>
> I assume you mean relabeling rather than reindexing.  It shouldn't take
> that long.  Are you getting output on the console?
>
> Try rebooting into single-user mode in permissive mode and relabeling
> from there, e.g. boot with 'enforcing=0 single' and run 'fixfiles
> relabel' (and remove /.autorelabel if it still exists), then reboot
> normally.
>
>   

-- 
Assistant Professor
Department of Geography and Environmental Engineering
Johns Hopkins University
Baltimore, MD 21218
(410)516-6042
sguikema@jhu.edu
https://jshare.johnshopkins.edu/sguikem1/public_html/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
