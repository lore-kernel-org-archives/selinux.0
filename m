Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Samarth Sharma" <samarth7880@rediffmail.com>, SELinux@tycho.nsa.gov
Subject: Re:
Date: Sun, 10 Mar 2002 17:48:44 +0100
References: <20020310093940.30150.qmail@mailFA9.rediffmail.com>
In-Reply-To: <20020310093940.30150.qmail@mailFA9.rediffmail.com>
MIME-Version: 1.0
Message-Id: <20020310164844.6FCAD3CDEA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 10 Mar 2002 10:39, Samarth  Sharma wrote:
> 1.On login i get the following message :
>   [ avc: denied {write} for pid=647 exe=/bin/login
>   path=/var/log/wtmp dev=03:07 ino=182350
>   scontext=system_u:system_r:local_login_t
>   tcontext=system_u:object_r:cron_log_t tclass=file ]
> what does this mean and how can i get around it.
>   i get similar messages while loading 'atd'.

wtmp is in the cron_log_t domain not the correct domain of 
system_u:object_r:wtmp_t (see file_contexts for the correct context of each 
file).

I guess that you had cron rename the old wtmp to wtmp.1 and then create a new 
wtmp file, the new file gets a domain based on the domain that cron is 
running in and the domain of the parent directory.

One way of solving this would be to have an executable which has no purpose 
other than to rotate the wtmp file (could be a wrapper for logrotate) with 
the SE Linux setup to have an automatic domain transition for that program 
into a domain that defaults to wtmp_t for the file type.

> 2.Can u give me a specific example where SElinux is able to solve
> a security flaw in normal Linux

A buggy sshd can allow root logins without a root password which have full 
administrator rights.  You can setup SE Linux to forbid sshd from changing 
domain to sysadm_t and it will limit the damage from a buggy sshd.

BIND does not have full functionality unless it can bind to ports <1024 at 
will.  One solution to this is Authbind (to run BIND as non-root and allow 
access to low ports, another is to have SE Linux rules to limit the damage it 
can do.  BIND is one of those programs that has such a long history of being 
buggy that no-one will ever trust it...

I have a binary-only program from Alcatel to download the firmware to my USB 
ADSL modem.  I don't trust Alcatel regarding security (do a web search on 
them for a laugh).  So I want to limit what this program can do, but it needs 
to be root to access USB (although GRSecurity and a chroot() environment 
would be another suitable solution).

> 4.how do u add a user to the system. i added a new user in the
> ../policy/users file with appropriate context and compiled the
> policy but security context for that user was not initialized.

Did you load the policy as well as compile it?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
