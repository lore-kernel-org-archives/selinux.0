Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9C6J9qc019993
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 02:19:09 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9C6HsR9028735
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 06:17:54 GMT
Message-ID: <48F196BF.50102@redhat.com>
Date: Sun, 12 Oct 2008 16:18:39 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: Maintaining SELinux Labels
References: <737og9$5vh3i@dmzms99902.na.baesystems.com> <1223643319.25569.23.camel@moss-spartans.epoch.ncsc.mil> <48F02876.3020203@redhat.com> <200810112217.15754.russell@coker.com.au>
In-Reply-To: <200810112217.15754.russell@coker.com.au>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 11 October 2008 15:15, Murray McAllister <mmcallis@redhat.com> 
> wrote:
>> When files and directories are copied, the SELinux context of the new
>> file or directory depends on the context of the creating process, and
>> the context of the target, parent directory: the type is inherited from
>> the target, parent directory (unless a type transition rule exists[1]);
>> the SELinux user identity and level are inherited from the creating
>> process; and the role is always object_r, which is a generic role for
>> files. This helps ensure files and directories are labeled with the
>> correct SELinux context after being copied.
> 
> I'm not sure how the last sentence is supposed to link with the rest - it 
> certainly doesn't correspond to the second-last sentence.
> 
> object_r is for future support and also to give a regular format of the 
> context for all operations.  Note that files under /proc that relate to 
> processes have different roles.
> 
>> Also, when a file is copied over an existing file, the existing file's
>> context is maintained, unless the user specified cp options to preserve
>> the context of the original file, such as --preserve=context.
> 
> Also the -Z option to cp deserves a mention.

I started changing the examples to show cp, cp --preserve=context, and 
cp -Z. I had problems with cp -Z on rawhide and fedora 9[1], so I will 
leave that out for now.

Cheers.

[1] <https://bugzilla.redhat.com/show_bug.cgi?id=466653>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
