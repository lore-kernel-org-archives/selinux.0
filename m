Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JF0Rb009202
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:15:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1JEJp7029715
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:14:20 GMT
Date: Mon, 1 Dec 2003 19:14:56 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles and non-SE systems
Message-ID: <20031201191456.GO11972@vnl.com>
References: <200312012102.00554.russell@coker.com.au> <1070289743.12270.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070289743.12270.91.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 09:42:23AM -0500, Stephen Smalley wrote:
> Right, if the xattr handlers for the security namespace were added to
> the EA/ACL patches, then you could assign the security.selinux
> attributes on a kernel with only those patches.  However:
> - that still requires a patched kernel (unless those patches
> get upstreamed to mainline 2.4)
> - If you are going to build a patched kernel, then you might as
> well build a SELinux kernel and just boot with selinux=0 to perform the
> initial labeling.  Same end result, a kernel that has the xattr handler
> but isn't running SELinux.

Point taken. I probably could live with that... 

Question though: I take it that all that is needed is
the EA/ACL security attributes. Like the handler
I did for reiserfs I take it? 

Anyway Steve, thanks for the ideas. I'm going to go
off and look into approaches based on the above and
see if it works out for me.

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
