Subject: stripped mount point
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 20 Aug 2002 09:51:58 -0400
Message-Id: <1029851518.9543.30.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just relabeled the files on my system and now my apache processes can
not read from the doc root nor can they append to the logs.  Now I
noticed when I relabeled the fs that each mount point was done
independently whereas before it would just label everything as being
under / (eg it labeled /, then it labeled /var, then /tmp, etc., etc.).
The files are all labeled correctly but the avc messages have the mount
points stripped from the path section (eg apache isn't denied access to
/var/www/html it is denied access to /www/html).  Now I can see how this
is causing a problem the question is why is it doing this?

Timothy,

avc:  denied  { read } for  pid=1598 exe=/usr/sbin/httpd
path=/www/html/index.php dev=03:08 ino=60255
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:httpd_sys_content_t tclass=file

avc:  denied  { append } for  pid=1598 exe=/usr/sbin/httpd
path=/log/httpd/access_log dev=03:08 ino=50210
scontext=system_u:system_r:initrc_t
tcontext=system_u:object_r:httpd_log_files_t tclass=file



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
