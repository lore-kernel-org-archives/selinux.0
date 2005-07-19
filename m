Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JNPfgA012017
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 19:25:42 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JNLL3G015915
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 23:21:21 GMT
Subject: Re: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <20050719215424.GA8851@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com>
	 <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com>
	 <20050719215424.GA8851@lkcl.net>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 19:22:57 -0400
Message-Id: <1121815377.15541.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-19 at 22:54 +0100, Luke Kenneth Casson Leighton wrote:
> could someone do me a large favour, and point me at a URL which
> contains a description of JUST the requirements - formal or informal
> specification, i don't mind which - and a brief contextual outline
> or references to archives.

Luke, there is no specification at the moment. We're simply 
following up on Karl's idea to map Unix users to SElinux users
in a different fashion than 1:1 with user_u fallback. Instead
we will be mapping many Unix users to few SElinux users,
which may also be called security "classes". The default
class would also be configurable (not hardcoded on user_u).

This is a good idea, because it improves scalability - the 
users no longer need to be stored in the kernel and eat up
memory. Instead, we will only store users (classes) that have
different security properties. Additionally, we will no longer 
need to reload the security policy to change the roles for a 
user - instead we'd just remap her to a different security class.

--

The discussion here is about how exactly to accomplish that - 
where would the code be placed that interprets this map
(which will store user, selinux user, and mls categories
for the user, which we decided are important to keep per user)

Originally I wrote some code for libselinux/libsemanage, 
but Karl didn't like that (and still doesn't) so an alternative was 
explored to provide a standard glibc interface, similar to 
getpwnam() that makes use of nsswitch.conf. However, it now 
seems that this is a mistake. It is also being proposed to 
place this code in pam, but I don't see how this will work at 
all - if you place code in pam, than all the code that doesn't
use pam (and there's already a few planned callers - admin
programs) cannot make use of it, and has to write its 
own interface.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
