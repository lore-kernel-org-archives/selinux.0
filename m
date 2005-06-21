Date: Tue, 21 Jun 2005 22:20:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: alexander-barclay@utulsa.edu
Cc: Brandon Pollet <brandon@utulsa.edu>, SELinux@tycho.nsa.gov,
   John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
Message-ID: <20050621212059.GA9434@lkcl.net>
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1119383982.42b871aef1898@cc.utulsa.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 21, 2005 at 02:59:42PM -0500, alexander-barclay@utulsa.edu wrote:
> >  this is not useful.
> > 
> >  tools to translate the *.fc, *.te, users file, etc.?
> > 
> >  that's useful.
> > 
> >  just my independent, uninformed, enthusiastic, inadviseable,
> >  egoistical and impartial opinion.
> > 
> >  l.
> 
> 
> 
> Hey Luke, thanks for your honest opinion, it is appreciated. This project was conceived over a year ago, and we as a research group have learned a lot in this timeframe.
> 
> The reasoning at the time was to work on the policy.conf since it is a        worst case scenario of the policy configuration, 

 it is not a worst-case scenario: the policy.conf file is completely
 _useless_ on its own as it only makes sense in combination with
 file_contexts and the tunables (i might have missed something else
 out... hmmm)

 policy.conf is an "intermediary": do not be deceived by it being in a
 readable flat file format!

 it's a bit like .S assembly files in that respect.  .S assembly files
 are in a readable flat file format - but nobody in their right minds
 writes code on a day-to-day basis in assembler these days except for
 extremely specialised purposes.


> and to be honest we were not sure that the fc/te/* files would stay the same format. In addition we were planning a suite of tools to work on the XML policy that would help with common configuration tasks etc. 

 okay.

 how should i put this.

 if you can provide an entire policy-development toolchain
 that can "read in" policy.conf and file_context files as an
 intial starting point, that is equivalent to or better than the
 present system [the present system compiles from the contents
 of /etc/selinux/src/* which includes *.te, *.fc, net_contexts,
 users, serviceusers, mls and rbac, _and_ incorporates the
 use of the program genhomedircon], then _great_.

 [i realise that's a long sentence].
 
 i.e. you have two (actually three but one of them's insane) jump-in points:

 - 1) policy.conf + file_contexts + tunables
 - 2) policy.NN + file_contexts + tunables
 - 3) /etc/selinux/src/* (*.te, *.fc, users, mls, rpac, net_contexts etc) +
      tunables

 if you go for 3) then anything you write is an _enhancement_ of
 the existing toolchain and the formal analysis tools developed
 to-date, including those written by that japanese company who
 did a webmin module for selinux policy (no they don't provide
 source code, damnit), and tresys's tools, and everyone's
 knowledge and understanding of the macros developed to date
 over the past four or five years.
 
 if you go for 2) then you are bypassing that entire selinux toolchain
 and collective knowledge [this is the insane option].

 if you go for 1) then you are also bypassing almost all of
 the selinux toolchain except for the binary policy converter,
 and bypassing all of the formal analysis tools.


 3) is the only "sane" - read acceptable - answer.

 not least because it requires that your code "understand"
 the key concepts supported in python code by the program
 genhomedircon, and the concept of users being associated [by
 their unix username] with multiple roles (user_r, staff_r,
 sysadm_r etc.)

 which are actually quite difficult - if not impossible - to
 "extract" from the policy.conf file, in isolation, with no
 access to the "users" file.


 basically, policy.conf and file_contexts do not provide the "full
 picture" that would make the representation of selinux policy in XML
 file format "useful" to developers and sysadmins.


 wish list item 1):

 * the ability to read /etc/selinux/src/* (*.te, *.fc, users,
   mls, rpac, net_contexts etc) + tunables into an XML formatted file

   whilst still recognising that certain areas of the policy are to do
   with certain programs / services.

   i.e. reflecting the directory "domains" and the individual files _in_
   domains in the tree structure of the XML document.  i.e. giving
   apache.te its own "node" hierarchy as distinct and completely
   separate from "src/domains//misc/kernel.te".

 wish list item 2)

 * the ability to output /etc/selinux/src/* (*.te, *.fc, users,
   mls, rpac, net_contexts etc) + tunables etc from an XML
   formatted file.
 
 _that's_ useful.

 l.

 
 
> On a side note, this thesis work was done by Tyronne Nash who passed away days before completion. We honor his spirit and seek to further his work.
 
 *respectful salute*.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
