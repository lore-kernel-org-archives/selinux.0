Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6DF7v3L008868
 for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2015 11:07:57 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 00DAD1A1D5
 for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2015 17:07:51 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id avdNTlqv9SdG for <selinux@tycho.nsa.gov>;
 Mon, 13 Jul 2015 17:07:48 +0200 (CEST)
Received: from soldur.bigon.be (unknown [193.53.238.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 027CF1A00F
 for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2015 17:07:47 +0200 (CEST)
Date: Mon, 13 Jul 2015 17:07:43 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: Re: semanage: TypeError: cannot concatenate 'str' and 'NoneType'
 objects
Message-ID: <20150713170743.2d8aac3b@soldur.bigon.be>
In-Reply-To: <20140518191844.2365e3ad@soldur.bigon.be>
References: <20140518191844.2365e3ad@soldur.bigon.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

Bumping a (quite) old mail.

If the audit python binding, "semanage login -m -s root root" is
crashing with a backtrace in the logging part of the code.

It seems that the sename variable is not properly set (type None), the
question is, is that expected?

The original bug report is located
at:https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=734806

Cheers,

Laurent Bigonville

Le Sun, 18 May 2014 19:18:44 +0200,
Laurent Bigonville <bigon@debian.org> a écrit :

> Hello,
> 
> On a machine without python-audit installed, changing the seuser is
> creating the following backtrace.
> 
> $ sudo semanage login -m -s root root
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 840, in <module>
>     do_parser()
>   File "/usr/sbin/semanage", line 819, in do_parser
>     args.func(args)
>   File "/usr/sbin/semanage", line 201, in handleLogin
>     OBJECT.modify(args.login, args.seuser, args.range)
>   File "/usr/lib/python2.7/dist-packages/seobject.py", line 594, in
> modify self.__modify(name, sename, serange)
>   File "/usr/lib/python2.7/dist-packages/seobject.py", line 589, in
> __modify self.mylog.log("login",
> name,sename=self.sename,serange=self.serange,
> serole=",".join(serole), oldserole=",".join(oldserole),
> oldsename=self.oldsename, oldserange=self.oldserange); File
> "/usr/lib/python2.7/dist-packages/seobject.py", line 110, in log
> message += " sename=" + sename TypeError: cannot concatenate 'str'
> and 'NoneType' objects
> 
> Looking at the code, it seems that semange is only checking if sename
> is an empty string or not (if sename != "") but here it seems that
> sename is a None object. I guess the code should also check this?
> 
> Cheers,
> 
> Laurent Bigonville
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
