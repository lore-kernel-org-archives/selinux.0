Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0RCncRb029290
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 07:49:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0RCmLxr001324
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 12:48:21 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i0RCmLYc001321
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2004 12:48:21 GMT
Message-ID: <40165E5D.2050905@redhat.com>
Date: Tue, 27 Jan 2004 07:49:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mark Shakespeare <mshakes@llnl.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: Has something changed on Dan Walsh's site?
References: <p06020419bc3b1448ee02@[128.115.96.64]>
In-Reply-To: <p06020419bc3b1448ee02@[128.115.96.64]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mark Shakespeare wrote:

> I tried a fresh install of SeLinux on top of a new Fedora build.
> Using Dan Walsh's selUpgrade script.....used to work a week ago.
>
> Now I get many errors....

What  is happening is the packages are building for FC2.  So there are 
dependencies leaking in that don't work on FC1.  I will try to clean 
them up.

>
> error: Failed dependencies:
>
>     glibc-headers = 2.3.3 is needed by glibc-devel-2.3.3-1
>     db4 = 4.2.52 is needed by pam-0.77-24
>     libproc.so.2.0.17 is needed by rusers-server-0.17-34.sel
>     libtcl8.4.so is needed by setools-gui-1.1.1-1
>     libtk8.4.so is needed by setools-gui-1.1.1-1
>     glibc = 2.3.2 is needed by ( installed ) glibc-headers-2.3.2-101
>
> it then down loads the newest 2.6.1-1.141 kernel......
>
> starts to build the kernel...
>
> then fails......
>
> ./selUpgrade: line 55: cd: /etc/security/selinux/src/policy/domains: 
> no such file or directory
>
> cp: cannot stat `program/unused/*': no such file or directory
> rm: cannot remove `program/dpkg*': no such file or directory
> rm: cannot remove `program/qmail*': no such file or directory
> rm: cannot remove `program/gatekeeper*': no such file or directory
> cp: cannot stat `misc/unused/*': no such file or directory
>
> ./selUpgrade: line 65: cd: /etc/security/selinux/src/policy: no such 
> file or directory
>
> make: *** no targets specified and no makefile found.  Stop.
>
>
>
> Any help would be greatly appreciated.
>
> I had this working fine a week ago....
>
> Now it is broke. Looks like the SeLinux directory is not being created.
>
>
>
>
>                                 Mark
>
>
>
>
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
