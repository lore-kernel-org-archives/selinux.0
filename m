Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86DGrrT021272
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 09:16:53 -0400 (EDT)
Received: from mbox-o00.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86DGmal016538
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 13:16:51 GMT
Message-Id: <200409061316.i86DGhWU026428@mms-r00.iijmio.jp>
Date: Mon, 06 Sep 2004 09:16:34 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: stefano.zanarini@yacme.com
Cc: selinux@tycho.nsa.gov, himainu-ynakam@miomio.jp, sds@epoch.ncsc.mil
Subject: Re: SuSE 9.1 SELinux
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1094456102.2213.3.camel@pignoletto.cantina.yacme>
References: <1094456102.2213.3.camel@pignoletto.cantina.yacme>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

Stefano Zanarini <stefano.zanarini@yacme.com> wrote:
> I'm interested in doing the same thing ,even in suse 9.0 with a custom
> kernel and in 9.1 with defoult one ,but this could be a real problem for
> me ... why doesn't it work with reiserfs ? is there a patch or a
> workaround to make it works ? have you tryed ? 
> thank's in advance.

Stephen Smalley said that there is a deadlock in reiserfs with SELinux.
http://marc.theaimsgroup.com/?l=selinux&m=109422792406335&w=2

But I would like to know the detail of deadlock.
Could someone tell me where is the deadlock or the condition that the deadlock happens??
A Novell Japan person will report to Bugzilla.

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
http://www.selinux.gr.jp/
The George Washington University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
