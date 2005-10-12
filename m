Message-Id: <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
Date: Wed, 12 Oct 2005 11:17:43 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, himainu-ynakam@miomio.jp
Subject: Re: swapon unsuppoted?
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
References: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley wrote:
> On Mon, 2005-10-10 at 15:50 -0400, Yuichi Nakamura wrote:
> > Is swapon unsupported in current version?
> Yes, the corresponding LSM hook was never merged upstream.  There was
> never a strong justification for it in the first place. 

I am reviewing meaning of access vectors to develop SELinux Policy Editor.
I also found  
capability:net_broadcast, 
filesystem:transition and object class ipc are unused.
Is it correct?
And are they going to be used in the future?

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
