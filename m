Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RI9XsI008013
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 14:09:33 -0400
Received: by eekb47 with SMTP id b47so64508eek.12
        for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:09:31 -0700 (PDT)
Date: Tue, 27 Mar 2012 20:07:10 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 34/73] libselinux: Update Makefiles to handle /usrmove
Message-ID: <20120327180710.GB1468@siphos.be>
References: <4F71DAAB.8030100@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4F71DAAB.8030100@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Mar 27, 2012 at 11:20:11AM -0400, Daniel J Walsh wrote:
> Move everything into /usr/* and just put links from /*.  The whole /usr
> thing hasn't really worked in all situations for a long long time.  Just
> accept that fact and move along.

Actually, I still have a separate /usr (on mdadm raid with lvm)  with no
initramfs (yet, going to move towards one soon given the recent udev releases)
and the services that got loaded before my /usr was mounted all run just fine.

Is this a needed patch, or just something to end possible future
discussions?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
