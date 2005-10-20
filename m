Message-Id: <200510201443.j9KEhRHp013290@mms-r00.iijmio.jp>
Date: Thu, 20 Oct 2005 10:43:17 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Other unused permissions(Re: swapon unsuppoted?
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
References: <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura  wrote:
> I am reviewing meaning of access vectors to develop SELinux Policy Editor.
> I also found  
> capability:net_broadcast, 
> filesystem:transition and object class ipc are unused.

I also found following seem to be unused( in linux 2.6.12-1.1398_FC4).

* netif : enforce_dest 
* socket common :ioctl, append, lock, relabelfrom, relabelto, recvfrom,setattr
* unix_stream_socket: newconn, acceptfrom
* tcp_socket: connectto, newconn, acceptfrom

Some permissions seem to be defined for compatibility, 
will these be active again in the future?

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
