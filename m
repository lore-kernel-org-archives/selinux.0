Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2RDAvjx002525
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 09:10:58 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2RDArCe003821
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 13:10:54 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 489D218585
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 23:49:35 +1100 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8s1VEGMCevX4 for <selinux@tycho.nsa.gov>;
	Thu, 27 Mar 2008 23:49:35 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id DA2BE1852B
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 23:49:34 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 4C6FC21A15
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 23:49:33 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: file(1)
Date: Thu, 27 Mar 2008 23:49:31 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803272349.32854.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

# SE Linux policy modules *.pp
0       lelong  0xf97cff8f      SE Linux modular policy
>4      lelong  x       version %d,
>8      lelong  x       %d sections,
>>(12.l) lelong 0xf97cff8d
>>>(12.l+27) lelong x           mod version %d,
>>>(12.l+31) lelong 0           Not MLS,
>>>(12.l+31) lelong 1           MLS,
>>>(12.l+23) lelong 2
>>>>(12.l+47) string >\0        module name %s
>>>(12.l+23) lelong 1          base

The above /etc/magic entry allows file(1) to display some information about 
policy modules.  Below is a sample of the result:

# file qmail.pp  base.pp  /tmp/loadkeys.pp
qmail.pp:         SE Linux modular policy version 1, 2 sections, mod version 
7, Not MLS, module name qmail\005
base.pp:          SE Linux modular policy version 1, 4 sections, mod version 
7, Not MLS, base
/tmp/loadkeys.pp: SE Linux modular policy version 1, 2 sections, mod version 
6, MLS, module name loadkeys\005

Please let me know what you think of this, in terms of text formatting, 
information displayed, and use of file(1) features.

The \005 after the module name is due to the fact that file(1) seems to 
support only two types of string, a "C string" (terminated by \0) and 
a "Pascal string" where a single byte is used to indicate the length.  Using 
a 32bit little-endian word to indicate the length doesn't seem to work with 
file(1) - but if anyone can figure out a way then please let me know.

It seems to me that it would be a good idea to write /etc/magic entries at the 
same time as devising file formats.  Being able to quickly and easily 
determine the contents of a file is a really handy feature.  Working with the 
limitations of file(1) to support this to the greatest degree possible would 
be a good thing.  If the module name was limited to 255 characters I doubt 
that it would ever inconvenience anyone (in the past I've used compilers that 
support symbol lengths of ~30 characters), but having a better display in 
file(1) output would often help people.  Another option would be to have a 
word indicating the string length while also having a 0 terminator (wasting 
the occasional byte isn't really a problem).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
