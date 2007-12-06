Subject: RE: [patch 0/2] policy capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880145614C@exchange.columbia.tresys.com>
References: <20071205184848.180973622@tresys.com>
	 <200712051421.39624.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
	 <4757073B.70907@manicmethod.com>
	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
	 <47570BAC.3050705@manicmethod.com>
	 <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil>
	 <4757109B.2080209@manicmethod.com>
	 <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil>
	 <475826F2.1000601@manicmethod.com>
	 <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880145614C@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 16:24:01 -0500
Message-Id: <1196976241.27508.219.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-06 at 15:24 -0500, Todd Miller wrote:
> Stephen Smalley wrote:
> > Upgrade of base usually reflects a full policy update, whereas
> > inserting a random module does not.  And if base doesn't work (e.g.
> > doesn't have the capabilities it requires), then the system likely
> > won't boot or function at all (modulo legacy rules).  I'm more
> > comfortable with letting base dictate the policy capabilities than
> > other modules. 
> 
> So if I understand correctly you are suggesting we restrict the
> declaration of policycaps to base.  I have a version of the patch
> set that does this--attempting to set a policycap in a module other
> than base results in a syntax error from checkpolicy.  If that is
> how we want to proceed I can send it out, the differences from the
> last one are minor as you might expect.

I'm inclined toward that approach.

It does retain the difference between base and non-base, but I doubt
that distinction will ever go away fully even if they ultimately use the
same format and can support (most of) the same content.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
