Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAGMIIRb003363
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 17:18:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAGMHoBb028662
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 22:17:50 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAGMHn4o028659
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 22:17:49 GMT
Date: Sun, 16 Nov 2003 22:17:52 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy bug
Message-ID: <20031116221752.GB20445@vnl.com>
References: <20031116133109.GE17041@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031116133109.GE17041@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Nov 16, 2003 at 01:31:09PM +0000, Dale Amon wrote:
> Here's another for you Russ. Fresh from today:

And another one:

ERROR 'unknown type insmod_t' at token ';' on line 17114:
dontaudit insmod_t initctl_t:fifo_file { read write };

/usr/bin/checkpolicy:  error(s) encountered while parsing configuration

and

ERROR 'unknown type hotplug_t' at token ';' on line 17115:
dontaudit hotplug_t initctl_t:fifo_file { read write };
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration

and 

ERROR 'unknown type cupsd_t' at token ';' on line 17239:

allow cupsd_t var_log_t:dir { getattr };
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration

which are also in domains/misc/later.te.

I think you need to put a few conditionals in later.

With all these commented out, the policy builds.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
