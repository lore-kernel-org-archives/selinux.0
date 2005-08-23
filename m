Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NFHEOb028993
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 11:17:15 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430B3A7B.6020208@redhat.com>
References: <430A33E5.1030100@redhat.com>
	 <1124807226.7874.52.camel@moss-spartans.epoch.ncsc.mil>
	 <430B3A7B.6020208@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 11:04:53 -0400
Message-Id: <1124809493.7874.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 11:02 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> 
> >On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
> >  
> >
> >>libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 
> >>    
> >>
> >
> >Do we truly need to allow whitespace in the (translated) MLS field?
> >That change to context_new originated in the TCS patch, but I'd prefer
> >to avoid it if possible.
> >  
> >  
> >
> I have no problem with not allowing spaces in translated name.  We could 
> come up with a third field, in the translation, Printable Name or some 
> such, but that could come later...

I'm just concerned about parsing code having to distinguish normal
whitespace field separators (e.g. in ps or ls output) from internal
separators within a label.  If we allow whitespace within the context,
we essentially have to start printing them all as quoted strings in all
the utilities, as well as passing them that way as arguments.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
