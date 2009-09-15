Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8FDfG1x017341
	for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2009 09:41:16 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n8FDgdj5007015
	for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2009 13:42:40 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Howarth <paul@city-fan.org>
Cc: Stefan Schulze Frielinghaus <stefan@seekline.net>, selinux@tycho.nsa.gov
In-Reply-To: <4AAE4802.6050102@city-fan.org>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
	 <1252615167.22997.1.camel@vogon.seekline.net>
	 <1252619448.22997.12.camel@vogon.seekline.net>
	 <20090910232714.2ae22bf2@metropolis.intra.city-fan.org>
	 <1252655581.2491.12.camel@vogon.seekline.net>
	 <1252657231.2491.18.camel@vogon.seekline.net>
	 <1252672214.2937.8.camel@defiant.pebenito.net>
	 <1252678921.2491.51.camel@vogon.seekline.net>
	 <4AAA6A3A.9080202@city-fan.org>
	 <1252933263.7425.113.camel@gorn.columbia.tresys.com>
	 <4AAE4802.6050102@city-fan.org>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 09:39:47 -0400
Message-Id: <1253021987.7425.130.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-14 at 14:41 +0100, Paul Howarth wrote:
> On 14/09/09 14:01, Christopher J. PeBenito wrote:
> > On Fri, 2009-09-11 at 16:18 +0100, Paul Howarth wrote:
> >> On 11/09/09 15:22, Stefan Schulze Frielinghaus wrote:
> >>> On Fri, 2009-09-11 at 08:30 -0400, Chris PeBenito wrote:
> >>>> On Fri, 2009-09-11 at 10:20 +0200, Stefan Schulze Frielinghaus wrote:
> >>>>>>>>>> On Thu, 10 Sep 2009 21:40:56 +0200
> >>>>>>>>>> Stefan Schulze Frielinghaus<stefan@seekline.net>   wrote:
> >>>>>>>>>>
> >>>>>>>>>>> Attached is a new policy for the dkim-filter application.
> >>>>>>>>>>>
> >>>>>>>>>>> Chris, is the policy OK/ready for merge?
> >>>>
> >>>>> Tested attached policy again on CentOS 5.3 with strict policy.
> >>>>
> >>>> It looks ok.  However I'm starting to get concerned about the milter
> >>>> module getting big.  If you want, say the spamassassin milter, you add
> >>>> the milter module... but then you get rules for a several other milters
> >>>> too.
> >>
> >> True, but how much of a problem is that, given that any milter user is
> >> at least going to have also the sendmail/postfix policy and the mta
> >> policy too?
> >
> > Perhaps not.  But how many milters are there?  I don't want to get to
> > the point where there are 10-20 milters in the same module.
> 
> Having that many milters is quite conceivable:
> 
> https://www.milter.org/milters
> 
> >>> Attached is a milter version which behaves like the apache_template(). I
> >>> only took care of the dkim-milter but in general this would only mean
> >>> some reorganization of all modules ... nothing more. Any cons about
> >>> that?
> >>
> >> Splitting each milter out into its own module is certainly do-able;
> >> doesn't that add overhead (from having more modules) as well though?
> >
> > Only a little disk space and some memory during policy linking.  No
> > overhead for the final policy, which is what I'm concerned about.
> >
> >>> If this would be the right way then we could also talk about the
> >>> milter_template() naming convention:
> >>>
> >>> type $1_milter_t
> >>>
> >>> The apache_template generates slightly different type names:
> >>>
> >>> type httpd_$1_script_t
> >>>
> >>> What about changing $1_milter_t to milter_$1_t?
> >>
> >> That would make sense given that most types in refpolicy are prefixed
> >> with the module name. There would need to be typealiases added though
> >> for the old names for the benefit of existing users, wouldn't there?
> >
> > Yes.  But I'd prefer to keep the current naming convention.  I consider
> > the apache convention nonstandard.
> 
> Let's split each milter off into its own module then, leaving the type 
> names unchanged.

We'll do this for new milters.  The ones that are currently in the
milter module will stay for now, since its problematic moving types
between modules.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
