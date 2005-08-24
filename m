Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OKQWOb010901
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 16:26:32 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OKFrDj009958
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 20:16:06 GMT
Message-ID: <36282A1733C57546BE392885C06185920572F6@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>,
   "'Stephen Smalley '"
	 <sds@epoch.ncsc.mil>
Cc: "'Daniel J Walsh '" <dwalsh@redhat.com>,
   "'SE Linux '"
	 <selinux@tycho.nsa.gov>
Subject: RE: libselinux category patch
Date: Wed, 24 Aug 2005 16:18:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


We definitely need to allow whitespace in the translated context.

-Chad 

Stephen Smalley wrote:
> On Tue, 2005-08-23 at 11:02 -0400, Daniel J Walsh wrote:
>>>Do we truly need to allow whitespace in the (translated) MLS field?
>>>That change to context_new originated in the TCS patch, but I'd prefer
>>>to avoid it if possible.
>>> 
>>
>>I have no problem with not allowing spaces in translated name.  We could 
>>come up with a third field, in the translation, Printable Name or some
>>such, but that could come later...
> 
> I'm just concerned about parsing code having to distinguish normal
> whitespace field separators (e.g. in ps or ls output) from internal
> separators within a label.  If we allow whitespace within the context,
> we essentially have to start printing them all as quoted strings inall
> the utilities, as well as passing them that way as arguments.

Our MITRE based translator really like the whitespace...  I agree thatthe
whitespace is a pain, but we have been using this for quite a while andhave
not run into problems with any utilities that I am aware of.  My biggest
gripe is having to quote arguments to commands when a context has
whitespace...
How about we allow for it, and let those who choose to use whitespace
(unfortunately our translation scheme) deal with the repercussions :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
