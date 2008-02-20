Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KKJPxr000404
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 15:19:25 -0500
Subject: Re: [PATCH 00/37] Permit filesystem local caching
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <20080220195811.GD16668@sergelap.austin.ibm.com>
References: <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
	 <20080220195811.GD16668@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Feb 2008 15:18:29 -0500
Message-Id: <1203538709.18230.22.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-20 at 13:58 -0600, Serge E. Hallyn wrote:
> 
> Seems *really* weird that every time you send this, patch 6 doesn't seem
> to reach me in any of my mailboxes...  (did get it from the url
> you listed)

That's because patch #6 is 169K.  You also don't get patch #20 which is
140K and patch #14 which is 237K.  

For the SELinux list, messages longer than 100K need to be approved.
Since David can't break his patches into smaller sizes and since he
provides a link to get the whole thing anyway, I don't bother approving
the large patches.  

The LSM list appears to have the same policy.  There are no messages
larger than 100K.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
