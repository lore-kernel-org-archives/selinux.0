Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42GE09L004960
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:14:00 -0400
Received: from pop06.mail.atl.earthlink.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42GDxUP002165
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:13:59 GMT
Message-ID: <44578536.9060106@mindspring.com>
Date: Tue, 02 May 2006 12:13:42 -0400
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: We are attempting once again to split policy out into individual
 RPMS.
References: <44576B91.8060607@redhat.com>
In-Reply-To: <44576B91.8060607@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
<snip>

> 
> We need the ability for RPM to be able to write a file context on disk 
> without the kernel verifying it.  The kernel should treat this as an 
> unlabeled_t file. the same way it would if I ran
> 
> semodule -i XYZ.pp
> restorecon /usr/bin/XYZ
> semoduel -e XYZ
> 
> I don't think this is an unreasonable request to allow rpm_t to have the 
> privilege of writing the "invalid" context to disk.
> 
> Secondly the rpm team would like to be able to execute the equivalent of 
> matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping from the 
> policy package and combine it with the on disk representation to 
> determine the file context to associate with the new files being put on 
> disk.
> 
> At the end of the rpm install, postinstall would do an semodule -i XYZ.pp.
> 
> We want to start out with just a couple of packages shipping policy to 
> prove the technology and then to allow third parties to ship using this 
> method.
> 
> Dan


What if the files being installed were already labeled with the context?
I.e after the files are built but before being packaged into the rpm, 
the context is applied to the file.

Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
