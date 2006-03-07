Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27IA5A6001734
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 13:10:05 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k27IA3RX012321
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 18:10:03 GMT
Subject: Re: Tor module for refpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1140829878.8976.22.camel@wintermute.xmldesign.de>
References: <1140829878.8976.22.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 13:14:21 -0500
Message-Id: <1141755261.30819.141.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-02-25 at 02:11 +0100, Erich Schubert wrote:
> Hello fellow SELinux users,
> attached is a refpolicy module for tor, "the onion router".
> http://tor.eff.org/

Merged, with a few tweaks.

> While looking at the other modules in refpolicy for examples I came
> across the following line:
> dev_associate_usbfs(zebra_var_run_t)
> this line can't be right, can it? I mean, zebra_var_run_t is a file
> domain...
> shouldn't this throw some assertion error?

No, this rule exists in the example policy, which is why it is in
reference policy.  We haven't begun efforts to try to eliminate rules
like this since not all modules from the example policy have been
converted to refpolicy.  When all modules are converted, it will be much
simpler to see questionable rules, as you saw.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
