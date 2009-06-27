Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5RIst1j012379
	for <selinux@tycho.nsa.gov>; Sat, 27 Jun 2009 14:54:55 -0400
Received: from e33.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5RIsdBo022573
	for <selinux@tycho.nsa.gov>; Sat, 27 Jun 2009 18:54:39 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5RIqk2w014879
	for <selinux@tycho.nsa.gov>; Sat, 27 Jun 2009 12:52:46 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5RIsr75261720
	for <selinux@tycho.nsa.gov>; Sat, 27 Jun 2009 12:54:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5RIsrSt003514
	for <selinux@tycho.nsa.gov>; Sat, 27 Jun 2009 12:54:53 -0600
Date: Sat, 27 Jun 2009 13:54:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: SELinux and no capabilities
Message-ID: <20090627185454.GA15965@us.ibm.com>
References: <dd18b0c30906191402o12100191x10dac3abcfbbcb56@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd18b0c30906191402o12100191x10dac3abcfbbcb56@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Justin Mattock (justinmattock@gmail.com):
> How dangerous is this:
> (using captest:)
> 
> Current capabilities: none
> Securebits flags NOROOT: 0, NOROOT_LOCKED: 0
> Attempting direct access to shadow...SUCCESS
> Attempting to access shadow by child process...SUCCESS
> Child capabilities: none
> Securebits flags NOROOT: 0, NOROOT_LOCKED: 0
> 
> I have security capability allowed
> libcap and libcap-ng installed as well.
> (The only thing I can think of, is the system is so small(1 gig)
> that there isn't much on, to turn on any capabilities)
> 
> I've refpolicy running with mcs, just a bit concerned when
> I see  Attempting direct access to shadow...SUCCESS
> (nice)

But you're running this as root, right?  And /etc/shadow
is owned by root.  The captest check is only for R_OK.
So this test would only fail if shadow were owned by
shadow or were chmoded 005.  Go ahead and try with one
of those settings...

(I think this is a forward-looking test.)

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
