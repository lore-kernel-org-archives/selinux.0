Subject: default_contexts question
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 22 Sep 2003 19:38:57 +0200
Message-Id: <1064252337.2137.30.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

/bin/login runs as system_u:boot_r:boot_d
my /etc/security/default_contexts contains the following line:

boot_r:boot_d	tcb_user_r:tcb_user_d tcb_secadm_r:tcb_secadm_d\
tcb_sysadm_r:tcb-sysadm_d

login says to me that "unable to obtain context for mag."
When I enter the context tcb_user_r:tcb_user_d by hand,
it lets me in, and no deny comes from the kernel.

Question:
What do I do wrong in defining the starting context for users?

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
