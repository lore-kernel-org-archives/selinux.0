Message-ID: <1340106887.18291.13.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android patch -- Fix for bug on factory labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Date: Tue, 19 Jun 2012 07:54:47 -0400
In-Reply-To: <CAFftDdrLvViiy2dHyokrZdemJvoEV3+8DTh5HRCfrp8icpC0Tw@mail.gmail.com>
References: 
	<CAFftDdrLvViiy2dHyokrZdemJvoEV3+8DTh5HRCfrp8icpC0Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-18 at 22:10 -0700, William Roberts wrote:
> A bug introduced in device/samsung/tuna on
> commit 6fc73cf6d9e05d9e20009bf88c2f028657bc2ebd on branch seandroid
> caused factory bluetooth to get mislabeled and was not caught. I
> discovered this today while using a maguro for awhile. This patch
> fixes that introduced bug.

Thanks, applied.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
