Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2LMaBND010509
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 18:36:11 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p2LMaA8A029559
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 22:36:11 GMT
Date: Tue, 22 Mar 2011 09:36:00 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
cc: eparis@redhat.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: select correct default LSM_MMAP_MIN_ADDR on
 ARM.
In-Reply-To: <1300145541-30742-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <alpine.LRH.2.00.1103220935430.14837@tundra.namei.org>
References: <1300145541-30742-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Mar 2011, Paul Gortmaker wrote:

> The default for this is universally set to 64k, but the help says:
> 
>    For most ia64, ppc64 and x86 users with lots of address space
>    a value of 65536 is reasonable and should cause no problems.
>    On arm and other archs it should not be higher than 32768.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next-queue

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
