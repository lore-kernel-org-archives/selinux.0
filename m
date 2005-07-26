Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 17:03:50 -0400
Message-Id: <1122411830.4470.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 16:53 -0400, Valdis.Kletnieks@vt.edu wrote:
> security: conflicting type rules when adding type rule for true.
<snip>
> This ring any bells, or suggest debugging next steps?

Run checkpolicy -b on the same binary policy file, and see if you get
the same error from it.  Is your policy a standard one?  If not, is it
available somewhere for examination?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
