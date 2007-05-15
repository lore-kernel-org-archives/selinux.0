Message-ID: <6b3a7f010705151434j55e27adap2cd1722f01db9b34@mail.gmail.com>
Date: Tue, 15 May 2007 17:34:52 -0400
From: "Norman Elton" <normelton@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Console login problems
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11261_19842280.1179264892520"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_11261_19842280.1179264892520
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have installed RHEL5 on a test system. Local accounts (such as root) can
login without a problem. Accounts stored in an LDAP/Kerberos database
experience unpredictable behavior. They can occassionally login. More often
than not, once they hit a bash prompt, they are immediately kicked back to
the login prompt. It's like bash is crashing.

In my /var/log/secure, I see the following...

May 15 15:57:00 localhost login: pam_unix(login:auth): authentication
failure; logname=LOGIN uid=0 euid=0 tty=tty1 ruser= rhost=  user=testuser
May 15 15:57:00 localhost login: pam_krb5[3659]: authentication succeeds for
'testuser' (testuser@KRBDOMAIN)
May 15 15:57:00 localhost login: pam_unix(login:session): session opened for
user testuser by LOGIN(uid=0)
May 15 15:57:00 localhost login: pam_selinux(login:session): Warning!  Could
not get new context for /dev/tty1, not relabeling: Invalid argument
May 15 15:57:00 localhost login: pam_selinux(login:session): usercon=(null),
prev_context=system_u:object_r:tty_device_t
May 15 15:57:00 localhost login: LOGIN ON tty1 BY testuser
May 15 15:57:00 rheltest login: pam_unix(login:session): session closed for
user testuser

Here's the bizarre part... even if I completely disable selinux and reboot,
I still get the same warning message and the symptoms reoccur.

I would think disabling selinux would make the sympton go away if it were
indeed an selinux problem.

This is only happening to LDAP/Kerberos users, and not every time. Any
thoughts?

Thanks,

Norman

------=_Part_11261_19842280.1179264892520
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have installed RHEL5 on a test system. Local accounts (such as root) can login without a problem. Accounts stored in an LDAP/Kerberos database experience unpredictable behavior. They can occassionally login. More often than not, once they hit a bash prompt, they are immediately kicked back to the login prompt. It&#39;s like bash is crashing.
<br><br>In my /var/log/secure, I see the following...<br><br>May 15 15:57:00 localhost login: pam_unix(login:auth): authentication failure; logname=LOGIN uid=0 euid=0 tty=tty1 ruser= rhost=&nbsp; user=testuser<br>May 15 15:57:00 localhost login: pam_krb5[3659]: authentication succeeds for &#39;testuser&#39; (
testuser@KRBDOMAIN)<br>May 15 15:57:00 localhost login: pam_unix(login:session): session opened for user testuser by LOGIN(uid=0)<br>May 15 15:57:00 localhost login: pam_selinux(login:session): Warning!&nbsp; Could not get new context for /dev/tty1, not relabeling: Invalid argument
<br>May 15 15:57:00 localhost login: pam_selinux(login:session): usercon=(null), prev_context=system_u:object_r:tty_device_t<br>May 15 15:57:00 localhost login: LOGIN ON tty1 BY testuser<br>May 15 15:57:00 rheltest login: pam_unix(login:session): session closed for user testuser
<br><br>Here&#39;s the bizarre part... even if I completely disable selinux and reboot, I still get the same warning message and the symptoms reoccur.<br><br>I would think disabling selinux would make the sympton go away if it were indeed an selinux problem.
<br><br>This is only happening to LDAP/Kerberos users, and not every time. Any thoughts?<br><br>Thanks,<br><br>Norman<br>

------=_Part_11261_19842280.1179264892520--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
