Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84HrhrT014749
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 13:53:43 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84Hrfp9017871
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 17:53:42 GMT
Subject: Re: [idea] file contexts "alternate" keyword
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040904152239.GK4084@lkcl.net>
References: <20040903165723.GA31857@lkcl.net>
	 <20040903205348.GA4084@lkcl.net>
	 <1094258021.29689.32.camel@wintermute.xmldesign.de>
	 <200409041748.38442.russell@coker.com.au>
	 <1094297930.6427.7.camel@wintermute.xmldesign.de>
	 <20040904140609.GF4084@lkcl.net>
	 <1094307199.6427.23.camel@wintermute.xmldesign.de>
	 <20040904152239.GK4084@lkcl.net>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 19:53:39 +0200
Message-Id: <1094320419.6427.38.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>     for the following regexp line "/var/www/(/.*)?", use the
>      "alternate" line in file_contexts instead of the "default".

No it is not.

> > like previously, step through the regexps. when the regexp matches,
> > update the "to-be" context for this file *unless* the old "to-be"
> > context is the current context of the file and the last matching regexp
> > was the same as this.
> 
>  unfortunately for me, this sentence contains at least two ambiguities.
> 
>  i assume, by "like previously", that you mean "as is done at present,
>  with the present libselinux1 (1.16 whatever) yes?"

Like "setfiles" does for now. Quoting russel:
> The current method is that the last "hit" is the one that is applied.

>  what is "the last matching regexp" and what is "this" in the above
>  sentence?

the previous when processing the rules in the sequence they are stored
in the file_contexts file.
"this file" is the file to be relabeled. the other "this" is the
"currently considered regexp"

>  where does "the last matching regexp" come from?

from the sequence the rules are stored and processed.

> > So the necessary code changes are just
> > - remembering which regexp matched last
> > - if-statement "previous regexp == current regexp"
> > - if-statement "old dest context == current file context"
> > 
> > We don't even need these additional labels. They would just make it
> > easier to understand / read.
> > We can just say that when identical rules exist, any of them may be
> > fulfilled, otherwise the file is relabeled to the last context
> > specified.
> 
>  where and how do you record "the last context specified"?

the new matching regexp has a context. this is the one i'm talking
about... the "last matching context specified in file_contexts"

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.       //\
      Ein Freund ist ein Geschenk, das man sich selbst macht.       V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
