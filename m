Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17029
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 10:03:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1AF37I12438
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 15:03:07 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
        by jazzband.ncsc.mil  with ESMTP id h1AF32f12433 for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 15:03:06 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.4/Switch-2.2.4) with SMTP id h1AEptu15823
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 08:51:55 -0600 (CST)
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14C45@md-exchange1.na.nai.com>
From: Kelly_Djahandari@nai.com
To: selinux@tycho.nsa.gov
Subject: File labeling issue
Date: Mon, 10 Feb 2003 07:06:07 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While testing xinetd, I ran into a problem with the build of the
file_contexts file. Because file_contexts is a concatenation of files in
alphabetical order, inetd.fc can override labeling of /usr/sbin/in.*d files
if the fc file is alphabetically before inetd.fc.

The file inetd.fc has a default inetd services label. It has the line:

/usr/sbin/in\..*d               system_u:object_r:inetd_child_exec_t

As an example, the service fingerd has specific labeling in fingerd.fc. It
has the line:

/usr/sbin/in.fingerd            system_u:object_r:fingerd_exec_t

Since fingerd.fc is concatenated to file_contexts before inetd.fc, the
inetd.fc line overrides the fingerd.fc line for labeling
/usr/sbin/in.fingerd and the file is labeled inetd_child_exec_t.

The default type for files in /usr/sbin is system_u:object_r:sbin_t. If
services started by xinetd are labeled sbin_t, they are run in the inetd_t
domain--not good. Talkd is an example of a service which does not have a fc
file and would be labeled with the default inetd.fc labeling
(inetd_child_exec_t).

Is it reasonable to request that all services started by inetd have a .fc
file and a corresponding .te file and remove the default inetd labeling in
inetd.fc? Or should we keep the default inetd labeling and figure out some
other way to not overwrite specific labeling? Since this could be a problem
not just of inetd.fc, but with any wildcard usage, we may need to think of a
more general solution. 

Any suggestions/comments are appreciated.

Kelly Djahandari
Network Associates Laboratories


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
