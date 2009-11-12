Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nACHfRXm023890
	for <selinux@tycho.nsa.gov>; Thu, 12 Nov 2009 12:41:27 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nACHePCC028819
	for <selinux@tycho.nsa.gov>; Thu, 12 Nov 2009 17:40:26 GMT
Message-ID: <4AFC48C6.7000806@redhat.com>
Date: Thu, 12 Nov 2009 12:41:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: David C Casler <david.casler@us.ibm.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Using IBM's GPFS with SE Linux Extended Attributes
References: <OF1F451064.9EB65F42-ON8725766B.0067616B-8725766B.0067833A@us.ibm.com>
In-Reply-To: <OF1F451064.9EB65F42-ON8725766B.0067616B-8725766B.0067833A@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/11/2009 01:50 PM, David C Casler wrote:
> 
> Has anyone had success using IBM's General Parallel File System (GPFS) in
> such a way that it respects SE Linux extended file attributes? I'm turning
> up blanks everywhere I look, and there are those who say it can't be done.
> 
> Dave Casler, IBM Global Services
> Senior IT Architect
> Voice: +1-970-964-5350
> e-mail: david.casler@us.ibm.com
SELinux policy does not know what a gpfs is, so it would not know whether or not it supports extended attributes.

Why is the file system type?


Probably need a line in policy like

fs_use_xattr gpfs gen_context(system_u:object_r:fs_t,s0);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
