Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j09FDeIi025332
	for <selinux@tycho.nsa.gov>; Sun, 9 Jan 2005 10:13:40 -0500 (EST)
Received: from viefep14-int.chello.at (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j09FBcki024960
	for <selinux@tycho.nsa.gov>; Sun, 9 Jan 2005 15:11:46 GMT
Received: from medeia.home.hu ([80.98.177.246]) by viefep14-int.chello.at
          (InterMail vM.6.01.03.05 201-2131-111-107-20040910) with ESMTP
          id <20050109151332.IHNK24992.viefep14-int.chello.at@medeia.home.hu>
          for <selinux@tycho.nsa.gov>; Sun, 9 Jan 2005 16:13:32 +0100
Subject: transition denied
From: Milus =?ISO-8859-1?Q?J=E1nos?= <johans@gnu.hu>
Reply-To: johans@gnu.hu
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Jan 2005 16:13:35 +0100
Message-Id: <1105283615.3146.25.camel@medeia.home.hu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello

I'm newbie in SeLinux and I have a problem. I made a jail (a chroo
environment) for a game server. My plan was it will run on
games:games_r:games_t security context in a following way:

(1) the rc script makes a chroot and calls the "su" program inside the
jail to become "games" user and change the security context from
system_u:system_r:initrc_t to system_u:games_r:games_su_t

(2) then the su calls the program itself who changes the domain from
games_su_t to games_t.

My problem is the first step. I always get the following error message:

avc: denied { transition } for pid=16335 exe=/bin/chroot path=/bin/su
dev=md2 ino=426102 scontext=system_u:system_r:initrc_t
tcontext=system_u:games_r:games_su_t tclass=process

My games.te file:
#################################
#
# Rules for the games_t domain.
#
type games_t, domain;
type games_su_t, domain, privrole, privuser, privowner, privfd;
role games_r types games_t;
role games_r types games_su_t;
type games_exec_t, file_type, exec_type;
type games_su_exec_t, file_type, exec_type;

allow system_r games_r;
role_transition system_r games_su_exec_t games_r;
domain_auto_trans(initrc_t, games_su_exec_t, games_su_t)

domain_auto_trans(games_su_t, games_exec_t, games_t)

can_network(games_t)
##########

I modified the user file:

user system_u roles { system_r games_r }

And I added the privovner and privrole attribute to initrc_t domain.
(but I'm not absolutly sure, that this is necessary)

What am I miss?

-- 
Üdv:
Jo-Hans


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
