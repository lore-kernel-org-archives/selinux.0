Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0ILCEWY012635
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 16:12:14 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0ILCCdE007113
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 21:12:13 GMT
Received: by wx-out-0506.google.com with SMTP id t8so845187wxc.30
        for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 13:12:12 -0800 (PST)
Message-ID: <dd18b0c30801181312j352b60efuebb87ace244adbcb@mail.gmail.com>
Date: Fri, 18 Jan 2008 13:12:11 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: SystemHigh
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6589_20203024.1200690731943"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_6589_20203024.1200690731943
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; With playing around with refpolicy everything seems good. Now with
the help of you guys converting to mls policy and changing levels seems to
be pretty nice.
But after googling and reading some posts about starting the xserver issuing
startx seems to be not an option with mls. So is there a work around with
this.
from what I'm seeing  if I startx from
sysadm_r:sysadm_t:s0-s15:c0.c255(SystemLow-SystemHigh) most of the
avc's are taken care of, except for
system_u:object_r:memory_device_t:s15:c0.c255 (SystemHigh) /dev/mem.  Then
if I reboot and use newrole -r sysadm_r -l s15:c0.c255 && startx
I receive a list of avc's that seem to not disappear even after adding them,
Is there a boolean to configure?
If there is no solution to this or if mls wasn't designed for startingX then
i'll leave it as is.
Regards;
               --Justin P. Mattock

------=_Part_6589_20203024.1200690731943
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; With playing around with refpolicy everything seems good. Now with the help of you guys converting to mls policy and changing levels seems to be pretty nice.<br>But after googling and reading some posts about starting the xserver issuing startx seems to be not an option with mls. So is there a work around with this.
<br>from what I&#39;m seeing&nbsp; if I startx from sysadm_r:sysadm_t:s0-s15:c0.c255 (SystemLow-SystemHigh) most of the avc&#39;s are taken care of, except for system_u:object_r:memory_device_t:s15:c0.c255 (SystemHigh) /dev/mem.&nbsp; Then if I reboot and use newrole -r sysadm_r -l s15:
c0.c255 &amp;&amp; startx<br>I receive a list of avc&#39;s that seem to not disappear even after adding them, Is there a boolean to configure? <br>If there is no solution to this or if mls wasn&#39;t designed for startingX then i&#39;ll leave it as is.
<br>Regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>

------=_Part_6589_20203024.1200690731943--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
