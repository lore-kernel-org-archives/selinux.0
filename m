Message-ID: <1340802641.32737.13.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Patch for rild denial
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 27 Jun 2012 09:10:41 -0400
In-Reply-To: <CAFftDdpPdN6c6wqJMkj0=GZ_BUcDSPAGkCRgHxPK8G94Ag1tdg@mail.gmail.com>
References: 
	<CAFftDdpPdN6c6wqJMkj0=GZ_BUcDSPAGkCRgHxPK8G94Ag1tdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-25 at 12:24 -0700, William Roberts wrote:
> This patch fixes rild trying to access the bluetooth efs dir with read
> perms. 

Thanks, applied.  Please disable html mail when posting patches, and
preferably either generate them via git format-patch or inline them into
the message for easier application.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
