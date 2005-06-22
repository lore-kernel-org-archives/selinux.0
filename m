Message-ID: <42B8DF16.3060108@tresys.com>
Date: Tue, 21 Jun 2005 23:46:30 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: alexander-barclay@utulsa.edu, Brandon Pollet <brandon@utulsa.edu>,
   SELinux@tycho.nsa.gov, John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu> <20050621212059.GA9434@lkcl.net> <42B8A699.206@tresys.com> <20050622004114.GH9859@lkcl.net>
In-Reply-To: <20050622004114.GH9859@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>[joshua thank you for the corrections]
>
>Wish List item 3)
>
>that the tools that do the converting to/from XML be
>written in python!!!
>  
>
The doctool to generate module.conf, tunables.conf and the html docs for 
the reference policy is in python :)

> <snip>
>
> 
> i get the impression that you like XML as little as i did when the
> buzz-word first came out.
>
>  
>
No, I think XML is very useful for the right tasks

> i agree with you that XML is not particularly useful for
> being read by humans (although it can be which is useful
> for debugging, if the tool/library that generated the XML
> file includes appropriate white space, which they frequently
> don't *sigh*...)
>
> it _is_, however, useful for being read by computer programs.
>
> XML is the sort of thing that allows people with very little
> understanding of e.g. selinux to write, write, using simple
> libraries, their Own Glorious parsing analysis and communication
> tools.
>
>  
>
I'm not sure what this means. How does XML help people that don't 
understand selinux do anything?
Changing the language to XML might add parsers but tools won't magically 
appear. Further, there are plenty of tools that parse the current 
format, there is little reason to move to an XML based policy language 
when totally functional parsers already exist to do anything you need.

> my guess is that once all the hard work is done of specifying
> an XML file format and writing (hopefully in python *hope*,
> *hope*, hint, hint) a parsing/converter tool to convert
> `cd /etc/selinux/src; make distclean; find .` in and out of
> XML file format, that:
>
>  
>
the modules might be in XML but there will be lots of m4 that will still 
have to be processed before any XML parser could use the output..

> - writing a python program that took an XML file and generated an
>   HTML report would take about... *shrug* - two to three hours
>
>   [i did a similar thing for converting a fwbuilder's XML file
>    into an HTML report because fwbuilder is missing a
>    print option.  so it would take _me_ under 90 mins
>    to convert my fw_report.py program to understand an
>    SE-Linux-Policy-DTD-compliant XML file]
>
> - writing a python tcl/tk program that took an XML selinux file
>   as input and output that could be used to write SElinux policy
>   would take... mmm... *finger-in-air* ... ten days?
>
> - you could write a program similar to fwbuilder that understood
>   SE/Linux policy [instead of firewall rules].
>
>   fwbuilder's file format is in XML.
>
>  
>
I'm not sure it's fair to compare a policy language which is often in 
implementations with 300k+ rules with a firewall app that probably 
rarely has 1000. I can't ever imagine a time when selinux policy is 
written directly in expanded format (no macros or templates of some 
sort, whether it's m4 or not) and using XML on the unexpanded format is 
again, not possible

>   adapting fwbuilder as the basis for a GUI-based selinux policy
>   writing tool would take... *finger-in-air* ... four weeks?
>
>   (fwbuilder is written in c++).
>
> 
>
> the same cannot be said for programs having to understand
> the /etc/selinux/src/* policy files directly.
>
>  
>
Parsers exist for this

> the above timescales all would need, individually, to have
> the cost of writing a read-write parser to them in each of
> the python and c++ languages, respectively.
> 
> and it would _need_ to be a library [not a file format].
>
>  
>
we have some: libapol, libsepol and an upcoming API for modifying the 
policy through an infrastructure like the policy modules or the policy 
server

> you wanna write such a library?  fine!!  [i don't!!]
>
>  
>
we did :)

> bottom line: i strongly suggest using the right kind of
> words that will encourage the people at this university to
> do this work!!!
>  
>
I think you misunderstood. Clearly I want the university guys to do work 
that helps SELinux, I just question how this specific work could.


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
