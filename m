Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9C38EY0019928
	for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2011 23:08:14 -0400
Received: from exprod8og107.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9C38CgA000116
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 03:08:13 GMT
Received: by vcbfk26 with SMTP id fk26so224570vcb.10
        for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2011 20:08:09 -0700 (PDT)
MIME-Version: 1.0
From: Jason Axelson <jaxelson@referentia.com>
Date: Tue, 11 Oct 2011 17:07:49 -1000
Message-ID: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
Subject: Writing a program to monitor the SELinux log
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am writing a program that will monitor the SELinux log for AVC violations
and deal with them appropriately. Currently I am looking at approaches to
monitor the SELinux log.

One approach is to do raw monitoring of /var/log/audit/audit.log with
something like:
    tail -f /var/log/audit/audit.log | ausearch -m avc

A second approach may be to implement an SETroubleShoot plugin:
https://fedorahosted.org/setroubleshoot/wiki/SETroubleShoot%20Overview

I'm kind of leaning towards an SETroubleShoot plugin since it seems like less
new development and the infrastructure seems to be already there.

Is this a valid approach? Is there a better way?

Thanks,
Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
