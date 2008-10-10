Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9A28ieT021298
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 22:08:44 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9A28iaK029878
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 02:08:44 GMT
Message-ID: <48EEB91C.4080205@redhat.com>
Date: Fri, 10 Oct 2008 12:08:28 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: Archiving Files with tar/star
References: <48EDAE09.8070903@redhat.com> <48EDEFB9.9090702@redhat.com> <48EE9415.6050902@redhat.com> <200810101251.30094.russell@coker.com.au>
In-Reply-To: <200810101251.30094.russell@coker.com.au>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Friday 10 October 2008 10:30, Murray McAllister <mmcallis@redhat.com> 
> wrote:
>>> tar xvf file.tgz | restorecon -f -
>>>
>>> Would reset the file context on disk after the extraction.
>> Does this only apply to the tar file itself, not the files in it? On
>> rawhide the extracted files (that have extended attributes) inherit the
>> type of the directory they are being extracted in.
> 
> The "v" option of tar causes it to list on stdout all the files it extracts.
> 
> The -f- option of restorecon makes it take a list of files to relabel on 
> stdin.  So it relabels all files extracted from the tar file.
> 
> The inheriting of file contexts from a directory (in the absence of policy 
> rules specifying otherwise) has AFAIK always been the design of SE Linux.

When would "tar | restorecon -f -" be used if files inherit contexts 
from parent directories (if policy has not be changed)? Sorry, I am a 
bit slow :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
