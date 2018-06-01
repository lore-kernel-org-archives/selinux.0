Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w527HXpd029253
 for <selinux@tycho.nsa.gov>; Sat, 2 Jun 2018 03:17:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40yXZy3dFkzrKYR
 for <selinux@tycho.nsa.gov>; Sat,  2 Jun 2018 07:17:30 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40yXZx1YhvzrKY3
 for <selinux@tycho.nsa.gov>; Sat,  2 Jun 2018 07:17:29 +0000 (UTC)
Received: from liv.localnet (localhost [127.0.0.1])
 by smtp.sws.net.au (Postfix) with ESMTP id B40A8F912
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 23:03:27 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Date: Fri, 01 Jun 2018 23:03:20 +1000
Message-ID: <1556412.5WZ4KfFcyq@liv>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="nextPart10539085.TSFJpDKvbi"
Subject: BTRFS losing SE Linux labels on power failure or "reboot
 -nffd".
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.

--nextPart10539085.TSFJpDKvbi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-1"

The command "reboot -nffd" (kernel reboot without flushing kernel buffers or writing 
status) when run on a BTRFS system will often result in /var/log/audit/audit.log being 
unlabeled.  It also results in some systemd-journald files like /var/log/journal/
c195779d29154ed8bcb4e8444c4a1728/system.journal being unlabeled but that is rarer.  I 
think that the same problem afflicts both systemd-journald and auditd but it's a race 
condition that on my systems (both production and test) is more likely to affect auditd.

If this issue just affected "reboot -nffd" then a solution might be to just not run that 
command.  However this affects systems after a power outage.

I have reproduced this bug with kernel 4.9.0-6-amd64 (the latest security update for 
Debian/Stretch which is the latest supported release of Debian).  I have also reported it in 
an identical manner with kernel 4.16.0-1-amd64 (the latest from Debian/Unstable).  For 
testing I reproduced this with a 4G filesystem in a VM, but in production it has happened 
on BTRFS RAID-1 arrays, both SSD and HDD.

#!/bin/bash 

Firstly the above is the script /usr/local/sbin/testit, I test for auditd running because it 
aborts if the context on it's log file is wrong.

root@stretch:~# ls -liZ /var/log/audit/audit.log 

Above is before I do the tests.

while ssh stretch /usr/local/sbin/testit ; do 

Above is the shell code I run to do the tests.  Note that the VM in question runs on SSD 
storage which is why it can consistently boot in less than 20 seconds.

Fri  1 Jun 12:26:13 UTC 2018 

Above is the output from the shell code in question.  After the first reboot it fails.  The 
probability of failure on my test system is greater than 50%.

root@stretch:~# ls -liZ /var/log/audit/audit.log  

Now the result.  Note that the Inode has not changed.  I could understand a newly created 
file missing an xattr, but this is an existing file which shouldn't have had it's xattr changed.  
But somehow it gets corrupted.

Could this be the fault of SE Linux code?  I don't think it's likely but this is what the BTRFS 
developers will ask so it's best to discuss this here before sending it to them.

Does anyone have any ideas of other tests I should run?  Anyone want me to try a 
different kernel?  I can give root on a VM to anyone who wants to poke at it.  Anything else 
I should add when sending this to the BTRFS developers?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/


--nextPart10539085.TSFJpDKvbi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"text/cs=
s">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'Noto Sans'; font-size:10pt; fon=
t-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The command=
 &quot;reboot -nffd&quot; (kernel reboot without flushing kernel buffers or=
 writing status) when run on a BTRFS system will often result in /var/log/a=
udit/audit.log being unlabeled.  It also results in some systemd-journald f=
iles like <span style=3D" font-family:'monospace'; color:#000000; backgroun=
d-color:#ffffff;">/var/log/journal/c195779d29154ed8bcb4e8444c4a1728/system.=
journal being unlabeled but that is rarer.  I think that the same problem a=
fflicts both systemd-journald and auditd but it's a race condition that on =
my systems (both production and test) is more likely to affect auditd.</spa=
n></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">If =
this issue just affected &quot;reboot -nffd&quot; then a solution might be =
to just not run that command.  However this affects systems after a power o=
utage.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">I h=
ave reproduced this bug with kernel 4.9.0-6-amd64 (the latest security upda=
te for Debian/Stretch which is the latest supported release of Debian).  I =
have also reported it in an identical manner with kernel 4.16.0-1-amd64 (th=
e latest from Debian/Unstable).  For testing I reproduced this with a 4G fi=
lesystem in a VM, but in production it has happened on BTRFS RAID-1 arrays,=
 both SSD and HDD.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">#!/=
bin/bash </span><span style=3D" font-family:'monospace';"><br />set -e <br =
/>COUNT=3D$(ps aux|grep [s]bin/auditd|wc -l) <br />date <br />if [ &quot;$C=
OUNT&quot; =3D &quot;1&quot; ]; then <br />=A0echo &quot;all good&quot; <br=
 />else <br />=A0echo &quot;failed&quot; <br />=A0exit 1 <br />fi<br /></sp=
an></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">Fir=
stly the above is the script /usr/local/sbin/testit, I test for auditd runn=
ing because it aborts if the context on it's log file is wrong.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">roo=
t@stretch:~# ls -liZ /var/log/audit/audit.log </span><span style=3D" font-f=
amily:'monospace';"><br />37952 -rw-------. 1 root root system_u:object_r:a=
uditd_log_t:s0 4385230 Jun =A01 12:23 /var/log/audit/audit.log<br /></span>=
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace';">Above is before I do the tests.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">whi=
le ssh stretch /usr/local/sbin/testit ; do </span><span style=3D" font-fami=
ly:'monospace';"><br />=A0ssh btrfs-local &quot;reboot -nffd&quot; &gt; /de=
v/null 2&gt;&amp;1 &amp; <br />=A0sleep 20 <br />done<br /></span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace';">Above is the shell code I run to do the test=
s.  Note that the VM in question runs on SSD storage which is why it can co=
nsistently boot in less than 20 seconds.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">Fri=
 =A01 Jun 12:26:13 UTC 2018 </span><span style=3D" font-family:'monospace';=
"><br />all good <br />Fri =A01 Jun 12:26:33 UTC 2018 <br />failed<br /></s=
pan></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace';">Above is the output from the shell code in q=
uestion.  After the first reboot it fails.  The probability of failure on m=
y test system is greater than 50%.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace'; color:#000000; background-color:#ffffff;">roo=
t@stretch:~# ls -liZ /var/log/audit/audit.log =A0</span><span style=3D" fon=
t-family:'monospace';"><br />37952 -rw-------. 1 root root system_u:object_=
r:unlabeled_t:s0 4396803 Jun =A01 12:26 /var/log/audit/audit.log<br /></spa=
n></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace';">Now the result.  Note that the Inode has not=
 changed.  I could understand a newly created file missing an xattr, but th=
is is an existing file which shouldn't have had it's xattr changed.  But so=
mehow it gets corrupted.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace';">Could this be the fault of SE Linux code?  I=
 don't think it's likely but this is what the BTRFS developers will ask so =
it's best to discuss this here before sending it to them.</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><span style=
=3D" font-family:'monospace';">Does anyone have any ideas of other tests I =
should run?  Anyone want me to try a different kernel?  I can give root on =
a VM to anyone who wants to poke at it.  Anything else I should add when se=
nding this to the BTRFS developers?</span></p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-- </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">My Main Blo=
g         http://etbe.coker.com.au/</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">My Document=
s Blog    http://doc.coker.com.au/</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nb=
sp;</p></body></html>
--nextPart10539085.TSFJpDKvbi--
