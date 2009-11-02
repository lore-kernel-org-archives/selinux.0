Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA2MCpnL016382
	for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2009 17:12:51 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nA2MEjTt007930
	for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2009 22:14:46 GMT
Date: Mon, 02 Nov 2009 17:12:49 -0500
Subject: Re: [PATCH 1/2] policycoreutils: share setfiles restore function with
 restorecond
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: <selinux@tycho.nsa.gov>, <kangchao@WPI.EDU>, Thomas Liu <tliu@redhat.com>
Message-ID: <C714C391.ABA8A%csellers@tresys.com>
In-Reply-To: <4AE9A351.7070602@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/29/09 10:14 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Chad, once you have patch 1 in I will send you the restorecond patch, with all
> the missing files.

Sounds good. And this will have split out the refactoring patch from the
functional changes (new options, adding DBUS support), right?

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
