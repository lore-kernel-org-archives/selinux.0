Subject: Re: [POLICYREP] [Patch 0/3] remove modular policy support for
	policy rep branch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Goldman <mgoldman@tresys.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <20070815194633.208081111@tresys.com>>
References: <20070815194633.208081111@tresys.com>>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 16:14:30 -0400
Message-Id: <1187208870.20485.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 15:46 -0400, Mark Goldman wrote:
> This patchset removes module support from libsepol.  This
> patchset is in support of the policyrep work.
> 
> Patch one removes the files that are solely for supporting modular
> policies. 
> 
> Patch two eliminates the various structures that supported modular
> policies. All functional changes occur in this patch.
> 
> Patch three puts dispol in libsepol's utils directory.
> Dispol was not modified in this move.

So then how will you add back read-side support for providing
compatibility with older module/package files?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
