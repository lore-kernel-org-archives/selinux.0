Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6FDhaub007133
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2010 09:43:37 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6FDjXGR014924
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2010 13:45:34 GMT
Message-ID: <4C3F107C.10905@redhat.com>
Date: Thu, 15 Jul 2010 09:43:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: restorecon and chroot
References: <201007151427.01927.russell@coker.com.au>
In-Reply-To: <201007151427.01927.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/15/2010 12:27 AM, Russell Coker wrote:
> I think that we need an option for restorecon which is similar to the -r 
> option of setfiles.
> 
> This would be useful for setting up chroot environments and possibly also for 
> system recovery.
> 
> Any suggestion on what command-line option should be used?  It seems that -r 
> is taken...
> 
Why not just use setfiles, since you will need to specify the
file_context path anyways?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
