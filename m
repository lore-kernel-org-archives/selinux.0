Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CFmO6e029411
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 10:48:24 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1CFmNwI010600
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 15:48:23 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Disabling SELinux by kernel vulnerability
Date: Tue, 12 Feb 2008 10:45:41 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181F709@exchange.columbia.tresys.com>
In-Reply-To: <47B1B440.7030701@redhat.com>
References: <20080212234339.40551955.himainu-ynakam@miomio.jp> <47B1B440.7030701@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Yuichi Nakamura" <himainu-ynakam@miomio.jp>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> So this exploit, don't you neet to write to /proc?  xguest_t should
> not be allowed to do this?

No, you don't need to be able to write to /proc to exploit the bug.
Having read access /proc/kallsyms just makes things a little easier
for the attacker.  Removing the address of selinux_enforcing from
kallsyms doesn't stop the attack, it just makes the attacker work
a little harder.

Note that the modified exploit that uses kallsyms to find the address
of vmsplice and then opens /dev/kmem read/write to do its work would
be stopped by SELinux.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
