Subject: Re: swapon unsuppoted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510101950.j9AJoM83010842@mms-r00.iijmio.jp>
References: <200510101950.j9AJoM83010842@mms-r00.iijmio.jp>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 07:56:34 -0400
Message-Id: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-10 at 15:50 -0400, Yuichi Nakamura wrote:
> Hi.
> 
> When I used swapon command, 
> access vector "swapon" was not checked, 
> only capability sys_admin was checked.
> It seems that FILE__SWAPON does not exist in hooks.c
> 
> Is swapon unsupported in current version?

Yes, the corresponding LSM hook was never merged upstream.  There was
never a strong justification for it in the first place. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
