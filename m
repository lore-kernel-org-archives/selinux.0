Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DEVXrT002913
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 10:31:34 -0400 (EDT)
Message-ID: <4145AF38.6000801@redhat.com>
Date: Mon, 13 Sep 2004 10:31:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ssh policy
References: <200409090428.52881.russell@coker.com.au> <4141BF21.9050004@redhat.com> <1094828891.28310.52.camel@moss-spartans.epoch.ncsc.mil> <200409111913.11677.russell@coker.com.au>
In-Reply-To: <200409111913.11677.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Sat, 11 Sep 2004 01:08, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
>  
>
>>>-r_dir_file(updfstab_t, { selinux_config_t file_context_t
>>>default_context_t } ) can_getsecurity(updfstab_t)
>>>+dontaudit updfstab_t selinux_config_t:dir search;
>>>      
>>>
>>I don't think that this is correct; updfstab appears to be looking up a
>>context via matchpathcon for preserving the context on /etc/fstab, so it
>>needs access to the file contexts file as in our policy.
>>    
>>
>
>Why do we want to have updfstab do that?  Adding such functionality to 
>updfstab means more work for it to do, more time taken to complete, etc.
>
>Just having updfstab create the new file as /etc/fstab.new (or similar) makes 
>it get the right context automatically with much less effort.
>
>We don't want to change every program that creates a file to preserve the SE 
>Linux context!  That would take significant development work and create 
>significant issues if the SE Linux interfaces ever change.
>
>The source to fstab-sync refers to the idea of creating a new fstab file 
>in /tmp if /etc is mounted read-only (with /etc/fstab being a sym-link to 
>somewhere else).  If this is implemented as described in the comments then an 
>inopportune power failure or system crash could potentially truncate the 
>fstab file and make the system non-bootable.  I think we should give up on 
>the idea of having fstab-sync do anything special in regard to SE Linux.
>
>Dan, what do you think?
>
>  
>
Talked to the person who did this and he is fixing it.  It came about 
because the temp file was originally
being created on /tmp but now is created in /etc/.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
