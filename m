Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09DZT5V020487
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 08:35:29 -0500
Received: by mail-we0-f180.google.com with SMTP id t61so2760584wes.39
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 05:35:27 -0800 (PST)
Message-ID: <1389274525.14773.32.camel@x220.localdomain>
Subject: Re: [RFC] CIL and Source Policy Integration
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Thu, 09 Jan 2014 14:35:25 +0100
In-Reply-To: <52CDB8AC.4090504@tresys.com>
References: <52CDB8AC.4090504@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2014-01-08 at 15:44 -0500, Steve Lawrence wrote:

> Thanks, and we look forward to receive your feedback.

I played with this a bit this morning. Followed all steps.

(it was missing some trivial instructions like install git, gcc and
bison) (no big deal but still might be worth mentioning for others)

You also may want to relabel the file system when all other steps are
done

We are instructed to "cp
-r /etc/selinux/targeted/{contexts,seusers,setrans.conf} /etc/selinux/cil-test/"

Would be nice if we could get rid of the step because it introduces
inconsistency in the policy

One really visible result is that for some reason files that are created
(using a non-mls cilpolicy as per instructions) end up mislabeled
because they are created without the mls attribute (for instance
without :s0). SELinux considers those invalid (unlabeled) even though it
is non-mls policy. The contexts we had to copy
from /etc/selinux/targeted are valid because existing objects (with :s0)
are fine. The problem is the objects that creating in a running system.

I will keep tinkering
