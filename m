Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA26634
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 16:11:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07459
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 20:09:57 GMT
Received: from csoc-fire05.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzswing.ncsc.mil  with SMTP id UAA07451
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 20:09:56 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015241D5@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: policy configurations files
Date: Tue, 28 Aug 2001 15:11:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To list:

I have making many modification to my policy configurations files. 
In the process I tried to make a common set of modifications
for the domains/admin/sysadm.te and domains/user/user.te

In the parts that begin with 

define(`user_domain',`
....
allow $1_t $1_home_t:dir create_dir_perms;
....
')

of course the sysadm domain is different for the domain.

What I would like to do is


file: domains/user/user.te

define(`user_domain',`
....
sinclude(includes/user-common.inc)
....
')



file: domains/admin/sysadm.te

define(`admin_domain',`
....
sinclude(includes/user-common.inc)
....
')


file: include/user-common.inc

allow $1_t $1_home_t:dir create_dir_perms;


because the line 

allow $1_t $1_home_t:dir create_dir_perms;

is the same in both files.

When I tried this I got an error on the 
allow $1_t $1_home_t:dir create_dir_perms;
line

I guess the real question is the sinclude() processed before or after the
macro substitution 

Thanks,
Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
