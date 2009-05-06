Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n46FUv8S027185
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 11:30:57 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n46FUu9a019251
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 15:30:56 GMT
Message-ID: <4A01AD2E.7040900@redhat.com>
Date: Wed, 06 May 2009 11:30:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mark Webb <elihusmails@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: policy development library documentation
References: <9f066ee90905060814m138c27a8g16d0e8b6a7b8fc00@mail.gmail.com>
In-Reply-To: <9f066ee90905060814m138c27a8g16d0e8b6a7b8fc00@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/06/2009 11:14 AM, Mark Webb wrote:
> Greetings,
>
> I am interested in writing a tool that will open and process a policy
> file.  I was looking around and was unable to determine the proper
> libraries to do this as most of the tools are written in python and
> the libs are written in C, so tracing is a little more difficult.  I
> would like to write this tool in C.
>
> So my question is; where can I find documentation on the libraries
> that would do this work?  I have the source code for the setools
> project, and do not see much for documentation of the functions.
>
> Thanks,
> Mark
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Look at libsepol, libsemanage and libapol



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
