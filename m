Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0M2vmk1015168
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 21:57:48 -0500
Received: from g1t0027.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0M2vlW8005613
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2008 02:57:47 GMT
From: Paul Moore <paul.moore@hp.com>
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.24-rc8-mm1 and SELinux MLS - not playing nice....
Date: Mon, 21 Jan 2008 21:47:37 -0500
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
References: <15439.1200642661@turing-police.cc.vt.edu> <Xine.LNX.4.64.0801182015180.21631@us.intercode.com.au> <3757.1200805301@turing-police.cc.vt.edu>
In-Reply-To: <3757.1200805301@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801212147.37969.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 20 January 2008 12:01:41 am Valdis.Kletnieks@vt.edu wrote:
> On Fri, 18 Jan 2008 20:17:00 +1100, James Morris said:
> > This looks the same as what akpm hit.  Paul Moore has updated his labeled
> > networking patches (see Subject: [RFC PATCH v12 00/18] Labeled networking
> > changes for 2.6.25), and you could try dropping those into the broken out
> > -mm in place of the existing git patch, or just wait for a new -mm.
>
> Confirming - I took V12 0-18, cat'ed it into one file, plopped that on top
> of the broken-out/git-lblnet.patch and quilted up a test -rc8-mm1 and that
> booted without complaints

Thanks for verifying this fix (and for all of the other testing help you've 
provided recently).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
