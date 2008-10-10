Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9A1pexA018935
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 21:51:40 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9A1oPYU029404
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 01:50:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Murray McAllister <mmcallis@redhat.com>
Subject: Re: user guide drafts: Archiving Files with tar/star
Date: Fri, 10 Oct 2008 11:51:27 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <48EDAE09.8070903@redhat.com> <48EDEFB9.9090702@redhat.com> <48EE9415.6050902@redhat.com>
In-Reply-To: <48EE9415.6050902@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810101251.30094.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 10 October 2008 10:30, Murray McAllister <mmcallis@redhat.com> 
wrote:
> > tar xvf file.tgz | restorecon -f -
> >
> > Would reset the file context on disk after the extraction.
>
> Does this only apply to the tar file itself, not the files in it? On
> rawhide the extracted files (that have extended attributes) inherit the
> type of the directory they are being extracted in.

The "v" option of tar causes it to list on stdout all the files it extracts.

The -f- option of restorecon makes it take a list of files to relabel on 
stdin.  So it relabels all files extracted from the tar file.

The inheriting of file contexts from a directory (in the absence of policy 
rules specifying otherwise) has AFAIK always been the design of SE Linux.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
