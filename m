Date: Tue, 2 Oct 2012 17:12:42 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SELinux@tycho.nsa.gov
Subject: semanage not properly logging new seuser
Message-ID: <20121002171242.41f814cd@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

When running "semanage login -m -s unconfined_u root" the following
line is logged by audit.

type=ROLE_ASSIGN msg=audit(1349190214.690:761): pid=0 uid=0 auid=1000 ses=2 subj=unconfined_u:unconfined_r:semanage_t:s0-s0:c0.c1023 msg='op=login-sename acct="root" old-seuser=unconfined_u old-role=system_r,unconfined_r old-range=s0-s0:c0.c1023 new-seuser=? new-role=system_r,unconfined_r new-range=s0-s0:c0.c1023 exe=/usr/sbin/semanage (hostname=?, addr=?, terminal=pts/1 res=success)'

The line is missing the new-seuser value.

Also note that without python-audit installed (and with the patch I
just sent), semanage is just crashing with the following traceback:

Traceback (most recent call last):
  File "/usr/sbin/semanage", line 569, in <module>
    process_args(sys.argv[1:])
  File "/usr/sbin/semanage", line 451, in process_args
    OBJECT.modify(target, seuser, serange)
  File "/usr/lib/python2.7/dist-packages/seobject.py", line 595, in modify
    self.__modify(name, sename, serange)
  File "/usr/lib/python2.7/dist-packages/seobject.py", line 590, in __modify
    self.mylog.log("login", name,sename=self.sename,serange=self.serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange);
  File "/usr/lib/python2.7/dist-packages/seobject.py", line 92, in log
    message += " sename=" + sename
TypeError: cannot concatenate 'str' and 'NoneType' objects

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
