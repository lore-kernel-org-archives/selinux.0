Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8NF9VsJ012938
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 11:09:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8NF9T2T001629
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 15:09:30 GMT
Date: Tue, 23 Sep 2003 16:09:27 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Some minor thoughts on syntax/semantics
Message-ID: <20030923150926.GG21997@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There seems to be a bit of mental gymnastics involved
in reading allow statements. They are written like this:

allow  this_t   that_t:class  {this that and the other};

but semantically we want to think of it as:

"Allow a domain this_t to do {this that and the other} 
from something like that_t:class"

So I wonder if there was a reason you didn't go for
a similar syntax, eg

allow  this_t {this that and the other}  that_t:class;

Just curious.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
