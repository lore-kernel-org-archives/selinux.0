Subject: RE: User object manager context location
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Joshua Brindle <jbrindle@tresys.com>
Cc: ewalsh@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158851468B@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158851468B@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 16:05:43 -0400
Message-Id: <1161979543.27616.35.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 15:13 -0400, Joshua Brindle wrote:
> I still don't buy this, if for no other reason than the object labeling
> (even defaults) are owned by the application, not semanage, not the
> policy. These are a resource of the application. What will matchpathcon
> return if there is no file for that object class? Is it going to default
> to an initial sid that may not even make sense for that object class? 

Every object class should have its own default context.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
