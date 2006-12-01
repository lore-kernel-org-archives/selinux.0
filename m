Message-ID: <8c2dc7030612010133j5709d6b1k72f44e40ed58dbcd@mail.gmail.com>
Date: Fri, 1 Dec 2006 17:33:17 +0800
From: "Jian Liu" <gjk.liu@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: how to test ssh_sysadm_login(tunable)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2118_11668856.1164965597667"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_2118_11668856.1164965597667
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In refpolicy, there is a global tunable named "ssh_sysadm_login". It means
"Allow ssh logns as sysamd_r:sysadm_t".
How to use this tunable?

I have tested it on my lab, and find It is always allowed to "newrole -r
sysadm_r -t sysadm_t" after sshed
to my test server, not mattering ssh_sysadm_login is on or off on the
server.

I do not know whether my test method is fit to the tunable.

btw: on the test server after sshed
       [root@dell ~]# id -Z
       root:staff_r:staff_t

by Liu Jian
--------
email to: GJK.Liu@gmail.com

------=_Part_2118_11668856.1164965597667
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>In refpolicy, there is a global tunable named &quot;ssh_sysadm_login&quot;. It means &quot;Allow ssh logns as sysamd_r:sysadm_t&quot;.<br>How to use this tunable? &nbsp;<br><br>I have tested it  on my lab,  and find It is always allowed to &quot;newrole -r sysadm_r -t sysadm_t&quot; after sshed 
<br>to my test server, not mattering ssh_sysadm_login is on or off on the server.<br><br>I do not know whether my test method is fit to the tunable.<br><br>btw:&nbsp;on&nbsp;the&nbsp;test&nbsp;server&nbsp;after sshed<br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[root@dell ~]# id -Z
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;root:staff_r:staff_t<br><br>by Liu Jian<br>--------<br>email to: <a href="mailto:GJK.Liu@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> GJK.Liu@gmail.com</a>     

------=_Part_2118_11668856.1164965597667--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
