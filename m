Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0DGCpXf024617
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 11:12:51 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0DGCnpN010605
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 16:12:49 GMT
Subject: Re: sereference: screen policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060112214819.GA8013@sergelap.austin.ibm.com>
References: <20060112214819.GA8013@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 11:12:51 -0500
Message-Id: <1137168771.29815.211.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-12 at 15:48 -0600, Serge E. Hallyn wrote:
> Still getting the hang of the various existing interfaces, but this
> policy at least lets me run screen as sysadm_u and user_u.  This
> likely shouldn't go in as is since I doubt it's minimal due to clumsy
> use of wrong interfaces, but I won't be looking at this again until
> next week at earliest, so meanwhile here's what I've got.

A screen policy was committed two days ago, can you try that one?  I
tested it and it seemed to work ok for me.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
