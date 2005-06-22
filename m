Date: Wed, 22 Jun 2005 01:41:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: alexander-barclay@utulsa.edu, Brandon Pollet <brandon@utulsa.edu>,
   SELinux@tycho.nsa.gov, John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
Message-ID: <20050622004114.GH9859@lkcl.net>
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu> <20050621212059.GA9434@lkcl.net> <42B8A699.206@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42B8A699.206@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[joshua thank you for the corrections]

Wish List item 3)

that the tools that do the converting to/from XML be
written in python!!!


On Tue, Jun 21, 2005 at 07:45:29PM -0400, Joshua Brindle wrote:

> >wish list item 2)
> >
> >* the ability to output /etc/selinux/src/* (*.te, *.fc, users,
> >  mls, rpac, net_contexts etc) + tunables etc from an XML
> >  formatted file.
> >
> >_that's_ useful.
> > 
> >
> How is it useful exactly? what would the XML be used for? 

> converting 
> something to XML for the sake of doing so doesn't really accomplish 
> anything.
 
 i get the impression that you like XML as little as i did when the
 buzz-word first came out.

 i agree with you that XML is not particularly useful for
 being read by humans (although it can be which is useful
 for debugging, if the tool/library that generated the XML
 file includes appropriate white space, which they frequently
 don't *sigh*...)

 it _is_, however, useful for being read by computer programs.

 XML is the sort of thing that allows people with very little
 understanding of e.g. selinux to write, write, using simple
 libraries, their Own Glorious parsing analysis and communication
 tools.

 my guess is that once all the hard work is done of specifying
 an XML file format and writing (hopefully in python *hope*,
 *hope*, hint, hint) a parsing/converter tool to convert
 `cd /etc/selinux/src; make distclean; find .` in and out of
 XML file format, that:

 - writing a python program that took an XML file and generated an
   HTML report would take about... *shrug* - two to three hours

   [i did a similar thing for converting a fwbuilder's XML file
    into an HTML report because fwbuilder is missing a
    print option.  so it would take _me_ under 90 mins
    to convert my fw_report.py program to understand an
    SE-Linux-Policy-DTD-compliant XML file]

 - writing a python tcl/tk program that took an XML selinux file
   as input and output that could be used to write SElinux policy
   would take... mmm... *finger-in-air* ... ten days?

 - you could write a program similar to fwbuilder that understood
   SE/Linux policy [instead of firewall rules].

   fwbuilder's file format is in XML.

   adapting fwbuilder as the basis for a GUI-based selinux policy
   writing tool would take... *finger-in-air* ... four weeks?

   (fwbuilder is written in c++).

 

 the same cannot be said for programs having to understand
 the /etc/selinux/src/* policy files directly.

 the above timescales all would need, individually, to have
 the cost of writing a read-write parser to them in each of
 the python and c++ languages, respectively.
 
 and it would _need_ to be a library [not a file format].

 you wanna write such a library?  fine!!  [i don't!!]

 bottom line: i strongly suggest using the right kind of
 words that will encourage the people at this university to
 do this work!!!

 l.


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
