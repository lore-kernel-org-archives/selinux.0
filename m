Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9BBHVPg006709
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2008 07:17:31 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9BBGFOd019631
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2008 11:16:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Murray McAllister <mmcallis@redhat.com>
Subject: Re: user guide drafts: Maintaining SELinux Labels
Date: Sat, 11 Oct 2008 21:17:13 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <737og9$5vh3i@dmzms99902.na.baesystems.com> <1223643319.25569.23.camel@moss-spartans.epoch.ncsc.mil> <48F02876.3020203@redhat.com>
In-Reply-To: <48F02876.3020203@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810112217.15754.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 11 October 2008 15:15, Murray McAllister <mmcallis@redhat.com> 
wrote:
> When files and directories are copied, the SELinux context of the new
> file or directory depends on the context of the creating process, and
> the context of the target, parent directory: the type is inherited from
> the target, parent directory (unless a type transition rule exists[1]);
> the SELinux user identity and level are inherited from the creating
> process; and the role is always object_r, which is a generic role for
> files. This helps ensure files and directories are labeled with the
> correct SELinux context after being copied.

I'm not sure how the last sentence is supposed to link with the rest - it 
certainly doesn't correspond to the second-last sentence.

object_r is for future support and also to give a regular format of the 
context for all operations.  Note that files under /proc that relate to 
processes have different roles.

> Also, when a file is copied over an existing file, the existing file's
> context is maintained, unless the user specified cp options to preserve
> the context of the original file, such as --preserve=context.

Also the -Z option to cp deserves a mention.

> #Is the following required, or is it covered by the above:
>
> On systems running the MLS policy, when files and directories are
> copied, they inherit the type from the parent directory they are being
> copied to, and the level from the process that copied them.

Probably.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
