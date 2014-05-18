Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4IHIn1D012046
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 13:18:49 -0400
Date: Sun, 18 May 2014 19:18:44 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: semanage: TypeError: cannot concatenate 'str' and 'NoneType' objects
Message-ID: <20140518191844.2365e3ad@soldur.bigon.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: 734806-forwarded@bugs.debian.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

On a machine without python-audit installed, changing the seuser is
creating the following backtrace.

$ sudo semanage login -m -s root root
Traceback (most recent call last):
  File "/usr/sbin/semanage", line 840, in <module>
    do_parser()
  File "/usr/sbin/semanage", line 819, in do_parser
    args.func(args)
  File "/usr/sbin/semanage", line 201, in handleLogin
    OBJECT.modify(args.login, args.seuser, args.range)
  File "/usr/lib/python2.7/dist-packages/seobject.py", line 594, in modify
    self.__modify(name, sename, serange)
  File "/usr/lib/python2.7/dist-packages/seobject.py", line 589, in __modify
    self.mylog.log("login", name,sename=self.sename,serange=self.serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange);
  File "/usr/lib/python2.7/dist-packages/seobject.py", line 110, in log
    message += " sename=" + sename
TypeError: cannot concatenate 'str' and 'NoneType' objects

Looking at the code, it seems that semange is only checking if sename
is an empty string or not (if sename != "") but here it seems that
sename is a None object. I guess the code should also check this?

Cheers,

Laurent Bigonville
