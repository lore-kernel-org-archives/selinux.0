Date: Fri, 5 Dec 2008 11:58:00 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] SELinux: Condense super block security structure
 flags and cleanup necessary code.
In-Reply-To: <1228421890-9467-2-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.1.10.0812051156320.11818@tundra.namei.org>
References: <1228421890-9467-1-git-send-email-dpquigl@tycho.nsa.gov> <1228421890-9467-2-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Dec 2008, David P. Quigley wrote:

> +#define SBINITIALIZED	0x10
> +#define SBPROC		0x20

Prefix these with SE_, to prevent possible future namespace collisions 
with the global kernel code.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
