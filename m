Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84FBTrT014312
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 11:11:29 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84FBRp9016030
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 15:11:27 GMT
Date: Sat, 4 Sep 2004 16:22:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] file contexts "alternate" keyword
Message-ID: <20040904152239.GK4084@lkcl.net>
References: <20040903165723.GA31857@lkcl.net> <20040903205348.GA4084@lkcl.net> <1094258021.29689.32.camel@wintermute.xmldesign.de> <200409041748.38442.russell@coker.com.au> <1094297930.6427.7.camel@wintermute.xmldesign.de> <20040904140609.GF4084@lkcl.net> <1094307199.6427.23.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094307199.6427.23.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 04, 2004 at 04:13:19PM +0200, Erich Schubert wrote:
> Hi,
> 
> > > /var/www(/.*)?      system_u:object_r:httpd_sys_script_exec_t  alternate
> > > /var/www(/.*)?      system_u:object_r:httpd_sys_content_t
> > > 
> > > (maybe adding "default" to the second, to make it more userfriendly)
> >  
> >  the solution to ensuring that a setfiles run (make relabel)
> >  is done correctly is to record, in a separate file/database
> >  (e.g.  file_context_alt_labels) what the present "fourth
> >  parameter" is.
> 
> I don't get what you are trying to say.
> Are you suggesting to log additional labels for *each file* in a
> separate database? Please don't even think of that!
 
 each file, no, each entry in file_contexts for which an "alternate"
 other than the default has been requested, yes.

 a function in libselinux1 would be required which says:

    for the following regexp line "/var/www/(/.*)?", use the
     "alternate" line in file_contexts instead of the "default".


> >  the index would need to be the regexp (e.g. /var/www/(/.*)?) and the
> >  data would need to be the "fourth parameter" (e.g. "alternate").
> 
> setfiles will read file_contexts anyway, why adding another "database"?
> this just increases the possible causes for failures.
> 
> The context setting principle is simple:
> 
> like previously, step through the regexps. when the regexp matches,
> update the "to-be" context for this file *unless* the old "to-be"
> context is the current context of the file and the last matching regexp
> was the same as this.

 unfortunately for me, this sentence contains at least two ambiguities.

 i assume, by "like previously", that you mean "as is done at present,
 with the present libselinux1 (1.16 whatever) yes?"

 what is "the last matching regexp" and what is "this" in the above
 sentence?

 where does "the last matching regexp" come from?

> So the necessary code changes are just
> - remembering which regexp matched last
> - if-statement "previous regexp == current regexp"
> - if-statement "old dest context == current file context"
> 
> We don't even need these additional labels. They would just make it
> easier to understand / read.
> We can just say that when identical rules exist, any of them may be
> fulfilled, otherwise the file is relabeled to the last context
> specified.

 where and how do you record "the last context specified"?

 that is the bit i don't get.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
