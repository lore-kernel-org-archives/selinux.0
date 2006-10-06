Subject: RE: Denials from newest kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <1160147877.2876.3.camel@twoface.columbia.tresys.com>
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
	 <1160147877.2876.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 12:25:03 -0400
Message-Id: <1160151903.12253.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 11:17 -0400, Joshua Brindle wrote:
> > > 3) domains polmatch spd's (which are classified as associations)
> > 
> > I wish the association class were renamed more like "ipsec" considering
> > the only 2 perms used in there are polmatch and setcontext.
> 
> why not do it? none of this is merged yet.

Um, association class has been present since 2.6.16, and polmatch is
already in 2.6.19-rc1.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
