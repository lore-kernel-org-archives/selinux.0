Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j35DssDo008330
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 09:54:54 -0400 (EDT)
Subject: Re: Tweaks to the amavis policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: David Hampton <hampton-rh@rainbolthampton.net>
Cc: SELinux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
In-Reply-To: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net>
References: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 09:53:56 -0400
Message-Id: <1112709236.1883.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged into the SELinux policy CVS tree at sourceforge.

On Wed, 2005-03-16 at 08:18 -0500, David Hampton wrote:
> I've added support to the (unused) amavis policy to allow interaction
> with additional mail filters, and added a new type specifically for
> quarantined spam and viruses.  I also tweaked the network access to
> limit ports that can be used by amavisd.  I'd appreciate any feedback on
> these changes or tips on how to write better policies.  Thanks.
> 
> David
> 
> P.S.  These diffs are based on the files from the selinux-policy-strict-
> sources-1.22.1-2 rpm.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
