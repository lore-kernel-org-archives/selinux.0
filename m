Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9Q6DfWt020969
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2003 01:13:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9Q6DeIE010238
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2003 06:13:40 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
        by jazzband.ncsc.mil  with ESMTP id h9Q6Dc1J010235 for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2003 06:13:39 GMT
Message-ID: <001f01c39ac0$79d13d20$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "Diyab" <diyab@diyab.net>, "SELINUX" <SELinux@tycho.nsa.gov>
References: <001401c39a74$ac06b370$5d38a8c0@lky> <3F9AFDB0.1020406@diyab.net>
Subject: Re: question about su and passwd
Date: Sat, 25 Oct 2003 14:23:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday, October 26, 2003 6:48 AM, Diyab wrote:
> Su will only change your user id not your context.  To change your
> context you have to use newrole and it's best to do that before running
> su.  

Then If I enabled the MLS policy, how can I change my context? Because I think newrole don't support the ranges change. Is there any other way besides to login again if I want to change my account with my context?

> passwd, like most of the other user management tools, requires a
> selinux specific version called spasswd.  There are some file labeling
> issues which the normal passwd program can not handle and that is why
> the modified version was made.  If you search the list archives you can
> find out more information about that.

I can't run the spasswd and some other commands for example suseradd. But I have installed the SELinux-patched daemons and utilities without any error messages. I can use the "ls -Z" and "ps -eZ" commands.
Thanks!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
