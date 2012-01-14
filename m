Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0EEYVMe018752
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 09:34:31 -0500
Received: from mail-ee0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0EEYU0O016111
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 14:34:30 GMT
Received: by eekd41 with SMTP id d41so13558eek.12
        for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2012 06:34:29 -0800 (PST)
Date: Sat, 14 Jan 2012 15:34:21 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux with initramfs
Message-ID: <20120114143421.GB5632@siphos.be>
References: <20120114142001.GA5632@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120114142001.GA5632@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jan 14, 2012 at 03:20:02PM +0100, Sven Vermeulen wrote:
> An initramfs' /init will run in the kernel_t domain (and unconfined until
> load_policy is called ?) 

Not unconfined, permissive.

Wkr,
	Sven Vermeulen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
