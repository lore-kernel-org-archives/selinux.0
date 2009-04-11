Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3BF2kHf008781
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 11:02:46 -0400
Received: from mu-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3BF2j3u011096
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 15:02:46 GMT
Received: by mu-out-0910.google.com with SMTP id w1so462014mue.4
        for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 08:02:44 -0700 (PDT)
Message-Id: <F7970D6F-6958-4157-9CD0-2818202619AD@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: strange semanage user|login errors
Date: Sat, 11 Apr 2009 17:02:43 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

i want to change cateogories which i have enabled with "semanage user - 
a -r 's0-s0:c0.c100' user_u" of user_u - but i can't:
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
========================================================================

[root@SecLab home]# semanage user -m -r 's0-s0:c0.c1023' user_u
libsemanage.validate_handler: MLS range s0 for Unix user user exceeds  
allowed range s0:c0.c100 for SELinux user user_u (No such file or  
directory).
libsemanage.validate_handler: seuser mapping [user -> (user_u, s0)] is  
invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No  
such file or directory).
/usr/sbin/semanage: Could not commit semanage transaction


I also can't remove login of user and user2:
============================================

1 [root@SecLab home]# semanage login -d -s user_u user
2 libsemanage.validate_handler: MLS range s0 for Unix user user2  
exceeds allowed range s0:c0.c100 for SELinux user user_u (No such file  
or directory).
3 libsemanage.validate_handler: seuser mapping [user2 -> (user_u, s0)]  
is invalid (No such file or directory).
4 libsemanage.dbase_llist_iterate: could not iterate over records (No  
such file or directory).
5 /usr/sbin/semanage: Could not commit semanage transaction

1 [root@SecLab home]# semanage login -d -s user_u user2
2 libsemanage.validate_handler: MLS range s0 for Unix user user  
exceeds allowed range s0:c0.c100 for SELinux user user_u (No such file  
or directory).
3 libsemanage.validate_handler: seuser mapping [user -> (user_u, s0)]  
is invalid (No such file or directory).
4 libsemanage.dbase_llist_iterate: could not iterate over records (No  
such file or directory).
5 /usr/sbin/semanage: Could not commit semanage transaction


Interesting here is seuser mapping part (see line 3) . When i try to  
delete user semanage says that mapping user_2_ is invalid and when i  
try to delete user_2_ semanage says that mapping user is invalid.


Even when i try to modify range of staff_u i get this error:
============================================================

[root@SecLab home]# semanage user -m -r 's0-s0:c0.c300' staff_u
libsemanage.validate_handler: MLS range s0 for Unix user user exceeds  
allowed range s0:c0.c100 for SELinux user user_u (No such file or  
directory).
libsemanage.validate_handler: seuser mapping [user -> (user_u, s0)] is  
invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No  
such file or directory).
/usr/sbin/semanage: Could not commit semanage transaction


I have tried many combinations of semanage {login|user} with "nearly"  
all possible combinations of options, but i always get these error(s).  
i have problems to interprete the error message adequately.  
Espesically the part "(No such file or directory)" isn't clear to me.  
The linux users user and user2 are already removed with userdel -r  
user and userdel -r user2.


Maybe i should mention that it isn't possible to add a new linux user  
which is associated with user_u:
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
= 
========================================================================

[root@SecLab home]# useradd -Z user_u user3
libsemanage.validate_handler: MLS range s0 for Unix user user exceeds  
allowed range s0:c0.c100 for SELinux user user_u (No such file or  
directory).
libsemanage.validate_handler: seuser mapping [user -> (user_u, s0)] is  
invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No  
such file or directory).
/usr/sbin/semanage: Could not commit semanage transaction
useradd: warning: the user name user3 to user_u SELinux user mapping  
failed.


Last but not least here my (chaotic) login/user mappings:
=========================================================

[root@SecLab home]# semanage user -l

                 Labeling   MLS/       MLS/
SELinux User    Prefix     MCS Level  MCS Range                       
SELinux Roles

guest_u         user       s0         s0                              
guest_r
root            user       s0         s0-s0:c0.c1023                  
staff_r sysadm_r system_r unconfined_r
staff_u         user       s0         s0-s0:c0.c200                   
staff_r sysadm_r system_r unconfined_r
sysadm_u        user       s0         s0-s0:c0.c1023                  
sysadm_r
system_u        user       s0         s0-s0:c0.c1023                  
system_r
testuser        user       s0         s0                              
staff_r unconfined_r
testuser2       user       s0         s0                              
staff_r
testuser3_u     user       s0         s0                              
staff_r
unconfined_u    user       s0         s0-s0:c0.c1023                  
system_r webadm_r unconfined_r
user_u          user       s0         s0:c0.c100                      
user_r
xguest_u        user       s0         s0                              
xguest_r

[root@SecLab home]# semanage login -l

Login Name                SELinux User              MLS/MCS Range

__default__               unconfined_u              s0
hello                     staff_u                   s0
root                      unconfined_u              s0-s0:c0.c1023
system_u                  system_u                  s0-s0:c0.c1023
testuser                  staff_u                   s0
testuser2                 testuser2                 s0
testuser3                 testuser3_u               s0
user                      user_u                    s0
user2                     user_u                    s0


BTW: i use F10. If you need further information, please let me know.

Happy Easter.

--
Sebastian Pfaff


PS: I also can't add another selinux user:
     ======================================

[root@SecLab home]# semanage user -a -R 'staff_r' foo_u
libsemanage.validate_handler: MLS range s0 for Unix user user exceeds  
allowed range s0:c0.c100 for SELinux user user_u (No such file or  
directory).
libsemanage.validate_handler: seuser mapping [user -> (user_u, s0)] is  
invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No  
such file or directory).
/usr/sbin/semanage: Could not commit semanage transaction



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
