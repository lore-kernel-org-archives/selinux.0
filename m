Date: Tue, 22 Jul 2003 13:37:46 +0200 (MEST)
From: coUnt3r@gmx.net
To: "Kerry Thompson" <kerry@crypt.gen.nz>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
References: <2785.202.27.185.71.1058845191.squirrel@www.crypt.gen.nz>
Subject: Re: hidden files and se linux?
Message-ID: <7061.1058873866@www9.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi kerry, hi maillist,

> Of course, an intruder could infer that something was there from the
> permission denied message, but nobody - not even the system admin - can
> get into that directory without 

ok, that's not a true invisibility, but rather a workaround ;)

thx for your detailed hint!
regards
t.


> Tobias said:
> > hello!
> >
> > is it possible to hide files under selinux?
> > i don't mean to prohibit the acces, i mean to make
> > some files absolute invisible for the entire system.
> 
> No problem.
> Just create a new type with minimal permissions, and label the files with
> this type. I just tried it on my test box :
> 
> # cat <<! >domains/misc/hidden.te
> # Basic type for completely hidden files
> type hidden_t;
> allow sysadm_t hidden_t:file { relabelto };
> allow sysadm_t hidden_t:dir { relabelto };
> allow hidden_t fs_t:filesystem { associate };
> !
> 
> Now, run 'make load' to load that small addition to the policy, then label
> some files :
> 
> # mkdir /var/tmp/hidden
> # touch /var/tmp/hidden/hiddenfile
> # chcon system_u:object_r:hidden_t /var/tmp/hidden/hiddenfile
> # chcon system_u:object_r:hidden_t /var/tmp/hidden
> 
> .. and now test :
> 
> # ls -l /var/tmp/hidden
> ls: /var/tmp/hidden: Permission denied
> # ls -l /var/tmp/hidden/*
> ls: /var/tmp/hidden/*: Permission denied
> # ls -l /var/tmp
> ls: /var/tmp/hidden: Permission denied
> 
> Of course, an intruder could infer that something was there from the
> permission denied message, but nobody - not even the system admin - can
> get into that directory without either changing the policy to allow access
> or dropping ther system into permissive mode. In reality, you'll probably
> want to add some rules to the policy to give a small amount of access to
> someone.
> 
> Kerry
> 
> 
> -- 
> Kerry Thompson, CCNA CISSP
> Information Systems Security Consultant
> http://www.crypt.gen.nz  kerry@crypt.gen.nz
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++

Jetzt ein- oder umsteigen und USB-Speicheruhr als Prämie sichern!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
