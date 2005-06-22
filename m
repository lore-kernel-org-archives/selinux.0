Date: Wed, 22 Jun 2005 23:38:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: alexander-barclay@utulsa.edu, Brandon Pollet <brandon@utulsa.edu>,
   SELinux@tycho.nsa.gov, John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
Message-ID: <20050622223842.GH14480@lkcl.net>
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu> <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu> <20050621212059.GA9434@lkcl.net> <42B8A699.206@tresys.com> <20050622004114.GH9859@lkcl.net> <42B8DF16.3060108@tresys.com> <20050622053327.GB14480@lkcl.net> <42B94A03.8020508@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42B94A03.8020508@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 22, 2005 at 07:22:43AM -0400, Joshua Brindle wrote:
> Luke Kenneth Casson Leighton wrote:
 
> The bottom line is that the tools would be great 

 i agree with that.

> but the XML has nothing 
> to do with that.

 then we will have to agree to disagree on that point, because
 there are far more XML parsing libraries in virtually every known
 useable language under the sun.
 
 here are the options, as i see them:

 * a tool, written in i-don't-really-care-what-language-but-i-like-python,
   which takes `find /etc/selinux/src/*` and turns it into formally-defined,
   well-structured XML format which has a formal DTD representing users,
   *.te, *.fc, macros, etc.
   
   then utilities and programs written which understand the DTD
   and therefore can "manipulate" selinux policy for any purpose
   can be written in any programming language which has an XML library.


 * a library, written in [probably] c and then wrapped with swig,
   which understands and provides access to the contents of
   /etc/selinux/*

   then, utilities and programs which "manipulate" selinux policy can
   conveniently be written in c and with some awkwardness [due to swig]
   written in any other programming language.

 some questions for you:

	 which of these two options is less of a maintenance headache?
 
 and
 
	 which of these two options provides the most flexibility?
 
 and

 	which of these two options would be most acceptable to
	non-expert selinux admins and developers for writing their
	own home-grown tools?

 most people look at the /etc/selinux/src and go "yukk".


 oh - btw - the idea about "function definitions" in the m4 language?
 GREAT idea - i believe it would make the "formal definition" in XML
 format that much easier.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
