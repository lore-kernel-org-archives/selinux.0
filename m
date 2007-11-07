Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA7KACTf023995
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 15:10:12 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lA7KACiD013796
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 20:10:12 GMT
Subject: Re: policyd module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jan-Frode Myklebust <janfrode@tanso.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071105105041.GA9569@lc4eb8045376502.ibm.com>
References: <1191243135.4282.42.camel@gorn>
	 <20071003125323.GA15070@lc4eb8045376502.ibm.com>
	 <1191416728.5843.6.camel@gorn>
	 <20071003150600.GA16964@lc4eb8045376502.ibm.com>
	 <1191606242.13098.4.camel@gorn.columbia.tresys.com>
	 <20071005234757.GA4249@lc4eb8045376502.ibm.com>
	 <1191855475.13098.37.camel@gorn>
	 <20071008164636.GA9601@lc4eb8045376502.ibm.com>
	 <20071023160316.GA10042@lc4eb8045376502.ibm.com>
	 <1193231312.9466.104.camel@gorn>
	 <20071105105041.GA9569@lc4eb8045376502.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 15:10:10 -0500
Message-Id: <1194466210.5253.15.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-11-05 at 11:50 +0100, Jan-Frode Myklebust wrote:
> On Wed, Oct 24, 2007 at 01:08:32PM +0000, Christopher J. PeBenito wrote:
> > On Tue, 2007-10-23 at 18:03 +0200, Jan-Frode Myklebust wrote:
> > > Resending this one, as it seems to have dropped of your radar. Still
> > > applies to refpolicy-head.
> > 
> > I'm wrestling with the naming.  Policyd, while its the name of the
> > server, seems far too generic.  It seems like postfix_policyd would be
> > better.
> 
> Here's an updated patch against HEAD with name changed to
> postfix_policyd, and r_dir_perms/r_file_perms changed to
> list_dir_perms/read_file_perms. 

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
