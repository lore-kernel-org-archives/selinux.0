Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1EYCRb006933
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:34:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1EYAqa006644
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:34:11 GMT
Date: Mon, 1 Dec 2003 14:34:09 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031201143409.GI11972@vnl.com>
References: <20031129123120.GI18062@vnl.com> <200312010708.37773.russell@coker.com.au> <1070288825.12270.72.camel@moss-spartans.epoch.ncsc.mil> <1070288999.12270.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070288999.12270.76.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 09:29:59AM -0500, Stephen Smalley wrote:
> BTW, this doesn't eliminate the need to have an xattr handler for the
> security namespace; setfiles cannot work without such a handler in the
> kernel.

Can it deal with a loopback image with xattr, where
it is running in a chroot on a non-selinux system? ie,
can it label the files on the loopback? I thought it
would not be able to without an /selinux and a make
load of the policy before hand, neither of which can
be done in this situation. (ie building an image to
be used on a CDROM)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
