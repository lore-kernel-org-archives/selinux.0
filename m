Date: Thu, 26 Feb 2004 17:47:07 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: PaX + selinux integration update
Message-ID: <20040226164707.GC31204@rom.cip.informatik.uni-muenchen.de>
References: <403CF8AB.5080309@snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <403CF8AB.5080309@snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Joshua Brindle <jbrindle@snu.edu> [2004-02-25 21:49]:
> These are the fixed up versions thanks to Chris Pebenito, the kernel 
> patch no longer specifies defaults, so now all decisions come directly 
> from policy.
> 
> Also the excess amount of denials will not be displayed per policy

Great! I think this is really useful work!

Do you think there is any chance of integrating your work into PAX? I
understand that your patch will not go into the kernel in the near future, 
but if it was at least integrated into PAX it would be much more likely
to be used.

I think a lot of people use ExecShield because the patch is not too big
and supported by RedHat. If PAX with proper SELinux-support was
available as a single patch more people would consider using it on
production systems where every additional patch counts.

Thomas

-- 
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7
"Work like you don't need the money, love like you've never been hurt
and dance like you do when nobody's watching."

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
