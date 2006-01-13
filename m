Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0DGU6Xf024876
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 11:30:06 -0500 (EST)
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0DGU3pN014322
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 16:30:03 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0DGU4h7018127
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 11:30:04 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0DGW9SN038106
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 09:32:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0DGU3VQ032074
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 09:30:03 -0700
Date: Fri, 13 Jan 2006 10:30:01 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: sereference: screen policy
Message-ID: <20060113163001.GA26911@sergelap.austin.ibm.com>
References: <20060112214819.GA8013@sergelap.austin.ibm.com> <1137168771.29815.211.camel@sgc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137168771.29815.211.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> On Thu, 2006-01-12 at 15:48 -0600, Serge E. Hallyn wrote:
> > Still getting the hang of the various existing interfaces, but this
> > policy at least lets me run screen as sysadm_u and user_u.  This
> > likely shouldn't go in as is since I doubt it's minimal due to clumsy
> > use of wrong interfaces, but I won't be looking at this again until
> > next week at earliest, so meanwhile here's what I've got.
> 
> A screen policy was committed two days ago, can you try that one?  I
> tested it and it seemed to work ok for me.

Oops, didn't notice that.  I will try it this afternoon, thanks.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
