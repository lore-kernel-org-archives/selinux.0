Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CI90Ii017571
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:09:00 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CI738I007860
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:07:04 GMT
Date: Wed, 12 Jan 2005 18:19:31 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Added is_context_configurable function
Message-ID: <20050112181931.GE26175@lkcl.net>
References: <41E2FEF4.5070604@redhat.com> <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil> <41E3FAF4.2060109@redhat.com> <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil> <1105481440.24748.22.camel@nexus.verbum.private> <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 09:19:15AM -0500, Stephen Smalley wrote:
> On Tue, 2005-01-11 at 17:10, Colin Walters wrote:
> > I've said this before, but I don't like the idea of having to edit
> > file_contexts whenever I want to change the labels.  I feel that the 
> > on-disk version should be canonical, and the file_contexts only used for
> > system initialization.
> 
> That is also my view.  However, if people are going to run setfiles or
> restorecon at runtime to check or set contexts (which is current
> practice in Fedora), then we do need a way to distinguish legitimate
> customizations 

 ... so there _is_ actually a genuine requirement to minimise the
 number of changes to policy files?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
