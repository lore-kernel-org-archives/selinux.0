Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55CYvD6020136
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 08:34:57 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l55CYs9Y016136
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 12:34:54 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l55CXhOO012983
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 08:33:44 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l55CXh49012982
	for selinux@tycho.nsa.gov; Tue, 5 Jun 2007 08:33:43 -0400
Message-ID: <9e8747560706041536w668b0d58wb02dec03c86c8da4@mail.gmail.com>
Date: Tue, 5 Jun 2007 00:36:40 +0200
From: "Paul S" <nnm.one@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: help,sshd, nlmsg_relay
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14691_32376496.1180996600715"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_14691_32376496.1180996600715
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

When I try to connect to my sshd from LAN, when in enforcing more, I get
permission denied after typing in the password on the client.
I tried pinpointing the problem but I can't seem to compile and use a module
for sshd from the AVC messages. I used "cat /var/log/messages | audit2allow
-l -M local" and when installing the module I get lots of assertions, so
here's the sshd parts:

-------------------------------------------------------------------------------------------------------------
[root@area51 sshd]# cat MYsshd.te
module MYsshd 1.0;

require {
        type staff_t;
        type user_home_dir_t;
        type sshd_t;
        class file { write ioctl };
        class capability { audit_control audit_write };
        class netlink_audit_socket { create nlmsg_relay write read };
}

#============= sshd_t ==============
allow sshd_t self:capability { audit_control audit_write };
allow sshd_t self:netlink_audit_socket { create nlmsg_relay read write };

#============= staff_t =============
allow staff_t user_home_dir_t:file { write ioctl };

-------------------------------------------------------------------------------------------------------------
[root@area51 sshd]# semodule -i MYsshd.pp
libsepol.check_assertion_helper: assertion on line 0 violated by allow
sshd_t sshd_t:netlink_audit_socket { nlmsg_relay };
libsepol.check_assertion_helper: assertion on line 0 violated by allow
sshd_t sshd_t:capability { audit_write };
libsepol.check_assertion_helper: assertion on line 0 violated by allow
sshd_t sshd_t:capability { audit_control };
libsepol.check_assertions: 3 assertion violations occured
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!

-------------------------------------------------------------------------------------------------------------


thnx

------=_Part_14691_32376496.1180996600715
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br><br>When I try to connect to my sshd from LAN, when in enforcing more, I get permission denied after typing in the password on the client.<br>I tried pinpointing the problem but I can&#39;t seem to compile and use a module for sshd from the AVC messages. I used &quot;cat /var/log/messages | audit2allow -l -M local&quot; and when installing the module I get lots of assertions, so here&#39;s the sshd parts:
<br><br>-------------------------------------------------------------------------------------------------------------<br>[root@area51 sshd]# cat MYsshd.te<br>module MYsshd 1.0;<br><br>require {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type staff_t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type user_home_dir_t;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type sshd_t;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class file { write ioctl };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class capability { audit_control audit_write };<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class netlink_audit_socket { create nlmsg_relay write read };
<br>}<br><br>#============= sshd_t ==============<br>allow sshd_t self:capability { audit_control audit_write };<br>allow sshd_t self:netlink_audit_socket { create nlmsg_relay read write };<br><br>#============= staff_t =============
<br>allow staff_t user_home_dir_t:file { write ioctl };<br><br>-------------------------------------------------------------------------------------------------------------<br>[root@area51 sshd]# semodule -i MYsshd.pp <br>
libsepol.check_assertion_helper: assertion on line 0 violated by allow sshd_t sshd_t:netlink_audit_socket { nlmsg_relay };<br>libsepol.check_assertion_helper: assertion on line 0 violated by allow sshd_t sshd_t:capability { audit_write };
<br>libsepol.check_assertion_helper: assertion on line 0 violated by allow sshd_t sshd_t:capability { audit_control };<br>libsepol.check_assertions: 3 assertion violations occured<br>libsemanage.semanage_expand_sandbox: Expand module failed
<br>semodule:&nbsp; Failed!<br><br>-------------------------------------------------------------------------------------------------------------<br><br><br>thnx<br>

------=_Part_14691_32376496.1180996600715--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
