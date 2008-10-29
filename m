Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9T38RUd014291
	for <selinux@tycho.nsa.gov>; Tue, 28 Oct 2008 23:08:27 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9T38Q8h020150
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 03:08:27 GMT
Message-ID: <4907D37F.3090404@redhat.com>
Date: Wed, 29 Oct 2008 13:07:43 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: user guide: troubleshooting chapter
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am having trouble organizing a troubleshooting section. My current ideas:

Top Three Causes of Problems: <http://danwalsh.livejournal.com/22347.html>

Searching for and Viewing SELinux Denials

* which log files are used.
* ausearch, sealert, setroubleshoot-gui

Analyzing SELinux Denials

* Description of each field: comm, path, scontext, tcontext, etc.
* <http://fedoraproject.org/wiki/SELinux/Troubleshooting/AVCDecisions> 
"Troubleshooting/AVCDecisions"

Why was Access Denied?

* auditwhy.
* DAC rules.

Fixing Problems

* fedora-selinux-list, Red Hat Bugzilla, audit2allow, chcon, semanage 
fcontext, setsebool.
* Permissive Domains: <http://danwalsh.livejournal.com/24537.html>
* Booleans for Services (HTTP, Samba, FTP, MySQL, rsync).

Thanks for any ideas.

Regards.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
