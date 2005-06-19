Message-ID: <e8a2934d05061911222ca18f9b@mail.gmail.com>
Date: Sun, 19 Jun 2005 23:52:03 +0530
From: Preeti Malakar <preeti.malakar@gmail.com>
Reply-To: Preeti Malakar <preeti.malakar@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: SELinux not enforced, messagse while booting, please help me
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sir, 
     
        I installed Fedora Core 3 . after that i checked the
/usr/sbin/sestatus -v it showed selinux is disabled so according to
http://fedora.redhat.com/docs/selinux-faq-fc3/index.html#id2825945, i
changed the SELINUX=enforcing in the file
/etc/sysconfig/selinux . But after rebooting the system , its showing
some weird messages which are like this:
audit(1119217507.781:0):avc:denied {search} for pid=1
exe=/sbin/init.dev=tempfs ino=910 scontext=system_u:system_r:kernel_t
tcontext=system_u:object_r:tmpfs_t tclass=dir
and after sometime its static, no alteration
i m unable to understand what should i do, please help me, do i have
to reinstall fedora 3?

thanking you


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
