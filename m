Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA29488
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 13:41:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04947
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 18:38:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA04939
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 18:38:28 GMT
Message-Id: <200301211848.NAA02352@moss-shockers.ncsc.mil>
Date: Tue, 21 Jan 2003 13:48:43 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Apache/mysql policy status ?
To: selinux@tycho.nsa.gov, tom@lemuria.org
Cc: wsalamon@tislabs.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'm a bit confused about the current state of the two policies I've
> worked on. Are they merged with
> a) the CVS tree
> b) the Debian default policy?
> 
> I'm asking because I just noticed that the woody default policy doesn't
> seem to use them. Was it only merged with sid?

As I recall, we were still waiting final forms of patches for merging
from you.  Your last message about the mysql policy appears to have
been http://marc.theaimsgroup.com/?l=selinux&m=103598879429279&w=2,
where you posted full files for comments and said that you would
followup with a patch after further testing.  I don't recall seeing
any comments or a followup patch.  Since it was a major rewrite of
Russell's original domain, I was also looking for an ACK from him.

With regard to the Apache policy diff, I think it might have been
dropped accidentally.  Sorry.  Was the final form of that patch
contained in http://marc.theaimsgroup.com/?l=selinux&m=103555821217807&w=2?
Note to Wayne:  Please make sure that the apache diff (but not the
SubVersion diff) is in the queue of policy patches for review. 

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
