Message-ID: <20041103160311.51639.qmail@web50604.mail.yahoo.com>
Date: Wed, 3 Nov 2004 08:03:11 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: What policy is the system running?
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0411021651060.10659-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>We could do an md5 checksum of the binary policy as it is written to 
>/selinuxfs/load then export this via /selinux/policy_md5sum.

I'm not sure I like this approach...they may have just recompiled a policy
(overwriting the one in memory) and have either no policy that matches or perhaps
multiple policies that match.

-Steve Grubb


		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
