Date: Thu, 27 May 2004 13:43:44 -0400
Subject: Re: XP as a base for NetTop
From: "Dr. Eugene D. Myers" <edm@tycho.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Chris Babcock <cbabcock@luthresearch.com>
CC: <mayerf@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <BCDBA110.10B6A%edm@tycho.ncsc.mil>
In-Reply-To: <20040527080750.GA13687@lkcl.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/27/04 04:07, "Luke Kenneth Casson Leighton" <lkcl@lkcl.net> wrote:

> 
> "The goal is to build on National Security Agency (NSA) research using
> virtual machines to provide separation of security domains on one
> desktop.
> 
> The effort uses VMware 3.02, which has already been evaluated by the
> NSA. There are also plans to add support for Microsoft's Virtual Machine
> Monitor. "
> 
> 
> 
> vmware, as you are no doubt aware, runs an entirely separate x86
> virtual machine (for which they have licensed phoenix bios).
> 
> so it's completely compartmentalised and you do not need to add
> in any security into the host OS other than banning it from
> network access.
> 
> this is a _goooood_ thing: with the focus on speed and functionality
> (e.g the screen driver redirection layer being removed from
> nt 3.51 for the nt 4.0 release) NT has gone downhill to the
> quality and security of windows 3.1 - but for worse, because
> of the hundred fold increase in code to audit.
> 


Not true.  VMWare executes as an application and it uses the host OS for
access to files, devices, etc.  For example, VMWare's virtual disks are, in
reality, files and, therefore, a virtual machine's access to its virtual
disk, etc. is controlled by the operating system.

In NetTop, each virtual machine is assigned a specific type (for example,
vm1_d) and the files that contain the virtual disks are assigned a different
type (for example, vm1_t).  Each virtual machine type vmX_d (where X is an
arbitrary number) can only access files (virtual disks) of type vmX_t.

The restriction means that each virtual machine can only access only its
virtual disks.

In NetTop, the SELinux policy is written such that -->Only<-- only a VM can
access a virtual disk and only its associated virtual disk.  No other
process (including other VM's) have permission to access a VM's virtual
disk.  This includes processes that execute with root permission.

This is a significant point.  In systems, where data separation is
important, being able to show that data cannot flow (in this case from one
VM to another, which can happen if a VM gains access to another VM's virtual
disk) is an important property of a mandatory policy.  In the NetTop policy,
the VMware virtual machines are isolated from the rest of the system and
data flows into and out of a virtual machine, only if the policy allows it.

> 
> another hint is that they are focussing on network access so
> presumably that means writing a special / modified VMware network
> driver.
> 
> 
> ... anyway, what's this got to do with SE/Linux? :)
> 
> no.
> 
> you don't think they're seriously considering running SE/Linux
> in those vmware sessions do you?
> 
> 
> 
> On Wed, May 26, 2004 at 04:49:00PM -0700, Chris Babcock wrote:
>>> Stephen Smalley wrote:
>>>> Looks like Microsoft is indeed pushing an XP-based NetTop
>>>> called Trusted Multi-Net/Typhon XP, e.g.:
>>>> 
>>>> http://www.computerweekly.com/Article123730.htm
>>>> 
>>> http://download.microsoft.com/download/4/f/8/4f89f896-f020-46d1-adc0-08a18c8
>>> 432d
>>> 5/Trusted%20Multi-Net%20for%20SSE%202003.ppt
>>> 
>> 
>> Interesting.
>> 
>> The slides indicate that in their system threads are able to change what
>> context they run in.
>> 
>> It makes me wonder if they have some magic to prevent threads from
>> poluting shared data (unlikely), or if it is just a hack to avoid process
>> vs. thread design issues on windows.
>> 
>> -Chris
>> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
