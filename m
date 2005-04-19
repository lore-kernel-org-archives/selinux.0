Message-ID: <426468C8.1080102@tyrannical.org>
Date: Mon, 18 Apr 2005 22:11:20 -0400
From: Jason <jason@tyrannical.org>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Problems with SElinux and MySQL accessing file on /tmp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am having an error with selinux that I can't seem to fix.

 avc: denied { getattr } for pid=123 exe=/usr/libexec/mysqld

 I get that when I try to use a mysql query "load data concurrent infile 
'/tmp/filename' etc"

allow mysqld_t tmp_t:dir { getattr }; doesn't help. I need a way to give 
mysql  getattr globally, or at least in the tmp folder.  in 
filecontexts, /tmp/.* is listed as <<none>>

the file it's accessing in /tmp is user_u:object_r:tmp_t

audit2allow doesn't display anything since it's a denied { getattr } 
without any other info.

Does anyone have an idea what can be done?

TIA,

Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
