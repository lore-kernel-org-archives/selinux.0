Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CIvPIi018069
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:57:25 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CItQ8I011958
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:55:27 GMT
Date: Wed, 12 Jan 2005 19:07:58 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050112190758.GH26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <20050110232312.GI6967@lkcl.net> <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil> <20050111214818.GE26175@lkcl.net> <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil> <20050112144411.GZ26175@lkcl.net> <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil> <20050112181814.GD26175@lkcl.net> <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 01:03:02PM -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 13:18, Luke Kenneth Casson Leighton wrote:
> >  sorry.
> > 
> >  something simple:
> > 
> >  i am thinking along the lines of more than one file context being
> >  associated with a file - that sort of thing.
> > 
> >  and permission being checked and allowed on either of the contexts.
> 
> I already explained why you don't want that - it puts the policy into
> the filesystem state.

 there is of course the other scheme which achieves the same end-result,
 but using customised m4 macro-based programs to do it: this scheme
 has been raised before.

 namely, to have your apache.fc file and your customthing.fc file,
 and to "spew forth" a combined apache_customthing_filetype_t with
 some macro preprocessing.

 then your apache.fc is unmodified, it's clean, it can be verified,
 upgraded etc...

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
