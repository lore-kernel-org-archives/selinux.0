Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBAFbFRb028275
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 10:37:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBAFbERV011582
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 15:37:14 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id hBAFbAta011579 for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 15:37:13 GMT
Subject: Re: Information flow models
From: Karl MacMillan <kmacmillan@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <ogt8ylky9mn.fsf@divan.mitre.org>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
	 <ogtu148yfom.fsf@divan.mitre.org>
	 <1071069077.6729.108.camel@colossus.columbia.tresys.com>
	 <ogt8ylky9mn.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1071070628.6729.118.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 10 Dec 2003 10:37:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-12-10 at 10:29, John D. Ramsdell wrote:
> Karl MacMillan <kmacmillan@tresys.com> writes:
> 
> > All of this is explained in our documentation and can be explored by
> > using the tool.
> 
> Your previous note started by saying you've changed your
> representation of flow information.  Didn't you say the change is not
> reflected in the current version of the software?
> 

All of the documentation and implementation of the permission maps
(which is what you are asking about) is the same. What nodes represent
doesn't change how we interpret object class permissions in terms of
read and write. Additionally, all of the high level descriptions about
information flow in our documentation is still accurate - all of our
discussion is just implementation details.

Karl

> John
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
