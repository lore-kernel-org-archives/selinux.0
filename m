Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n635pRb7005975
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 01:51:27 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n635q4wO013307
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 05:52:05 GMT
Date: Fri, 3 Jul 2009 15:51:26 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Justin P. Mattock" <justinmattock@gmail.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SElinux: Fix some typos.
In-Reply-To: <4A4D7C94.2020307@gmail.com>
Message-ID: <alpine.LRH.2.00.0907031544160.12340@tundra.namei.org>
References: <1246556775-8942-1-git-send-email-justinmattock@gmail.com> <1246556775-8942-2-git-send-email-justinmattock@gmail.com> <alpine.LRH.2.00.0907030850500.10242@tundra.namei.org> <4A4D7C94.2020307@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Jul 2009, Justin P. Mattock wrote:

> No I will not be afraid of submitting patches, and having them be rejected.
> all part of the learning curve.

I'd suggest generally not starting out with spelling, grammatical and 
formatting patches.  It eats reviewer bandwidth, perturbs the codebase 
(causing people working on it to have to update their code) and does not 
give you as much opportunity to to learn about the code.

Try fixing smaller, known bugs or adding small useful changes.

The TODO list for the SELinux kernel code is here:
http://selinuxproject.org/page/Kernel_Development

You can also email the maintainers and ask for suggestions on what to 
tackle.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
