Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84EDNrT014178
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 10:13:23 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84ECWAJ019332
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 14:12:33 GMT
Subject: Re: [idea] file contexts "alternate" keyword
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040904140609.GF4084@lkcl.net>
References: <20040903165723.GA31857@lkcl.net>
	 <20040903205348.GA4084@lkcl.net>
	 <1094258021.29689.32.camel@wintermute.xmldesign.de>
	 <200409041748.38442.russell@coker.com.au>
	 <1094297930.6427.7.camel@wintermute.xmldesign.de>
	 <20040904140609.GF4084@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 04 Sep 2004 16:13:19 +0200
Message-Id: <1094307199.6427.23.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> > /var/www(/.*)?      system_u:object_r:httpd_sys_script_exec_t  alternate
> > /var/www(/.*)?      system_u:object_r:httpd_sys_content_t
> > 
> > (maybe adding "default" to the second, to make it more userfriendly)
>  
>  the solution to ensuring that a setfiles run (make relabel)
>  is done correctly is to record, in a separate file/database
>  (e.g.  file_context_alt_labels) what the present "fourth
>  parameter" is.

I don't get what you are trying to say.
Are you suggesting to log additional labels for *each file* in a
separate database? Please don't even think of that!

>  the index would need to be the regexp (e.g. /var/www/(/.*)?) and the
>  data would need to be the "fourth parameter" (e.g. "alternate").

setfiles will read file_contexts anyway, why adding another "database"?
this just increases the possible causes for failures.

The context setting principle is simple:

like previously, step through the regexps. when the regexp matches,
update the "to-be" context for this file *unless* the old "to-be"
context is the current context of the file and the last matching regexp
was the same as this.
So the necessary code changes are just
- remembering which regexp matched last
- if-statement "previous regexp == current regexp"
- if-statement "old dest context == current file context"

We don't even need these additional labels. They would just make it
easier to understand / read.
We can just say that when identical rules exist, any of them may be
fulfilled, otherwise the file is relabeled to the last context
specified.

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
      Go away or i'll replace you with a very small shell script.     //\
 Man kann sich auch in Gesellschaft anderer einsam fühlen. Weizsäcker V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
