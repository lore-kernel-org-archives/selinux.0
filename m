Message-ID: <8c2dc7030611300151s6dc2f353x651a5d25bb476a8@mail.gmail.com>
Date: Thu, 30 Nov 2006 17:51:56 +0800
From: "Jian Liu" <gjk.liu@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: how to use a single *.fc to set files
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_38307_20511650.1164880316101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_38307_20511650.1164880316101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As the maypp example at
http://oss.tresys.com/projects/refpolicy/wiki/GettingStarted

1) create a module named myapp by writing the three files: myapp.te,
myapp.if and myapp.fc
2) build the module using policy headers
    $ make -f /usr/share/selinux/targeted/include/Makefile
3) insert myapp.pp
    # semodule -i myapp.pp

Assuming there
is "/usr/bin/myapp" in my system, then  "ls -Z /usr/bin/myapp", but
the security context of "/usr/bin/myapp" is not changed to
"system_u:object_r:myapp_exec_t"
as expected.

   How to use the mypp.fc to set files?

by Liu Jian
------
email to: GJK.Liu@gmail.com

------=_Part_38307_20511650.1164880316101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As the maypp example at <a href="http://oss.tresys.com/projects/refpolicy/wiki/GettingStarted">http://oss.tresys.com/projects/refpolicy/wiki/GettingStarted</a><br><br>1) create a module named myapp by writing the three files: 
myapp.te, myapp.if and myapp.fc<br>2) build the module using policy headers<br>&nbsp;&nbsp;&nbsp;&nbsp;$ make -f /usr/share/selinux/targeted/include/Makefile<br>3) insert myapp.pp<br>&nbsp;&nbsp;&nbsp;&nbsp;# semodule -i myapp.pp<br><br>Assuming there is&nbsp;&quot;/usr/bin/myapp&quot;&nbsp;in&nbsp;my&nbsp;system,&nbsp;then&nbsp;&nbsp;&quot;ls&nbsp;-Z&nbsp;/usr/bin/myapp&quot;, but
<br>the security context of &quot;/usr/bin/myapp&quot; is not changed to &quot;system_u:object_r:myapp_exec_t&quot;<br>as expected.<br><br>&nbsp;&nbsp;&nbsp;How to use the mypp.fc to set files?<br><br>by Liu Jian<br>------<br>email to: 
<a href="mailto:GJK.Liu@gmail.com">GJK.Liu@gmail.com</a> 

------=_Part_38307_20511650.1164880316101--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
