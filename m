Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2VFlCJf017678
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 11:47:12 -0400
Received: from mwmail02la.mail2world.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2VFkQIb003638
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 15:46:52 GMT
From: "Takesi satoh" <t_mail@mail2Airport.com>
To: <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: RBAC in RHEL5
Date: Mon, 31 Mar 2008 08:45:14 -0700
Message-ID: <109201c89346$35f324a0$046a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_1093_01C8930B.89944CA0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_1093_01C8930B.89944CA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


On Sun, 2008-03-30 at 09:58 -0700, Takesi satoh wrote:
>> I wonder that I can use RBAC in RHEL5 or not.
>> Here is my problem.
>> 
>> I created new user, and new roles. Let me say john_u: john_r:john_t.
>> After I made loadable module, loaded it, and I added some entry to
>> default_context and default_type,
>> john_u:john_r:john_t was assigned to linux user "john" when john
>> logined from GNOME.
>> 
>> Next, since I wanted to try the case of "john logins from console", 
>> I added new entry "system_r:local_login_t john_r:john_t
>> system_r:unconfined_t" to default_context
>> and jonh logins from console(tty), then system_r:unconfined_t was
>> assigned to john.
>> 
>> I thought the reason why it happened was the below policy
>> "type_transition local_login_t shell_exec_t:process transition",
>> so I downloaded RHEL's selinux-policy-targeted.src.rpm, replaced from
>> above type_transition sentence to "allow local_login_t
>> userdomain:process transition;" in local_login.te, and rebuilded rpm.
>> 
>> Then, john logined from console again, and john was assigned to
>> "local_login_t"
>> Any domain transition did not happen here.
>> I wondered " What if I use strict policy? ", so I tried strict
policy.
>> But the result is same, john was assined to local_login_t.
>
>How did you create your user role? Did you just declare the types and
>roles, or did you use the policy templates?

I declared just types, roles, and some attribute such as
process_user_target and process_uncond_exempt
to follow constraints.
Anyway, I updated pam and pam-devel rpms, then I can assign new role to
linux user!
Thank you for your reply.



>-- 
>Chris PeBenito
>Tresys Technology, LLC
>(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.
. 





Save on Cell Phones. Click Now!
<http://tagline.bidsystem.com/fc/Ioyw36XI3zg0r88Ufuze522CunQ0TLsvGsoe3NR
nZgqp0aLqdGuBwL/> 



<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_1093_01C8930B.89944CA0
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
<br>

On Sun, 2008-03-30 at 09:58 -0700, Takesi satoh wrote:<br>

&gt;&gt; I wonder that I can use RBAC in RHEL5 or not.<br>

&gt;&gt; Here is my problem.<br>

&gt;&gt; <br>

&gt;&gt; I created new user, and new roles. Let me say john_u: john_r:john_t.<br>

&gt;&gt; After I made loadable module, loaded it, and I added some entry to<br>

&gt;&gt; default_context and default_type,<br>

&gt;&gt; john_u:john_r:john_t was assigned to linux user "john" when john<br>

&gt;&gt; logined from GNOME.<br>

&gt;&gt; <br>

&gt;&gt; Next, since I wanted to try the case of "john logins from console", <br>

&gt;&gt; I added new entry "system_r:local_login_t john_r:john_t<br>

&gt;&gt; system_r:unconfined_t" to default_context<br>

&gt;&gt; and jonh logins from console(tty), then system_r:unconfined_t was<br>

&gt;&gt; assigned to john.<br>

&gt;&gt; <br>

&gt;&gt; I thought the reason why it happened was the below policy<br>

&gt;&gt; "type_transition local_login_t shell_exec_t:process transition",<br>

&gt;&gt; so I downloaded RHEL's selinux-policy-targeted.src.rpm, replaced from<br>

&gt;&gt; above type_transition sentence to "allow local_login_t<br>

&gt;&gt; userdomain:process transition;" in local_login.te, and rebuilded rpm.<br>

&gt;&gt; <br>

&gt;&gt; Then, john logined from console again, and john was assigned to<br>

&gt;&gt; "local_login_t"<br>

&gt;&gt; Any domain transition did not happen here.<br>

&gt;&gt; I wondered " What if I use strict policy? ", so I tried strict policy.<br>

&gt;&gt; But the result is same, john was assined to local_login_t.<br>

&gt;<br>

&gt;How did you create your user role? Did you just declare the types and<br>

&gt;roles, or did you use the policy templates?<br>

<br>

I declared just types, roles, and some attribute such as process_user_target and process_uncond_exempt<br>

to follow constraints.<br>

Anyway, I updated pam and pam-devel rpms, then I can assign new role to linux user!<br>

Thank you for your reply.<br>

<br>

<br>

<br>

&gt;-- <br>

&gt;Chris PeBenito<br>

&gt;Tresys Technology, LLC<br>

&gt;(410) 290-1411 x150<br>

<br>

<br>

<br>

--<br>

This message was distributed to subscribers of the selinux mailing list.<br>

If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>

the words "unsubscribe selinux" without quotes as the message.<br>

. <br>

<br>

<br>


</BODY></HTML>
<br><br><div style="tag_ad_s_ord_66_99:ord_66;border-top: 1px #cccccc solid"><a target="_blank" style="FONT-SIZE: 13px; COLOR: #006599; FONT-FAMILY: Trebuchet MS" href="http://tagline.bidsystem.com/fc/Ioyw36XI3zg0r88Ufuze522CunQ0TLsvGsoe3NRnZgqp0aLqdGuBwL/">Save on Cell Phones. Click Now!</a></div><br>

<span id=m2wTl><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Get the FREE email that has everyone talking at <a href=http://www.mail2world.com target=new>http://www.mail2world.com</a><br>  <font color=#999999>Unlimited Email Storage &#150; POP3 &#150; Calendar &#150; SMS &#150; Translator &#150; Much More!</font></font></span>
------=_NextPart_000_1093_01C8930B.89944CA0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
