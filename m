Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBDKbqYe020984
 for <selinux@tycho.nsa.gov>; Sat, 13 Dec 2014 15:37:52 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so7610063lab.39
 for <selinux@tycho.nsa.gov>; Sat, 13 Dec 2014 12:37:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <450a42771fe0462d856c2295ab0b742d@DNVEXUSR1N09.corpzone.internalzone.com>
References: <0f7a4764231e459e98f5771afa64b933@DNVEXUSR1N09.corpzone.internalzone.com>
 <CAB9W1A0YfE2MP9aidmXzEkQj=2ts+rsH+ggtKPYKKSFH2OBryg@mail.gmail.com>
 <547CCD23.3040704@redhat.com>
 <450a42771fe0462d856c2295ab0b742d@DNVEXUSR1N09.corpzone.internalzone.com>
Date: Sat, 13 Dec 2014 15:37:46 -0500
Message-ID: <CACLa4pt6LjLqd=O1A8n5Hf5fefwi_v+xyxrpGpRd9NS6Ygv=Yg@mail.gmail.com>
Subject: Re: How does device labeling work?
From: "Paris, Eric" <eparis@parisplace.org>
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nodes created by the kernel in devtmpfs will get labeled based on the
filename trans rules for kernel_t to create a char/block file in
device_t.

Nodes created by udev will be created with the label as defined in the
file context db (I think, it might use the filename trans rules, but I
don't think so...)

In Fedora/systemd land systemd will call restorecon right after it
loads policy, so the nodes created before policy load will get the
label from the file context db.

udev also (at least used to) watch nodes in /dev/ and would relabel
them after they were closed. I never really understood that one....

On Tue, Dec 2, 2014 at 12:14 PM, Minear, Spencer
<Spencer_Minear@mcafee.com> wrote:
> Thank you for the pointers.
>
> I was not expecting that this security relevant action  would be delayed until after init starts and get taken care of by running the startup scripts, so I didn't think to look there.
>
> It is clear that the /dev area is covered by the relabel_minimal entry in /etc/init.d/selinux-basics.    I have not yet figured out some of the other labeling questions that come to mind related to other tmp file systems and things that get created early in the boot sequence.  But it is likely that I need to more time studying the details of the likes of restorecond.
>
> Spence
>
>
> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Monday, December 01, 2014 2:19 PM
> To: Stephen Smalley; Minear, Spencer
> Cc: SELinux
> Subject: Re: How does device labeling work?
>
> Well udev has SELinux awareness built in and we also use named file transition rules so devices created by the kernel_t or unconfined_t usually get created correctly.
>
>
> On 12/01/2014 01:39 PM, Stephen Smalley wrote:
>> Not sure if this is still true, but the distros used to invoke
>> restorecon -R /dev from an init script or dracut script after loading
>> policy.
>>
>> On Mon, Dec 1, 2014 at 12:17 PM, Minear, Spencer
>> <Spencer_Minear@mcafee.com> wrote:
>>> I'm working on integrating SELinux to an existing system and find that my system is not setting the label on all of the /dev/ entries correctly.  It appears to me that the issue is related to my missing some required actions during the transition from running with the linuxrc script on the initial RAM file system to using the mounted disk  and running the init process.
>>>
>>> What I see is that a lot of devices, such as the console and tty devices get created while running the init script provided in the bootrd file systems.  /dev is being created as with a mount -t devtmpfs udev /dev command.  After that is done an other actions are run in the initrd script I see the likes of /dev/console, I see entries in the /run/udev/data area for lots of devices including the console device and there is clear evidence that the udevd processes are running.
>>>
>>> At the end of the initrd there are steps taken to move the /dev and other mounts to the newly mounted root file system found on the disk.
>>>
>>> I've seen about 3 or 4 models of actions at the end of the initrd, (all of which are different than my existing baseline code), that should switch to using the mounted root file system on the disk and exec the init program found on that file system.   When the init process starts it sees that the policy exists and it proceeds to load the policy as provided.
>>>
>>> What I find once the policy is loaded is that most of the content of the /dev is labeled per the nominal default rules and all those devices that were created before the policy was loaded, such as /dev/console is never updated to have the label as specified in the policy file.  I can see that some of the devices that are closely related to console and other tty's have the correct label, while others are not correct.
>>>
>>> I think my question boils down to "Can anyone point me some document that defines what the initrd must do to ensure that devices and or objects created before the policy is enabled get processed to have the type as specified in the policy context file?"  Of if said document is does not exist, could someone explain how this is supposed to happen?  It feels like there may have to be some action by udevd to go back and reprocess the devices or the device initialization has to be redone in some way to get the labels to agree with the specification provided in the context file.
>>>
>>> Thanks in advance for any info that you can provide.
>>>
>>> Spencer Minear
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
