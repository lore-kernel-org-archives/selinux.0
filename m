Subject: Re: Bugs with bool_ids usage (libsepol)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Cedric Roux <Cedric.Roux@eurecom.fr>, selinux@tycho.nsa.gov
In-Reply-To: <1148570661.10246.27.camel@jackjack.columbia.tresys.com>
References: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
	 <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
	 <1148569615.20976.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1148570661.10246.27.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:51:27 -0400
Message-Id: <1148572287.20976.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 11:24 -0400, Karl MacMillan wrote:
> What about this patch instead - it seems to make the usage of nbools and
> bool_ids more natural and potentially improves the comparison speed for
> larger conditionals.

Not clear, given that you are only using the bool_ids for the
precomputation and it is still limited to the same max.  Patch was
malformed, btw.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
