Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j35DsJDo008297
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 09:54:20 -0400 (EDT)
Subject: Re: Tweaks to the clamav policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: David Hampton <hampton-rh@rainbolthampton.net>
Cc: SELinux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
In-Reply-To: <1110979071.20316.17.camel@hampton-pc.rainbolthampton.net>
References: <1110979071.20316.17.camel@hampton-pc.rainbolthampton.net>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 09:53:21 -0400
Message-Id: <1112709201.1883.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged into the SELinux policy CVS tree at sourceforge.

On Wed, 2005-03-16 at 08:17 -0500, David Hampton wrote:
> I've added support to the (unused) clamav policy to allow listening for
> service requests on a TCP socket, and for interacting with amavis.  I
> also made some tweaks that  tighten up the network access allowed by
> freshclam, split the freshclam and spamd log files into two different
> types, and make the clamd control socket a unique type.  Thanks.
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
