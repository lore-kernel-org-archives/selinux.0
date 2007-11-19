Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJ4lYD6017584
	for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 23:47:34 -0500
Received: from mail4.hitachi.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAJ4lWXQ006540
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 04:47:33 GMT
Received: from mlsv12.hitachi.co.jp (unknown [133.144.234.166])
	by mail4.hitachi.co.jp (Postfix) with ESMTP id EB8E633CCA
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 13:47:26 +0900 (JST)
Date: Mon, 19 Nov 2007 13:47:01 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: selinux@tycho.nsa.gov
Subject: ANN: SELinux Policy Editor 2.2.0
Cc: ynakam@hitachisoft.jp, fedora-selinux-list@redhat.com,
        seedit-devel@opendawn.com
Message-Id: <20071119133250.BBC3.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

We've released SELinux Policy Editor(SEEdit) 2.2.0.
SEEdit is a tool to write policy easily.

Changes from 2.1.0.
1) Policy development for embedded device support.
  You can develop policy for embedded devices by SEEdit.
2) Improved SPDL compiler.
   seedit-conveter(Program that convert SPDL to selinux policy)
    does not use local file information, labeling rule has been changed.
    By that, you can cross-develop policy for embedded devices.
    For non-embedded people,  
    speed to convert SPDL to SELinux policy has become faster.
3) Support  Fedora 8.

For detail, please look at
http://seedit.sourceforge.net/

Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
