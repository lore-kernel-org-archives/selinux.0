From: "Brian Smith" <brian@briansmith.org>
To: <SELinux@tycho.nsa.gov>
Subject: SELinux STRICT policy on CentOS 5
Date: Sat, 9 Jun 2007 14:46:27 +0700
Message-ID: <000101c7aa6a$4bfe49c0$5e01a8c0@Junk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,
 
What is the installation procedure for enabling the STRICT policy in CentOS 5 and/or RHEL 5? Everything I read seemed to indicate it was:
 
	yum install selinux-policy-strict
	[ set SELINUXTYPE=strict in /etc/selinux/config ]
	touch /.autorelabel
	reboot

However, whenever I do this I get a kernel panic on boot:

	http://bugs.centos.org/view.php?id=2002

Note that I am not the original bug reporter.

The targeted policy seems to work without any problems. I tried switching to the strict policy before doing a "yum update -y && reboot" and then after reinstalling I tried AFTER doing a "yum update -u && reboot." I tried the above procedure, but then booting with "enforcing=0." This avoided the kernel panic but I could not log in as root via the console, only via SSH. And, logging in as root via SSH resulted in many permission denied errors; root couldn't read its own bash profile, for example.

I running CentOS in VMWare Server 1.0.3.

Thanks for any assistance,
Brian



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
