Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JGALRb011627
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:10:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JGAIAR019700
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 16:10:18 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i4JGAIHn019690 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 16:10:18 GMT
Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: adduser script
Date: Wed, 19 May 2004 12:10:06 -0400
Message-ID: <00f101c43dbb$c1111f40$4c0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20040519145327.GK4221@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:
> On Wed, May 19, 2004 at 07:56:11AM -0400, Frank Mayer wrote:
>> See seuser and the seuser* scripts in the setools package
>> 
> oh!  a bit more investigation: am i right in thinking that
> seuser _is_ the program i was expecting (it is responsible
> for modifying and managing /etc/selinux/*) and that the
> seuser* scripts _are_ only calling seuser as required,
> therefore seuser* _are_ already equivalent to adduser-ng?

Yes based on your description, although I'm not familiar with adduser-ng.  The
seuser program only manages the selinux aspect of users, and the scripts
integrates seuser and the system user* utilities.

Franks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
