Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14I8aXU026480
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 13:08:36 -0500
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14I8Amg011962
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 18:08:31 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1473918rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 04 Feb 2008 10:08:10 -0800 (PST)
Message-ID: <207608340802041008o6c9c39a7l491f013a4becd233@mail.gmail.com>
Date: Mon, 4 Feb 2008 18:08:10 +0000
From: "Eoin Ryan" <ryaneoin@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Service control via /etc/init.d/ using strict policy
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5866_24706743.1202148490081"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_5866_24706743.1202148490081
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

Apologies in advance if this is slightly off topic.  Over the last few years
I've gained some experience with SELinux using the targeted policy, but now
after discovering the new support in RHEL5 I've decided to learn about the
strict/mls policies and hopefully contribute in some way one day.

I have a test RHEL5 system running the strict policy, but I'm confused about
how services/daemons can be controlled by the superuser.  The sysadm_t does
not have permission to execute initrc_exec_t, but does have permission to
execute /usr/sbin/httpd directly as it's httpd_exec_t.  The type_transition
rules allow mainly the system startup types (init_t etc) to transition to
initrc_exec_t, but there is no transition from sysadm_t defined.  This seems
to say that services can only be started and stopped during bootup and
shutdown.

Am I missing something here, or does a transition to initrc_exec_t need to
be defined for some SELinux user via a policy module?  Sorry if my
terminology is a little off.

Kind Regards
Eoin

------=_Part_5866_24706743.1202148490081
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br><br>Apologies in advance if this is slightly off topic.&nbsp; Over the last few years I&#39;ve gained some experience with SELinux using the targeted policy, but now after discovering the new support in RHEL5 I&#39;ve decided to learn about the strict/mls policies and hopefully contribute in some way one day.<br>

<br>I have a test RHEL5 system running the strict policy, but I&#39;m confused about how services/daemons can be controlled by the superuser.&nbsp; The sysadm_t does not have permission to execute initrc_exec_t, but does have permission to execute /usr/sbin/httpd directly as it&#39;s httpd_exec_t.&nbsp; The type_transition rules allow mainly the system startup types (init_t etc) to transition to initrc_exec_t, but there is no transition from sysadm_t defined.&nbsp; This seems to say that services can only be started and stopped during bootup and shutdown.<br>
<br>Am I missing something here, or does a transition to initrc_exec_t need to be defined for some SELinux user via a policy module?&nbsp; Sorry if my terminology is a little off.<br><br>Kind Regards<br>
Eoin<br><br><br><br><br>

------=_Part_5866_24706743.1202148490081--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
