Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2KBCUx6015495
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 06:12:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2KBCT9P023651
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 11:12:29 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h2KBCSP7023648 for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 11:12:29 GMT
Date: Thu, 20 Mar 2003 11:12:27 +0000
From: Dale Amon <amon@vnl.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux and 2.4.20
Message-ID: <20030320111227.GJ24908@vnl.com>
References: <20030320002246.GC13288@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030320002246.GC13288@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 20, 2003 at 11:22:46AM +1100, Brian May wrote:
> I have found I simply cannot use a 2.4.20 kernel with SE-Linux
> support on my laptop computer with out it "hanging" after a while.
> 
> By this I mean random processes hang, and cannot be killed, even with
> kill -9, and rebooting doesn't work.

Just as another data point: I had to back a 2.4.20
kernel off a firewall because it was oopsing in random
processes after a couple hours. Might not be related...
the kernel had crypto, freeswan and grsec, the oops
was during kernel paging. Are you seeing an OOPS when
you get the lockup?

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
