Message-ID: <5266C4EE.4080803@tycho.nsa.gov>
Date: Tue, 22 Oct 2013 14:33:18 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] --handle-unknown option takes a required argument
References: <1373113953-16739-1-git-send-email-bigon@debian.org>
In-Reply-To: <1373113953-16739-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/06/2013 08:32 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Fix a segmentation fault if the --handle-unknown option was set without
> arguments.
> 
> Thanks to Alexandre Rebert and his team at Carnegie Mellon University
> for detecting this crash.

Thanks, merged.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
