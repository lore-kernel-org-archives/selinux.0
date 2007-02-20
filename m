MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: checkpolicy/policy_parse.y:define_class: allow classidentifiers to contain dots
Date: Tue, 20 Feb 2007 10:49:27 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015888BA437@exchange.columbia.tresys.com>
In-Reply-To: <1171985130.14363.54.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Caleb Case" <ccase@tresys.com>
Cc: <kmacmillan@mentalrootkit.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Tue, 2007-02-06 at 11:31 -0500, Caleb Case wrote:
> > Class identifiers are now allowed to contain dots.  This 
> facilitates the new dot notation for class names used in metapolicy.
> > ---
> >  checkpolicy/policy_parse.y |    5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > Index: selinux-pms-support/checkpolicy/policy_parse.y
> > ===================================================================
> > --- selinux-pms-support.orig/checkpolicy/policy_parse.y
> > +++ selinux-pms-support/checkpolicy/policy_parse.y
> > @@ -929,11 +929,6 @@ static int define_class(void)
> >  		yyerror("no class name for class definition?");
> >  		return -1;
> >  	}
> > -	if (id_has_dot(id)) {
> > -		free(id);
> > -		yyerror("class identifiers may not contain periods");
> > -		return -1;
> > -	}
> >  	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
> >  	if (!datum) {
> >  		yyerror("out of memory");
> 
> I merged this patch to -stable and -trunk, but am now having 
> second thoughts.  Class identifiers with dots in them would 
> pose a problem for symbol definition generation, no?
> 

Yes, we have patches to refpolicy that replace dots with something else
for symbol definitions. Hopefully this is just a workaround until class
discovery is done and integrated with upstream and the existing object
managers.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
