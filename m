Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j53COvgA029852
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 08:24:57 -0400 (EDT)
Received: from web33206.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j53CIAhg023913
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 12:18:10 GMT
Message-ID: <20050603121834.73852.qmail@web33206.mail.mud.yahoo.com>
Date: Fri, 3 Jun 2005 05:18:34 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Labeling confusion with apt-get/dpkg
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chalk this up to inexperience, but I am confused, I think.
I used apt-get to install tcsh on my system. 'dpkg' was updated with the
sel-aware version. I then checked the labels and found conflicting data:

root@flattop:/usr/bin# cd /bin
root@flattop:/bin# ls -lZ bash
-rwxr-xr-x  root     root     system_u:object_r:shell_exec_t   bash
root@flattop:/bin# ls -lZ tcsh
-rwxr-xr-x  root     root     system_u:object_r:bin_t          tcsh
root@flattop:/bin# 

I look in /etc/selinux/strict/contexts/files/file_contexts:

    158 #
    159 # /bin
    160 #
    161 /bin(/.*)?                      system_u:object_r:bin_t
    162 /bin/tcsh               --      system_u:object_r:shell_exec_t
    163 /bin/bash               --      system_u:object_r:shell_exec_t
    164 /bin/bash2              --      system_u:object_r:shell_exec_t

bash's label came from line 163 (during a relabel op). While, it appears, that
tcsh's label is from 161 (updated by dpkg). But why not a match with 162?

Who reads and interprets the file_contexts file? It doesn't appear to be
conditional.



Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"


		
__________________________________ 
Discover Yahoo! 
Have fun online with music videos, cool games, IM and more. Check it out! 
http://discover.yahoo.com/online.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
