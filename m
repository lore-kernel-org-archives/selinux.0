Subject: pam_selinux and selinuxfs questions
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 18 Feb 2004 21:10:48 +0100
Message-Id: <1077135048.6667.29.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I feel like asking dumb questions. Let's pretend that I am now
contributing the easier half of the FAQ:)

1.
Now I am here:
secadm@szoketto-TCB:~$ getcon
kernel_u:boot_r:tcb_ssh_d

I would like to put pam_selinux to /etc/pam.d/ssh, and get here:
secadm@szoketto-TCB:~$ getcon
secadm:tcb_user_r:tcb_user_d

The pam config part seems to be okay, I am struggling with the
selinux config part. What kind of transitions, etc should I allow?

2. What do each file does in /selinux? What is the security implication
of read and write acces to them?
access
context
create
enforce
load
policyvers
relabel
user

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
