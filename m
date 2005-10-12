Message-Id: <200510121511.j9CFBqMr011443@mms-r00.iijmio.jp>
Date: Wed, 12 Oct 2005 11:11:49 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: Re: swapon unsuppoted?
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
References: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley wrote:
> > When I used swapon command, 
> > access vector "swapon" was not checked, 
> > only capability sys_admin was checked.
> > It seems that FILE__SWAPON does not exist in hooks.c
> > 
> > Is swapon unsupported in current version?
> Yes, the corresponding LSM hook was never merged upstream.  There was
> never a strong justification for it in the first place. 
I see, I found when swapon is used, getattr ,read and write are also checked.
swapon access vector may not be useful.

So, why it still exists in access_vectors file?
I think it is confusing, 
it should be removed or comment should be described.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
