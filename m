Message-ID: <1334341778.10083.13.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: [UPDATED] Patch for SE Android Manager AVC logging feature
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: William Roberts <bill.c.roberts@gmail.com>
Cc: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov,
        rpcraig
	 <rpcraig@tycho.ncsc.mil>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 13 Apr 2012 14:29:38 -0400
In-Reply-To: <CAFftDdpgZ=X_kEqPMNWNHNqrJd+r8b3wub4Jj6R=5SLZktB4Bg@mail.gmail.com>
References: 
	<CAFftDdpgZ=X_kEqPMNWNHNqrJd+r8b3wub4Jj6R=5SLZktB4Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-04-11 at 14:05 -0400, William Roberts wrote:
> This patch enables the avc denied logging feature in the SE
> Android SEAndroidManager application.
> 

Merged with a couple of minor whitespace fixes.
I also added policy so that SEAndroidManager can read the syslog.

Thanks,

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
