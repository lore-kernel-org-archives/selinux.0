Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i37000Rb006020
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 20:00:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i36Nxxmw022268
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 23:59:59 GMT
Received: from mutemail.com (mutemail.com [24.244.170.124])
        by jazzband.ncsc.mil  with SMTP id i36Nxv4w022250 for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2004 23:59:58 GMT
Date: Tue, 06 Apr 2004 16:59:37 -0700
From: Bill McCarty <bmccarty@pt-net.net>
To: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <88042458.1081270777@[192.168.0.3]>
In-Reply-To: <401FF280.8070301@treblig.org>
References: <401FF280.8070301@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I'm trying to follow the trail for installing SELinux on Debian unstable, 
as helpfully documented by Dave Gilbert (see below). Thanks, Dave!

However, I'm having difficulty with the Selinux-policy-default package, 
which Dselect complains is not compatible with Policycoreutils. I plan to 
start over with a very minimal Debian installation on the hypothesis that 
one or more of the SELinux package versions has been obsoleted by a 
non-SELinux package. Can anyone offer other suggestions for installing 
SELinux under Debian, whether stable or unstable?

Cheers,

--On Tuesday, February 03, 2004 7:12 PM +0000 "Dave Gilbert (Home)" 
<gilbertd@treblig.org> wrote:

> So - to summarise (for those reading this in the future - is the archive
> working?); to get SELinux working on Debian/woody:
>
>    * Get the kernel patches (lsm and exec-shield) off Russell Coker's site
>    * Get the standard debian 2.4.24 kernel package (from the main debian
> pool) and the debian kernel-patch-acl package    * To the standard kernel
> apply the kernel-patch-acl patches (if you are doing it by hand that has
> to be in the order ea, acl, nfsacl)    * Apply the exec-shield patch
>    * apply the lsm patch
>
> Add:
>
>
> deb http://www.microcomaustralia.com.au/debian unstable selinux main
>
> to your sources.list
>
> and follow the instructions from the *new* selinux howto - that will be
> the one that tells you to mount /selinux and doesn't mention the 'login'
> package.
>
> Note: When installing the packages it is best to do one big apt-get line
> rather than one at a time - doing them individually has a nasty habit of
> removing other packages.

---------------------------------------------------
Bill McCarty, Ph.D.
Professor of Information Technology
Azusa Pacific University



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
