Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3B2iRb020469
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 06:02:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB3B23p7012534
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 11:02:05 GMT
Date: Wed, 3 Dec 2003 11:02:26 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: nagray@austin.rr.com, Russell Coker <russell@coker.com.au>,
   nagray@bruzenak.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: What causes this??
Message-ID: <20031203110225.GA25416@vnl.com>
References: <1070340338.12612.2.camel@hawaii> <200312021549.34383.russell@coker.com.au> <1070376464.13070.127.camel@hawaii> <1070382538.14253.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070382538.14253.65.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 11:28:58AM -0500, Stephen Smalley wrote:
> On Tue, 2003-12-02 at 09:47, Nick wrote:
> > id -c 
> > system_u:system_r:sysadm_t
> 
> This implies that you aren't running the patched login program (or,
> alternatively, using the pam_selinux module).  Note that the user
> identity portion of the context wasn't set, which is why newrole is
> confused.

Stephen, just a modest and time saving suggestion. Why
not add a bit of code to detect this particular condition
and print a message stating the probable solution? 

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
