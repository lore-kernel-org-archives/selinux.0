Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JNLRb009307
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:23:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1JNKqY022850
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:23:20 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB1JNJ0o022847 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:23:19 GMT
Subject: Re: setfiles and non-SE systems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <20031201191456.GO11972@vnl.com>
References: <200312012102.00554.russell@coker.com.au>
	 <1070289743.12270.91.camel@moss-spartans.epoch.ncsc.mil>
	 <20031201191456.GO11972@vnl.com>
Content-Type: text/plain
Message-Id: <1070306592.12270.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 14:23:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 14:14, Dale Amon wrote:
> Point taken. I probably could live with that... 
> 
> Question though: I take it that all that is needed is
> the EA/ACL security attributes. Like the handler
> I did for reiserfs I take it? 
> 
> Anyway Steve, thanks for the ideas. I'm going to go
> off and look into approaches based on the above and
> see if it works out for me.

The handlers are already in 2.6.  So you can build a 2.6 kernel with the
handlers and no SELinux without any patching (or you can just take a 2.6
SELinux kernel and boot with selinux=0).  For 2.4, Jim Carter does have
separate patches to add the xattr security handlers for ext2 and ext3 to
the EA/ACL patches, so if you want those patches, he can just send them
to you.  Or, you can just build a 2.4 SELinux kernel and boot with
selinux=0.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
