Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m56HGL7A014880
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 13:16:21 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m56HGKIQ011604
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 17:16:20 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m56HEibL027958
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 13:14:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: modules.conf problem
Date: Fri, 6 Jun 2008 10:16:11 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9E872@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9E7C9@blums0042.bluelnk.net> <1212754574.15952.2.camel@gorn.columbia.tresys.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Friday, June 06, 2008 5:16 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: modules.conf problem
> 
> On Thu, 2008-06-05 at 14:01 -0700, Clarkson, Mike R (US SSA) wrote:
> > I'm getting the following compile errors when attempting a clean
compile
> > of my policy:
> >
> > policy/modules/apps/import.if:336: Error: duplicate definition of
> > nlscripts_dir_search(). Original definition on 25.
> > policy/modules/apps/import.if:344: Error: duplicate definition of
> > nlscripts_dir_list(). Original definition on 17.
> >
> > The thing is that I have commented out the import module out of the
> > modules.conf file. In fact I commented it out several weeks ago and
have
> > done many clean compiles since without issue until this morning.
> >
> > The only way that I have been able to get past these errors is to
remove
> > the import.{te,if,fc} files from the apps directory. Then the policy
> > compiles and loads fine. I must have changed something in one of the
> > other policy files that caused this to suddenly crop up today but I
have
> > no idea what.
> >
> > If anyone has any ideas on what may be causing this or ideas on how
to
> > track down what the problem is I would greatly appreciate hearing
them.
> >
> > I'm using the RHEL5.1 mls policy.
> 
> You have more than one declaration of those two interfaces.  Even if
the
> module is not enabled in the modules.conf, its interfaces are
included,
> since if its interfaces are used, they have to be expanded.
Unexpanded
> interfaces result in compile failures.

In my humble opinion I don't think that the interfaces for modules which
are not enabled should be included in the policy. The interfaces to a
module provide access to the types declared in that module. If the
module is not enabled, you shouldn't need access to those types. Now
sometimes more general templates are provided in the interface files.
But in my opinion, if someone wants access to those templates, they
should enable the module that provides the template.

> 
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
