Date: Thu, 15 Apr 2004 00:00:07 +0200
From: Thorsten Sauter <tsauter@gmx.net>
To: SELinux Developers <SELinux@tycho.nsa.gov>
Subject: pam_selinux.so question
Message-ID: <20040414220007.GA15471@gmx.net>
Reply-To: Thorsten Sauter <tsauter@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi all,

I have installed a fresh Debian Sid system (powerpc) and compiled my own
2.6.5 (vanilla kernel) with selinux support.

All required packages for selinux are installed (simply rebuild the
debian packages).

But now, I have a mysterious behavior with the pam_selinux.so module,
which is required in /etc/pam.d/login.

If I login as root I got the normal info text:
"Your default context is root:sysadm_r:sysadm_t." [...]

But as soon as I try this as an normal user I got a new question:
"Would you like to enter a security context? [y]"

Hitting "n" will end with an "authentication failure" and logout this
user.
Using "y" and insering user_r/user_t will help, and allow the user to
login.

But why I get this "manual" question?

Tia
Thorsten

p.s. System is not in enforceing mode

<snip /etc/security/default_contexts>
system_r:local_login_t sysadm_r:sysadm_t staff_r:staff_t user_r:user_t
</snip>

<snip /etc/selinux/users>
user sar roles { user_r staff_r };
</snip>

-- 
Thorsten Sauter
<tsauter@gmx.net>

				(Is there life after /sbin/halt -p?)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
