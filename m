Message-ID: <40FADE92.7060307@gentoo.org>
Date: Sun, 18 Jul 2004 16:33:22 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: running interpreted scripts in different domains
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, so I had this seemingly good idea to let apache run interpreted apps 
(php, perl, whathaveyou) in different domains. To do this I started 
playing with fastcgi to do the type transition from apache to the 
interpreters domain (which works well) but that leaves all php scripts 
in the same domain (php_t) which then can't be isolated from one 
another. The idea is to have a php domain for each user (method_php_t) 
and so on. The only way I could think to do this was to use fastcgi's 
wrapper function to setexec() before calling the interpreter (it will do 
this per user). So the idea is that there is a php script of a user 
labeled with something like method_php_script_t and the fastcgi wrapper 
would read that target context and paired with it's source context ask 
selinux what the auto type trans would be so that it can explicitly do 
it with setexec().

The problem is that the userspace avc doesn't currently provide this 
information, all you can get is an access decision or a labeling or 
relabeling decision. It seems a little extreme to add a 
security_compute_trans() to the userspace avc (and selinuxfs filesystem, 
etc) just to make scripts a little more isolated and provide more fine 
grained access but I can't think of another (good) way to do this. The 
alternative would be to use default types but that isn't very scalable 
for X number of interpreters times N number of users.

Can anyone else think of a way to accomplish this or shall I try adding 
a calculate auto type trans to the userspace avc's?

Joshua Brindle
Hardened Gentoo

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
