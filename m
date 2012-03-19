Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2J6GWxj030600
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2012 02:16:33 -0400
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id F39BD18085
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2012 17:16:19 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: global name 'seinfo' is not defined
Date: Mon, 19 Mar 2012 17:16:19 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201203191716.19321.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm stuck on the following error after updating the Debian packages to the 
latest userspace.  Could someone please tell me where this "seinfo" function 
is supposed to be defined?  I can probably work out the cause of this if I 
could find where it's defined.

As an aside, if someone who's good at Python wants to help out with the Debian 
SE Linux work then that would be greatly appreciated.  Not much work is 
required, but it's tough for people like me who generally don't do Python.


# dmesg|audit2allow 
Traceback (most recent call last):
  File "/usr/bin/audit2allow", line 354, in <module>
    app.main()
  File "/usr/bin/audit2allow", line 345, in main
    self.__output()
  File "/usr/bin/audit2allow", line 315, in __output
    g.add_access(self.__avs)
  File "/usr/lib/python2.7/dist-packages/sepolgen/policygen.py", line 211, in 
add_access
    self.__add_allow_rules(raw_allow)
  File "/usr/lib/python2.7/dist-packages/sepolgen/policygen.py", line 179, in 
__add_allow_rules
    self.domains = seinfo(ATTRIBUTE, name="domain")[0]["types"]
NameError: global name 'seinfo' is not defined

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
