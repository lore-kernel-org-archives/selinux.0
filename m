Date: Sun, 18 May 2003 21:57:30 -0400
From: James Griffin <agriffin@cpcug.org>
Subject: Re: Compile Error of libsecure on Redhat9.0
In-reply-to: <1053307364.19057.24.camel@chris.pebenito.net>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>, SELinux@tycho.nsa.gov
Message-id: <3EC83A0A.3070102@cpcug.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <200305182358.AA00703@ilios104.ori.hitachi-sk.co.jp>
 <1053307364.19057.24.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> We encountered this on Gentoo.  It seems to be a glibc 2.3.2 problem. 
> Once we downgraded to 2.3.1 it compiled fine.  Is 2.3.2 the version that
> RedHat 9 is using?

Yes.

[artch@minerva artch]$ cat /etc/redhat-release ; rpm -q glibc
Red Hat Linux release 9 (Shrike)
glibc-2.3.2-27.9


> 
> Chris
> 
> On Sun, 2003-05-18 at 18:58, Yuichi Nakamura wrote:
> 
>>Hi.
>>I'm researching SELinux in Japan.
>>
[snip]


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
