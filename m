Message-ID: <1319468868.3280.9.camel@localhost>
Subject: Re: [PATCH 1/2] LSM: Do not apply mmap_min_addr check to PROT_NONE
 mappings
From: Eric Paris <eparis@parisplace.org>
To: Roland McGrath <roland@hack.frob.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>, Stephen
 Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, John Johansen
 <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Oct 2011 11:07:48 -0400
In-Reply-To: <20111023185243.EFE2F2C08F@topped-with-meat.com>
References: <20111021213916.914462C0A5@topped-with-meat.com>
	 <CA+55aFy3ALC34AyrsHi9yjBgRMwg9G5w2PhDfr_JVti1M8GbNQ@mail.gmail.com>
	 <20111022172450.0BCCE2C0A9@topped-with-meat.com>
	 <CA+55aFx_9D8jY2sqcZ+Tm305W9d8o+ZhEv8XNWuN4--S2bqRwQ@mail.gmail.com>
	 <20111023185243.EFE2F2C08F@topped-with-meat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-10-23 at 11:52 -0700, Roland McGrath wrote:

> > But that's no reason for the kernel to *allow* the mapping.
> 
> I don't have a problem with that.

I feel like, and it's just a very vague feeling, that the PROT bits
didn't matter to the kernel.  It would still happily execute stuff on
page 0 even without PROT_EXEC at some point in the past.  I'm probably
totally off base, and I could test it, but I sort of feel like I
remember something like that....

If that's the case, NULL pointer kernel bugs won't be caught if they
happen while these are mapped by your program...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
