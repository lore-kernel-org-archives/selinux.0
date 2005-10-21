Subject: Re: MLS context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.63.0510210946190.6334@excalibur.intercode>
References: <200510152027.59150.russell@coker.com.au>
	 <200510182133.56086.russell@coker.com.au>
	 <1129731662.2375.164.camel@moss-spartans.epoch.ncsc.mil>
	 <200510211252.18124.russell@coker.com.au>
	 <Pine.LNX.4.63.0510210011040.4922@excalibur.intercode>
	 <1129893750.2375.517.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.63.0510210946190.6334@excalibur.intercode>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 09:50:43 -0400
Message-Id: <1129902643.27663.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 09:46 -0400, James Morris wrote:
> What happens if we add another security model?

MLS code can likely infer when to stop processing the context based on
the content.  In any event, introducing another field is a non-trivial
change no matter what (consider the amount of change required just to
enable MLS by default in Fedora - libsetrans translations to hide or add
the level as needed, kernel hacks to provide compatibility, seusers to
map Linux users to levels without needing to modify policy, extended
libselinux interfaces for selecting level, ...).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
