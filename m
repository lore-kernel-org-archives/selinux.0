Content-Type: text/plain;
  charset="us-ascii"
From: Brian Fegler <fegler@bigfoot.com>
Reply-To: fegler@bigfoot.com
To: SELinux@tycho.nsa.gov
Subject: kde rules
Date: Fri, 18 Oct 2002 16:42:34 -0600
MIME-Version: 1.0
Message-Id: <200210181642.34552.fegler@bigfoot.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am working on locking down kde. I would like to have a rule set that would 
not allow any user initiated kde related processes to write or read from the 
user's directory. 

Some exceptions would be:
kde_kmail_t => full permissions on user_mailbox_t 
any kde domain => full permissions on user_kmailconfig_t ( ~/.kde(|.*) )


Where things get a bit tricky is with dcop and iceauth - kde interprocess 
communication protocols. 

xauth, dcop*, iceauth and kdeinit all write, read, create and delete from the 
home directory extensively. 

I had wanted to have different types for .qt*, .DCOP*, .Xauthority, ..., .... 

The problem with this is depending on what order programs are called (kmail, 
then konqueror, or konsole, konqueror then kmail for example) effects what 
programs attempt to create the different kde and x related files. 

I had wanted a user_(iceauth|dcop|mcop|xauth|qt)_t type, but managing what 
domains (iceauth_t, dcop_t, kdeinit_t, xauth_t, kde_t, ...) could access what 
types became a little crazy. It wasn't real clean. 

So, I was wondering if anyone had worked on this. 

It seems to me that it might be a good idea to create a user_kde_ipc_t type. 
This would include the files .DCOP*, .ICEAuthority* .mcop* and .qt/* among 
others. While .qt/* wouldn't truly be ipc files, the name kind or sort of 
fits...

How gnome would fit in I'm not sure. I'm not familiar enough with gnome 
protocols to know how or if these new types would effect it. (gnome rule 
writers, input would be great). 

I'd like these rules to work "out of the box", if you will. When root adds a 
new user, with out any sub directories created, I'd like new users to fire up 
kde and have it all work, without having to create directories and then 
running chcon on them.


In summary, my domains include
kde_t
kde_kmail_t
kdeinit_t
iceauth_t
dcop_t
xauth_t
(working on kde_konqueror_t)


I think the types should include
user_kdeconfig_t
	user_kmailconfig_t
user_kde_ipc_t
user_mailbox_t
kde_socket_t (in /tmp/)
kde_tmp_t (in /tmp/ )


Another nifty type for users might be a "user_fullaccess_t". If users had 
files (documents for example), that they didn't really care what domain did 
what with, they could just label them with that domain. Maybe have a 
user_fullaccess_t directory, with type_transitions for labeling items going 
into it as need be. 


Any suggestions or requests would be great. I think the estimated time to 
completion will be about another week or so. I'll be throwing some files up 
onto the list for further input at that time, hopefully.

Brian Fegler

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
