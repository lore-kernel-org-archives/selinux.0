Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EefeS029736
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:40:41 -0400
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77EeemT025765
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:40:40 GMT
Received: by el-out-1112.google.com with SMTP id m34so281161ele
        for <selinux@tycho.nsa.gov>; Tue, 07 Aug 2007 07:40:40 -0700 (PDT)
Message-ID: <9f066ee90708070734v508adaffy420506b3b1fbbecd@mail.gmail.com>
Date: Tue, 7 Aug 2007 10:34:23 -0400
From: Mark <elihusmails@gmail.com>
To: selinux@tycho.nsa.gov
Subject: policygentool error
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_123575_29538312.1186497263201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_123575_29538312.1186497263201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am just starting out with generating modules, so forgive me if I am way
off course here.  I wrote a simple TCP server application and would like to
run the app in its own domain, just so that I can start learning SE Linux
policy generation.  I stumbled across the tool "policygentool" after reading
the tresys web page.  So I gave it a try with my simple program:

[root@localhost]# policygentool mwserver /usr/bin/mwserver


This tool generate three files for policy development, A Type Enforcement
(te)
file, a File Context (fc), and a Interface File(if).  Most of the policy
rules
will be written in the te file.  Use the File Context file to associate file
paths with security context.  Use the interface rules to allow other
protected
domains to interact with the newly defined domains.

After generating these files use the /usr/share/selinux/devel/Makefile to
compile your policy package.  Then use the semodule tool to load it.

# /usr/share/selinux/devel/policygentool myapp /usr/bin/myapp
# make -f /usr/share/selinux/devel/Makefile
# semodule -l myapp.pp
# restorecon -R -v /usr/bin/myapp "all files defined in myapp.fc"

Now you can turn on permissive mode, start your application and avc messages
will be generated.  You can use audit2allow to help translate the avc
messages
into policy.

# setenforce 0
# service myapp start
# audit2allow -R -i /var/log/audit/audit.log

Return to continue:

If the module uses pidfiles, what is the pidfile called?
n
If the module uses logfiles, where are they stored?
n
If the module has var/lib files, where are they stored?
n
Does the module have a init script? [yN]
n
Does the module use the network? [yN]
y
[root@localhost mwserver]# make -f /usr/share/selinux/devel/Makefile
backup/mwserver.if:38: Error: duplicate definition of mwserver_domtrans().
Original definition on 23.
Compiling seedit mwserver module
/usr/bin/checkmodule:  loading policy configuration from tmp/mwserver.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 6) to
tmp/mwserver.mod
Creating seedit mwserver.pp policy package
rm tmp/mwserver.mod.fc tmp/mwserver.mod
[root@localhost mwserver]# ls
backup  mwserver.fc  mwserver.if  mwserver.pp  mwserver.te  tmp  typescript
[root@localhost mwserver]# semodule -i mwserver.pp
libsepol.permission_copy_callback: Module mwserver depends on permission
flow_out in class packet, not satisfied
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!



-- 
..Cheers
Mark

------=_Part_123575_29538312.1186497263201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am just starting out with generating modules, so forgive me if I am way off course here.&nbsp; I wrote a simple TCP server application and would like to run the app in its own domain, just so that I can start learning SE Linux policy generation.&nbsp; I stumbled across the tool &quot;policygentool&quot; after reading the tresys web page.&nbsp; So I gave it a try with my simple program:
<br><br clear="all">[root@localhost]# policygentool mwserver /usr/bin/mwserver<br><br><br>This tool generate three files for policy development, A Type Enforcement (te)<br>file, a File Context (fc), and a Interface File(if).&nbsp; Most of the policy rules
<br>will be written in the te file.&nbsp; Use the File Context file to associate file<br>paths with security context.&nbsp; Use the interface rules to allow other protected<br>domains to interact with the newly defined domains.<br>
<br>After generating these files use the /usr/share/selinux/devel/Makefile to<br>compile your policy package.&nbsp; Then use the semodule tool to load it.<br><br># /usr/share/selinux/devel/policygentool myapp /usr/bin/myapp<br>
# make -f /usr/share/selinux/devel/Makefile<br># semodule -l myapp.pp<br># restorecon -R -v /usr/bin/myapp &quot;all files defined in myapp.fc&quot;<br><br>Now you can turn on permissive mode, start your application and avc messages
<br>will be generated.&nbsp; You can use audit2allow to help translate the avc messages<br>into policy.<br><br># setenforce 0<br># service myapp start<br># audit2allow -R -i /var/log/audit/audit.log<br><br>Return to continue:<br>
<br>If the module uses pidfiles, what is the pidfile called?<br>n<br>If the module uses logfiles, where are they stored?<br>n<br>If the module has var/lib files, where are they stored?<br>n<br>Does the module have a init script? [yN]
<br>n<br>Does the module use the network? [yN]<br>y<br>[root@localhost mwserver]# make -f /usr/share/selinux/devel/Makefile<br>backup/mwserver.if:38: Error: duplicate definition of mwserver_domtrans(). Original definition on 23.
<br>Compiling seedit mwserver module<br>/usr/bin/checkmodule:&nbsp; loading policy configuration from tmp/mwserver.tmp<br>/usr/bin/checkmodule:&nbsp; policy configuration loaded<br>/usr/bin/checkmodule:&nbsp; writing binary representation (version 6) to tmp/mwserver.mod
<br>Creating seedit mwserver.pp policy package<br>rm tmp/mwserver.mod.fc tmp/mwserver.mod<br>[root@localhost mwserver]# ls<br>backup&nbsp; mwserver.fc&nbsp; mwserver.if&nbsp; mwserver.pp&nbsp; mwserver.te&nbsp; tmp&nbsp; typescript<br>[root@localhost mwserver]# semodule -i 
mwserver.pp<br>libsepol.permission_copy_callback: Module mwserver depends on permission flow_out in class packet, not satisfied<br>libsemanage.semanage_link_sandbox: Link packages failed<br>semodule:&nbsp; Failed!<br><br><br><br>
-- <br>..Cheers<br>Mark

------=_Part_123575_29538312.1186497263201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
