Message-ID: <413F1DD8.2000201@redhat.com>
Date: Wed, 08 Sep 2004 10:57:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters
 for dbus.
References: <413E1DE0.9050905@redhat.com> <1094645825.20215.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094645825.20215.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2004-09-07 at 16:45, Daniel J Walsh wrote:
>  
>
>>Adding
>>
>>restorecon /dev /dev/null
>>restorecon /dev/*
>>    
>>
>
>Adding them where?  If you do this from /sbin/init immediately after the
>initial policy load, then I would have expected that you wouldn't need
>to insert tmpfs_t in as many places, as only init and restorecon would
>then need to temporarily access /dev while it was still labeled tmpfs_t.
>
>  
>
It is the fealing here to keep the init program as simple as possible 
for maintainability, bugs in it are very difficult to debug, so the
restorecon will remain in the rc.sysinit scripts.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
