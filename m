Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CMUYIi019971
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 17:30:35 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CMSc8I000922
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 22:28:38 GMT
Date: Wed, 12 Jan 2005 22:41:05 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050112224105.GA11846@lkcl.net>
References: <20050110232312.GI6967@lkcl.net> <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil> <20050111214818.GE26175@lkcl.net> <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil> <20050112144411.GZ26175@lkcl.net> <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil> <20050112181814.GD26175@lkcl.net> <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil> <20050112182954.GF26175@lkcl.net> <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 12, 2005 at 04:27:16PM -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 13:29, Luke Kenneth Casson Leighton wrote:
> >  i don't believe it does - or i am misunderstanding.
> > 
> >  having two policy files apache.fc and mymodifiedthing.fc which _both_
> >  have a file context for the same file / directory, such that the
> >  data that ends up in the security.selinux xattr is "apache_filetype_t,
> >  "mymodifiedthing_filetype_t" doesn't mean, in my book "policy is in
> >  filesystem state".
> > 
> >  ... does it?
> > 
> >  *lost*.
> 
> The file_contexts configuration is not part of the kernel policy.  It is
> only used by userspace to set the contexts for files upon installation,
> to recheck the state of the filesystem against the initial labeling
> state, or to restore portions of the filesystem to the initial labeling
> state.
> 
> If you change the SELinux module to support a list of file contexts
> within the security.selinux attribute, and change its policy engine to
> allow access if any access is allowed to any one of those contexts, then
> the only way to truly identify what information flow is possible in the
> system is by checking the current security.selinux attributes of all
> files in the system for such combinations and collapsing them to a
> single security equivalence class for analysis purposes.  

 ah, yuk.

 ... so, ultimately, it would be better to have some m4-macro-based
 tools that do that, munging to an intermediate step (which is same
 as what we have now) and then munging _that_ to a binary policy
 file (exactly as is now).

 l.
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
