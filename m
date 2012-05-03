Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q43BUTbO007027
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2012 07:30:30 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casinee app <appcasinee@gmail.com>
Subject: Re: Can't login the embedded linux with seliux support
Date: Thu, 3 May 2012 21:30:23 +1000
Cc: selinux@tycho.nsa.gov
References: <CAO-AVB4KaNM=V97rPjgTDr_x5QuXvyAZnoBv8WJWZDG+2a6RpA@mail.gmail.com>
In-Reply-To: <CAO-AVB4KaNM=V97rPjgTDr_x5QuXvyAZnoBv8WJWZDG+2a6RpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201205032130.23611.russell@coker.com.au>
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

On Thu, 3 May 2012, casinee app <appcasinee@gmail.com> wrote:
> i build a linux system with selinux support for my embedded device. It
> now can login as the root user automatically when it is powered on.

What distribution is the embedded system most similar to?  Using Busybox makes 
things a bit more difficult as some of the programs won't end up in the 
correct domains unless you do some work.  But it would be good to know more 
about the distro so we can identify other potential problems.

With this automatic login, what is the context of the shell?  "id -Z" should 
tell you.

> Then i copy the fiels( shadow ,group and passwd) in my PC linux system
> to the embedded system, and add the login to it. But after i input the
> username and pass word, it output like this :

So you had a working system but then after copying those three files it didn't 
work?  If so then it probably got the wrong type for one of them.  If so then
"restorecon -R -v /etc" will probably fix it.

> login:root
> password:
> login:Can’t get SID for root
> 
> The output comes from the file  login.c in busybox, how can i sovle
> this problem?
> Does this problem comes from the error in my policy? or the lib
> related to the selinux?

When there's a problem that prevents logging in then it's often best to boot 
the system with "enforcing=0" on the kernel command line.  Then you can login 
and view the contexts of the processes and files in question and also look at 
the audit log (or kernel log for a system without auditd) to see what would 
have been denied.  All login programs should have special-case code to allow 
launching a shell in an invalid context when the system is in permissive mode.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
