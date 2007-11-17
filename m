Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAH2H6xc025217
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 21:17:06 -0500
Received: from dmzmta103.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAH2H5hP008180
	for <selinux@tycho.nsa.gov>; Sat, 17 Nov 2007 02:17:05 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lAH2Ekbj013028
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 21:14:48 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lAH2EEqJ021867
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 21:14:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: selinux problem or not???
Date: Fri, 16 Nov 2007 18:17:01 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD025553D7@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Cc: "Jensen, Curtis R \(US SSA\)" <curtis.jensen@baesystems.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running into some weird behavior on a RHEL5 system and I'm not sure
if it's related to selinux or not. The behavior began after rebooting
the system to switch to a different selinux policy. This same policy has
been installed on other systems without issue. The /etc/selinux/config
file was set to put the policy into permissive mode upon reboot.

After the initial reboot, and each time after several subsequent
reboots, we've come across files which can not be read, by both root and
ordinary users. These files can not be read even in permissive mode. 

For example, I could not read a csh script file that was owned by user
m2, with permissions of 764. I could not read this file as either user
m2 or root, with the policy in permissive mode. However, I used chmod to
change the permissions of the file to 777, and then could read it. Using
chmod to put it back to 764, I could still read the file as expected. I
have no idea what was preventing me from initially reading the file.

The same thing happened to another user after a different reboot with a
property file. Similar to what I described above, the user could not
read the file in permissive mode even though the DAC permissions
appeared as though it should have allowed him to do so. In that case the
user was able to move the file to a different directory and then could
read it, which makes no sense.

Each time we reboot this problem afflicts different files. One time I
found I could not use the ps command because I could not read /bin/ps.
During each reboot I've been careful to make sure that an empty
/.autorelabel file existed to make sure the filesystem remained in a
consistent state. I have found no selinux labeling issues with the files
that have had these problems.

This last time I was forced to reboot because I found that I could not
start the auditd daemon, which of course makes it difficult to
troubleshoot any selinux AVC denials. I couldn't start this in either
enforcing or permissive mode, but had no problems starting it after the
reboot.

Any ideas on what may be going on would be greatly appreciated.

Thanks




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
