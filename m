Subject: Re: [PATCH] don't do pointless NULL checks and casts before
	kfree() in security/
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
   David Howells <dhowells@redhat.com>, Chris Vance <cvance@nai.com>,
   Wayne Salamon <wsalamon@nai.com>, James Morris <jmorris@redhat.com>,
   dgoeddel@TrustedCS.com, Karl MacMillan <kmacmillan@tresys.com>,
   Frank Mayer <mayerf@tresys.com>, selinux@tycho.nsa.gov,
   Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 10:00:29 -0500
Message-Id: <1111503629.15346.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-03-20 at 13:29 +0100, Jesper Juhl wrote:
> kfree() handles NULL pointers, so checking a pointer for NULL before 
> calling kfree() on it is pointless. kfree() takes a void* argument and 
> changing the type of a pointer before kfree()'ing it is equally pointless.
> This patch removes the pointless checks for NULL and needless mucking 
> about with the pointer types before kfree() for all files in security/* 
> where I could locate such code.
> 
> The following files are modified by this patch:
> 	security/keys/key.c
> 	security/keys/user_defined.c
> 	security/selinux/hooks.c
> 	security/selinux/selinuxfs.c
> 	security/selinux/ss/conditional.c
> 	security/selinux/ss/policydb.c
> 	security/selinux/ss/services.c
> 
> (please keep me on CC if you reply)
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

The diffs to selinux look fine to me, and the resulting kernel seems to
be operating without problem.  Feel free to send along to Andrew Morton.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
