Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13833
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 16:08:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA21810
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 20:06:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA21806 for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 20:06:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Clint Byrum <cbyrum@spamaps.org>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: TE/DTE Patent issues?
Date: Fri, 5 Jul 2002 00:54:55 -0400
Cc: SE Linux <selinux@tycho.nsa.gov>, LSM <linux-security-module@wirex.com>
References: <72222DC86846D411ABD300A0C9EB08A1015243B6@csoc-mail-box.csoconline.com> <1025562898.2137.30.camel@lancelot>
In-Reply-To: <1025562898.2137.30.camel@lancelot>
MIME-Version: 1.0
Message-Id: <20020706200822.85C267946@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Jul 2002 18:34, Clint Byrum wrote:
> On Mon, 2002-07-01 at 13:26, Westerman, Mark wrote:
> > I am going with the NSA web pages about the patent
> > issue. They released all the code for SELinux
> > under the GPL some of the modified maybe release
> > under different license.
>
> GPL or no, the patent will, unfortunately, overrule anything the GPL
> says.. at least that has been what has happened to this point.

To clarify my message of Fri, 21 Jun 2002 13:11:26 +0200 with the strange 
subject of "Re: uclibc and selinux":

The NSA states on their web page that SE Linux can be used under the terms of 
the GPL.  So I recommend using it under the full terms of the GPL (which 
requires no licenses or communication with SCC).  The only term of the GPL 
that requires you to do anything is that if you ship a binary based on a 
modified version of the source code then you must provide that source to 
everyone who gets the binary.

If SCC believe that the NSA has acted improperly when they declared that they 
are releasing the code under the GPL then it is up to them to take legal 
action against the NSA (who I believe would be represented by the Justice 
Department in such a matter).

If SCC win a legal battle against the Justice Department then they could 
potentially start enforcing patent terms on SE Linux users.  I don't fancy 
their chances...

Please note that the above is a clarification of the message I wrote while at 
home in Amsterdam.

> > How ever Type Enforcement is a Trademark. I would not
> > use the phrase "Type Enforcement" with out a TM
> > reference
>
> A small mark against using the system.

Type Enforcement(TM) is not what you want to talk about when promoting SE 
Linux or products which use it - your customers will never understand that.  
Just talk about "Mandatory Access Control" which prevents users from 
accidentally granting access to their data in excess of what the security 
policy allows (MAC has no trademark AFAIK).  Also talk about fine-grained 
security which allows you to specify access to resources on a per-process 
basis and which removes the issue of "you must be root to do anything 
interesting but as root you can destroy everything".

> I think I have decided that, while SELinux and Type Enforcement(tm...
> hehe) are the right way to do this, I'd rather not deal with the
> licensing issues. What is the best alternative? My inclination is to use
> GRSecurity to accomplish some of the fine grained access control
> necessary for a highly secure system, but I'm guessing you folks have
> other suggestions.

GR Security doesn't come close to doing what SE Linux does, but it does some 
things that SE doesn't do.  GR beats OpenWall, I'm not sure how it compares 
to LIDS, Immunix, and other products.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
