Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7TAXGrq011562
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 06:33:16 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7TAXFnt023348
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 10:33:16 GMT
Received: by rv-out-0708.google.com with SMTP id f25so838921rvb.54
        for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 03:33:15 -0700 (PDT)
Message-ID: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
Date: Fri, 29 Aug 2008 16:03:15 +0530
From: "shaunak saha" <reach.shaunak@gmail.com>
To: selinux@tycho.nsa.gov
Subject: semodule -i error
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6490_16932661.1220005995273"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_6490_16932661.1220005995273
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

When i m trying to install a module using semodule -i <name of the module> i
m geting the following error:

*libsepol.print_missing_requirements: dbus_rpc_example_server's global
requirements were not met: type/attribute resmgrd_var_run_t
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!*

Also when i do "semodule -l" i could not see any module *resmgr*.

I m actually trying to insert a new class gconf (making gconf-daemon an
userspace object manager).
For this i have downloaded the refpolicy

*refpolicy-20080702.tar.bz2* from  *
http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease* and installed
it.

Then from  /etc/selinux/refpolicy/src/policy/policy/flask directory i
m editing the security_classes and access_vectors files to add my new gconf
class and permissions, then rebuilding and installing the policy.
The whenever i m giving the class gconf in my module .te file and trying to
install it i m getting this error.I guess i m missing something.PLease help.


Regards,
Shaunak

------=_Part_6490_16932661.1220005995273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>Hi all,</div>
<div>&nbsp;</div>
<div>When i m trying to install a module using semodule -i &lt;name of the module&gt; i m geting the following error:</div>
<div>&nbsp;</div>
<div><strong>libsepol.print_missing_requirements: dbus_rpc_example_server&#39;s global requirements were not met: type/attribute resmgrd_var_run_t<br>libsemanage.semanage_link_sandbox: Link packages failed<br>semodule:&nbsp; Failed!</strong></div>

<div>&nbsp;</div>
<div>Also when i do &quot;semodule -l&quot; i could not see any module <strong>resmgr</strong>.</div>
<div>&nbsp;</div>
<div>I m actually trying to insert a new class gconf (making gconf-daemon an userspace object manager).</div>
<div>For this i have downloaded the refpolicy</div>
<div>&nbsp; </div>
<div><strong>refpolicy-20080702.tar.bz2</strong> from&nbsp; <strong><a href="http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease">http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease</a></strong> and installed it. </div>

<div>&nbsp;</div>
<div>Then from &nbsp;/etc/selinux/refpolicy/src/policy/policy/flask directory&nbsp;i m&nbsp;editing the security_classes and access_vectors files to add&nbsp;my new gconf class and permissions, then rebuilding and installing the policy.</div>

<div>The whenever i m giving the class gconf in my module .te file and trying to install it i m getting this error.I guess i m missing something.PLease help.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Shaunak</div>
<p>&nbsp;</p>
<div>&nbsp;</div></div>

------=_Part_6490_16932661.1220005995273--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
