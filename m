Subject: Re: [PATCH] Basic policy representation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <46408CF6.1050409@manicmethod.com>
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>
	 <46408CF6.1050409@manicmethod.com>
Content-Type: text/plain
Date: Tue, 08 May 2007 12:50:53 -0400
Message-Id: <1178643053.6056.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 10:45 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
>snip>
> > +static char *typeid_strings[] = {
> > +	"none",
> > +	"object",
> > +	"parent",
> > +	"policy",
> > +	"module",
> > +	"block",
> > +	"cond",
> > +	"optional",
> > +	"type",
> > +	"class",
> > +	"attribute",
> > +	"typealias",
> > +	"boolean",
> > +	"avrule",
> > +	"typerule",
> > +	"security context",
> > +	"initial sid",
> > +	"typeattribute",
> > +	"conditional expression",
> > +	"sensitivity",
> > +	"dominance",
> > +	"category",
> > +	"role dominance",
> > +	"role"
> > +};
> > +
> >   
> It would be nice if these were in the same place as the enum so they 
> could be updated easier, but I understand that the strings are private 
> and the enum is exported :\

One thing that would make them nicer for maintenance and readability
would be explicit indices in the array definition here, ala:
static char *typeid_strings[] = {
[SEPOL_TYPEID_NONE] = "none",
[SEPOL_TYPEID_OBJECT] = "object",
...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
