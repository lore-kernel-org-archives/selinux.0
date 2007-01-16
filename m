Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0G30Vew023382
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 22:00:31 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0G31Od5026693
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 03:01:24 GMT
Message-ID: <45AC3FE9.3000204@tresys.com>
Date: Mon, 15 Jan 2007 22:00:57 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] add central errno.h to libsepol
References: <45AC06E8.3020708@mentalrootkit.com>
In-Reply-To: <45AC06E8.3020708@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> The attached patch adds a central errno.h to libsepol and converts 
> several existing error numbers. This will unify the error numbers, 
> remove duplication, and prevent overlapping error numbers (a source of 
> potential bugs). Existing return values from functions exposed as part 
> of the binary interface are not changed.
>

instead of adding license to files where it isn't present can we just 
remove it everywhere and have a LICENSE file?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
