Date: Fri, 12 Apr 2002 11:45:05 -0700 (PDT)
From: Sung Kim <hunkim@cse.ucsc.edu>
To: SELinux@tycho.nsa.gov
Subject: How can I change the rols?
Message-ID: <Pine.GSO.4.44.0204121134280.9478-100000@sundance.cse.ucsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I have several questions:

1. Can I change users' role without editing ploicy/users file?
   Is there any command such as chgrole or something?

2. I specified root as sysadm_r, but it doesn't work.

$id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) context=system_u:system_r:user_t sid=208

But I specified user in the policy/users file :

user root roles { user_r sysadm_r system_r};
user hunkim roles { user_r sysadm_r system_r};

3. What is system_u and system_r?

4. How many role in selinux? system_r, user_r, sysadm_r, object_r?
Can I make or specify a new role?

5. Is http_port_t (or *_t) kind of a role?

Please excuse my basic questions. :-)

--
Sung Kim <hunkim@cse.ucsc.edu>
http://www.cse.ucsc.edu/~hunkim

 "Dreams become reality!"


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
