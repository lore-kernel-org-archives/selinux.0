Subject: Re: Redhat 9
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1061832549.28086.538.camel@moss-spartans.epoch.ncsc.mil>
References: <1061830219.18210.50.camel@colossus.columbia.tresys.com>
	 <1061832549.28086.538.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1061907797.18210.1108.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Tue, 26 Aug 2003 10:23:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-25 at 13:29, Stephen Smalley wrote:
> This appears to be a typo in ext2/namei.c; try rebuilding your kernel
> after applying the attached patch.  Or use ext3.
> 

This patch fixed the problems - things seem to be fine now with either
ext2 or ext3.

> Build two glibc rpms, one with --target=i386 and one with
> --target=i686.  Then install the i686 "glibc" binary RPM along with the
> other RPMs from the i386 build, excluding the i386 "glibc" binary RPM.
> 

This also fixed the problems that I was having.

Thanks,

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
