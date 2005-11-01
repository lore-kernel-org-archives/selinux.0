Message-Id: <4gd3ok$5jmaq7@iron1-mx.tops.gwu.edu>
Date: Tue, 01 Nov 2005 13:19:51 -0500
From: Yuichi Nakamura <ynakam@gwu.edu>
MIME-Version: 1.0
To: Kaimal Biju-E11660 <biju@motorola.com>
Cc: SELinux@tycho.nsa.gov, ynakam@gwu.edu
Subject: Re: Policy specification for Netlink and domain sockets.
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <8F8CC84DFDDDDA44B0942D237E1D644C13511B@ct11exm60.ds.mot.com>
References: <8F8CC84DFDDDDA44B0942D237E1D644C13511B@ct11exm60.ds.mot.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kaimal Biju-E11660 wrote:
> I tried searching for documentation for the policy language for specifying permissions for netlink and domain sockets ? If someone can point me in the right direction or give couple of examples of these, it will be greatly appreciated.

You can find the meaning of netlink-related access vectors by looking at the kernel source security/selinux/nlmsgtab.c. 
"struct nlmsg_perm nlmsg_*_perms" defines relationship between netlink message 
and access vectors.

And I am reviewing all access vectors now.
The draft of document about meaning of access vectors 
is in http://seedit.sourceforge.net/doc/access_vectors.pdf .
It might help you.
However, this document is only a draft, it will contain errors.
No review, no spell-check and no English correction.
Be careful.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
