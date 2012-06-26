Message-ID: <1340714140.29157.5.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android Galaxy Nexus recovery image
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 26 Jun 2012 08:35:40 -0400
In-Reply-To: <CAFftDdo-uftuEXjnpPX=SCfNgSM+hD00p-dP4Jg=5L1TwbRqpg@mail.gmail.com>
References: 
	<CAFftDdo-uftuEXjnpPX=SCfNgSM+hD00p-dP4Jg=5L1TwbRqpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-25 at 13:02 -0700, William Roberts wrote:
> The recovery image is not working and their appears to be no bin...
> 
> 
> $ adb logcat
> - exec '/system/bin/sh' failed: No such file or directory (2) -
> 
> 
> Is anyone else getting this?
> 
> 
> I am looking into it now, but I probably wont have time for a week.

Wait, why would you expect that to work from recovery?
out/target/product/<device>/recovery/root shows what is available in the
recovery image, and bin/sh isn't part of that.

That doesn't work for me on Nexus S either, but I don't think it ever
has (or is SE Android related).


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
