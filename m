Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9G1kIWt029928
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:46:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9G1kA0p009295
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 01:46:10 GMT
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by jazzswing.ncsc.mil  with ESMTP id h9G1k9r7009292
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 01:46:10 GMT
Date: Wed, 15 Oct 2003 18:45:19 -0700
From: Michael Reilly <michaelr@cisco.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Subject: Re: setfiles and /home labeling
Message-Id: <20031015184519.6740a16b.michaelr@cisco.com>
In-Reply-To: <200310161130.21749.russell@coker.com.au>
References: <20031015160109.7fbdbb12.michaelr@cisco.com>
	<200310161130.21749.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you - I'll try that now.

BTW - this documented anywhere?  It appears to be a form of REGEXP but is
slightly different than I am used to.

michael
On Thu, 16 Oct 2003 11:30:21 +1000
Russell Coker <russell@coker.com.au> wrote:

> On Thu, 16 Oct 2003 09:01, Michael Reilly wrote:
> > /home/michaelr/(/.*)?           system_u:object_r:staff_home_t
> > /home/michaelr                  system_u:object_r:staff_home_dir_t
> 
> Change the above two lines to the below:
> 
> /home/michaelr/.+                 michaelr:object_r:staff_home_t
> /home/michaelr           -d       michaelr:object_r:staff_home_dir_t
> 
> It should work then.  Let me know what happens.
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
