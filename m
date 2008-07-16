Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6G7EnZc000886
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 03:14:49 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6G7EgmS008765
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 07:14:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Date: Wed, 16 Jul 2008 17:14:31 +1000
Cc: "KaiGai Kohei" <kaigai@ak.jp.nec.com>,
        "Willis Vandevanter" <vandevwa@jmu.edu>, selinux@tycho.nsa.gov,
        ynakam@hitachisoft.jp
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com> <487D46B5.9070608@ak.jp.nec.com> <dd18b0c30807152013s2c21888ei73896ff2a51b67df@mail.gmail.com>
In-Reply-To: <dd18b0c30807152013s2c21888ei73896ff2a51b67df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807161714.35195.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 16 July 2008 13:13, "Justin Mattock" <justinmattock@gmail.com> 
wrote:
> make sure fstab has it entry to mount SELinux, and do a ldd /sbin/init

I think that in most situations any requirement for a SE Linux entry 
in /etc/fstab would be a bug.  NB I am not saying that no-one needs it, 
merely that if you need it then you probably need to fix something else.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
