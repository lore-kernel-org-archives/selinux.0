Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB1KJCZG026015
 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2014 15:19:12 -0500
Message-ID: <547CCD23.3040704@redhat.com>
Date: Mon, 01 Dec 2014 15:18:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>,
 "Minear, Spencer" <Spencer_Minear@mcafee.com>
Subject: Re: How does device labeling work?
References: <0f7a4764231e459e98f5771afa64b933@DNVEXUSR1N09.corpzone.internalzone.com>
 <CAB9W1A0YfE2MP9aidmXzEkQj=2ts+rsH+ggtKPYKKSFH2OBryg@mail.gmail.com>
In-Reply-To: <CAB9W1A0YfE2MP9aidmXzEkQj=2ts+rsH+ggtKPYKKSFH2OBryg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Well udev has SELinux awareness built in and we also use named file
transition rules so devices created by the kernel_t or unconfined_t
usually get created correctly.

 
On 12/01/2014 01:39 PM, Stephen Smalley wrote:
> Not sure if this is still true, but the distros used to invoke
> restorecon -R /dev from an init script or dracut script after loading
> policy.
>
> On Mon, Dec 1, 2014 at 12:17 PM, Minear, Spencer
> <Spencer_Minear@mcafee.com> wrote:
>> I'm working on integrating SELinux to an existing system and find that my system is not setting the label on all of the /dev/ entries correctly.  It appears to me that the issue is related to my missing some required actions during the transition from running with the linuxrc script on the initial RAM file system to using the mounted disk  and running the init process.
>>
>> What I see is that a lot of devices, such as the console and tty devices get created while running the init script provided in the bootrd file systems.  /dev is being created as with a mount -t devtmpfs udev /dev command.  After that is done an other actions are run in the initrd script I see the likes of /dev/console, I see entries in the /run/udev/data area for lots of devices including the console device and there is clear evidence that the udevd processes are running.
>>
>> At the end of the initrd there are steps taken to move the /dev and other mounts to the newly mounted root file system found on the disk.
>>
>> I've seen about 3 or 4 models of actions at the end of the initrd, (all of which are different than my existing baseline code), that should switch to using the mounted root file system on the disk and exec the init program found on that file system.   When the init process starts it sees that the policy exists and it proceeds to load the policy as provided.
>>
>> What I find once the policy is loaded is that most of the content of the /dev is labeled per the nominal default rules and all those devices that were created before the policy was loaded, such as /dev/console is never updated to have the label as specified in the policy file.  I can see that some of the devices that are closely related to console and other tty's have the correct label, while others are not correct.
>>
>> I think my question boils down to "Can anyone point me some document that defines what the initrd must do to ensure that devices and or objects created before the policy is enabled get processed to have the type as specified in the policy context file?"  Of if said document is does not exist, could someone explain how this is supposed to happen?  It feels like there may have to be some action by udevd to go back and reprocess the devices or the device initialization has to be redone in some way to get the labels to agree with the specification provided in the context file.
>>
>> Thanks in advance for any info that you can provide.
>>
>> Spencer Minear
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
