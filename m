Subject: Re: What policy is the system running?
From: Karl MacMillan <kmacmillan@tresys.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20041103160311.51639.qmail@web50604.mail.yahoo.com>
References: <20041103160311.51639.qmail@web50604.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 13:37:39 -0500
Message-Id: <1099507059.20150.47.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 08:03 -0800, Steve G wrote:
> >We could do an md5 checksum of the binary policy as it is written to 
> >/selinuxfs/load then export this via /selinux/policy_md5sum.
> 
> I'm not sure I like this approach...they may have just recompiled a policy
> (overwriting the one in memory) and have either no policy that matches or perhaps
> multiple policies that match.
> 

This would be case for setting boolean states on policy load, correct?

Karl

> -Steve Grubb
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Check out the new Yahoo! Front Page. 
> www.yahoo.com 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
