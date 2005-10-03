Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
References: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 11:41:37 -0400
Message-Id: <1128354097.26285.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 10:40 -0400, Karl MacMillan wrote:
> I guess I meant backwards compatibility - are you suggesting to drop that?

Hmm...I suppose not.   Although, AFAIK, only Fedora is using the local
booleans and users support presently, and they could always coordinate
the update of the entire infrastructure.

Ok, so it sounds like we want to drop the optional path argument, retain
the preservebools flag argument and its functionality, and add a
setlocaldefs flag argument to control the use of sepol_genusers/genbools
functionality.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
