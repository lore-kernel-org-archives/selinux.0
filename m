Message-ID: <6b3a7f010705161113r2de28764x1825308ed920cc2a@mail.gmail.com>
Date: Wed, 16 May 2007 14:13:09 -0400
From: "Norman Elton" <normelton@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: Console login problems
In-Reply-To: <6b3a7f010705151434j55e27adap2cd1722f01db9b34@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_27383_22759838.1179339189518"
References: <6b3a7f010705151434j55e27adap2cd1722f01db9b34@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_27383_22759838.1179339189518
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have tested this with a local user with a kerberos password (ruling out
LDAP issues). Continue to have the problem. A local user with a local
password does not have a problem.

The only line in the KDC logs is:

AS_REQ (7 etypes {18 17 16 23 1 3 2}) 128.239.18.20: ISSUE: authtime
1179338559, etypes {rep=16 tkt=16 ses=16}, testuser@KRBDOMAIN for
krbtgt/KRBDOMAIN@KRBDOMAIN

This seems normal.

Any other thoughts? What would cause kerberos to kill a session?

Thanks

Norman

On 5/15/07, Norman Elton <normelton@gmail.com> wrote:
>
> I have installed RHEL5 on a test system. Local accounts (such as root) can
> login without a problem. Accounts stored in an LDAP/Kerberos database
> experience unpredictable behavior. They can occassionally login. More often
> than not, once they hit a bash prompt, they are immediately kicked back to
> the login prompt. It's like bash is crashing.
>
> In my /var/log/secure, I see the following...
>
> May 15 15:57:00 localhost login: pam_unix(login:auth): authentication
> failure; logname=LOGIN uid=0 euid=0 tty=tty1 ruser= rhost=  user=testuser
> May 15 15:57:00 localhost login: pam_krb5[3659]: authentication succeeds
> for 'testuser' ( testuser@KRBDOMAIN)
> May 15 15:57:00 localhost login: pam_unix(login:session): session opened
> for user testuser by LOGIN(uid=0)
> May 15 15:57:00 localhost login: pam_selinux(login:session): Warning!
> Could not get new context for /dev/tty1, not relabeling: Invalid argument
> May 15 15:57:00 localhost login: pam_selinux(login:session):
> usercon=(null), prev_context=system_u:object_r:tty_device_t
> May 15 15:57:00 localhost login: LOGIN ON tty1 BY testuser
> May 15 15:57:00 rheltest login: pam_unix(login:session): session closed
> for user testuser
>
> Here's the bizarre part... even if I completely disable selinux and
> reboot, I still get the same warning message and the symptoms reoccur.
>
> I would think disabling selinux would make the sympton go away if it were
> indeed an selinux problem.
>
> This is only happening to LDAP/Kerberos users, and not every time. Any
> thoughts?
>
> Thanks,
>
> Norman
>

------=_Part_27383_22759838.1179339189518
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have tested this with a local user with a kerberos password (ruling out LDAP issues). Continue to have the problem. A local user with a local password does not have a problem.<br><br>The only line in the KDC logs is:<br>
<br>AS_REQ (7 etypes {18 17 16 23 1 3 2}) <a href="http://128.239.18.20">128.239.18.20</a>: ISSUE: authtime 1179338559, etypes {rep=16 tkt=16 ses=16}, testuser@KRBDOMAIN for krbtgt/KRBDOMAIN@KRBDOMAIN<br><br>This seems normal.
<br><br>Any other thoughts? What would cause kerberos to kill a session?<br><br>Thanks<br><br>Norman<br><br><div><span class="gmail_quote">On 5/15/07, <b class="gmail_sendername">Norman Elton</b> &lt;<a href="mailto:normelton@gmail.com">
normelton@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I have installed RHEL5 on a test system. Local accounts (such as root) can login without a problem. Accounts stored in an LDAP/Kerberos database experience unpredictable behavior. They can occassionally login. More often than not, once they hit a bash prompt, they are immediately kicked back to the login prompt. It&#39;s like bash is crashing.
<br><br>In my /var/log/secure, I see the following...<br><br>May 15 15:57:00 localhost login: pam_unix(login:auth): authentication failure; logname=LOGIN uid=0 euid=0 tty=tty1 ruser= rhost=&nbsp; user=testuser<br>May 15 15:57:00 localhost login: pam_krb5[3659]: authentication succeeds for &#39;testuser&#39; (
testuser@KRBDOMAIN)<br>May 15 15:57:00 localhost login: pam_unix(login:session): session opened for user testuser by LOGIN(uid=0)<br>May 15 15:57:00 localhost login: pam_selinux(login:session): Warning!&nbsp; Could not get new context for /dev/tty1, not relabeling: Invalid argument
<br>May 15 15:57:00 localhost login: pam_selinux(login:session): usercon=(null), prev_context=system_u:object_r:tty_device_t<br>May 15 15:57:00 localhost login: LOGIN ON tty1 BY testuser<br>May 15 15:57:00 rheltest login: pam_unix(login:session): session closed for user testuser
<br><br>Here&#39;s the bizarre part... even if I completely disable selinux and reboot, I still get the same warning message and the symptoms reoccur.<br><br>I would think disabling selinux would make the sympton go away if it were indeed an selinux problem.
<br><br>This is only happening to LDAP/Kerberos users, and not every time. Any thoughts?<br><br>Thanks,<br><span class="sg"><br>Norman<br>
</span></blockquote></div><br>

------=_Part_27383_22759838.1179339189518--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
