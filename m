Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ANxbRb018653
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 19:59:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ANxZYW016080
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 23:59:35 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id i4ANxXBf016068 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 23:59:34 GMT
Received: from vsa.hitachi-sk.co.jp ([133.108.250.41])
	by nsa.hitachi-sk.co.jp (unknown) with ESMTP id i4ANxH610415
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 08:59:17 +0900
Received: from gwa.hitachi-sk.co.jp (localhost [127.0.0.1])
	by vsa.hitachi-sk.co.jp (8.9.3+3.2W/3.7W) with ESMTP id IAA20176
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 08:59:16 +0900 (JST)
Received: (from root@localhost)
	by gwa.hitachi-sk.co.jp (8.11.7p1+Sun/3.7W) id i4ANxGU06111
	for selinux@tycho.nsa.gov; Tue, 11 May 2004 08:59:16 +0900 (JST)
Received: from ori.hitachi-sk.co.jp (ori.ori.hitachi-sk.co.jp [133.108.2.2])
	by dns1.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id i4ANxFv05475
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 08:59:15 +0900
Date: Tue, 11 May 2004 08:58:49 +0900
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
To: selinux@tycho.nsa.gov
Subject: Japanese Documentation(Re: presentation results)
Message-Id: <20040511085849.2213308a.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <20040510032712.919833A404E@abyss.simplyaquatics.com>
References: <20040510032712.919833A404E@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 9 May 2004 23:27:12 -0400
"Ed Street" <edstreet@street-tek.com> wrote:
> Documentation, is there any plans to have a printed book dealing with
> selinux administration?

There are book and many articles in Japan.
Unfortunately, they are written in Japanese.
People who can read Japanese, please look at them.

1)
I wrote book about selinux.
"Complete guide to SELinux" printed by Nikkei BP in Mar 2004.
http://www.amazon.co.jp/exec/obidos/ASIN/4822221113/

2)
The latest free article is available on Web site of Nikkei BP, 
free member registration is necessary.
http://itpro.nikkeibp.co.jp/members/ITPro/oss/20040422/1/
It is based on Fedora Core2. 

3) Other free documents about SELinux
http://www.ipa.go.jp/security/fy14/contents/trusted-os/guide.html
http://localhost/selinux-web/document/article/article-top.html

In addition, in Japanese sourceforge site, 
RPMs and SELinux install package for FedoraCore1 are available.
http://sourceforge.jp/projects/selinux/files/
o Kernel rpm(2.4-based SELinux released in Apr 2004, patches for vulnerablities of linux-2.4.25 are applied.)
http://prdownloads.sourceforge.jp/selinux/9155/kernel-2.4.25-selinux1.p2.i386.rpm
http://prdownloads.sourceforge.jp/selinux/9156/kernel-2.4.25-selinux1.p2.src.rpm
o Install package with user land archive rpms(2.4-based SELinux released in Feb 2004)
http://prdownloads.sourceforge.jp/selinux/8631/selinux-20040223_install.tgz


-- 
---------
Yuichi Nakamura
Research & Development Department
Hitachi Software Engineering Co., Ltd.
http://www.selinux.hitachi-sk.co.jp/en

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
