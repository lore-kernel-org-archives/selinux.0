Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB20hNRb011648
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:43:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB20hMqa006709
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 00:43:22 GMT
Date: Tue, 2 Dec 2003 00:43:21 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Re: setfiles and non-SE systems
Message-ID: <20031202004321.GS11972@vnl.com>
References: <200312012102.00554.russell@coker.com.au> <1070289743.12270.91.camel@moss-spartans.epoch.ncsc.mil> <20031201191456.GO11972@vnl.com> <1070306592.12270.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070306592.12270.216.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 02:23:13PM -0500, Stephen Smalley wrote:
> The handlers are already in 2.6.  So you can build a 2.6 kernel with the
> handlers and no SELinux without any patching (or you can just take a 2.6
> SELinux kernel and boot with selinux=0).  For 2.4, Jim Carter does have
> separate patches to add the xattr security handlers for ext2 and ext3 to
> the EA/ACL patches, so if you want those patches, he can just send them
> to you.  Or, you can just build a 2.4 SELinux kernel and boot with
> selinux=0.

I'll probably go the 2.6.0-test10 route. I'm in the
process of upgrading my workstation and some other
machines to debian sarge dist so since I'll probably
break everything tonight anyway, I might as well do
that at the same time.

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
