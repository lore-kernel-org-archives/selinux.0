Subject: Policy source and initial ramdisk
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Frank Mayer <mayerf@tresys.com>, Dave Caplan <dac@tresys.com>
Content-Type: text/plain
Message-Id: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Tue, 16 Sep 2003 17:22:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It appears that users are required to call mkinitrd whenever the policy
is modified. If this is the case it seems that users might be unaware
that make install /etc/security/selinux/src/policy doesn't change the
policy loaded during the next boot. Additionally, it is problematic for
tools that modify the policy source. The quickest solution would be to
modify the install target to call mkinitrd, but this has some issues
(like reliably determining the name of the ramdisk image). Does anyone
have any thoughts about the best way to approach this problem?

Karl
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
