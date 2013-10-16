Message-ID: <525EE5CE.9090102@tycho.nsa.gov>
Date: Wed, 16 Oct 2013 15:15:26 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 16/16] policycoreutils: Do not include LDFLAGS in CFLAGS
 when building sepolicy
References: <1368189924-8501-1-git-send-email-bigon@debian.org> <1368189924-8501-17-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-17-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/10/2013 08:45 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> For some reasons, -fpie and -fPIE are being set in LDFLAGS, this is
> causing a FTBFS on Debian.
> 
> -fpie and -fPIE are anyway useless for libraries

Thanks, all 16 patches applied.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
