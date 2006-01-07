Subject: selinux/PostgreSQL problems with RHEL 4.2
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1136592010.17167.58.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Fri, 06 Jan 2006 18:00:10 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've got a new RHEL4.2 install and I wanted to do something I thought
would be simple based on prior experience on non-selinux boxes. I wanted
to change the default data directory used by PostgreSQL. Normally it
uses /var/lib/pgsql. I want it to use /drive2/pgsql. I created the new
directory, set the permissions on it the same as the original directory,
added a one line /etc/sysconfig/pgsql/postgresql file with a PGDATA
directive pointing to the new directory. I started the PostgreSQL
service for the first time which should initialize everything. It failed
and dumped this string of cryptic selinux errors to the message log:

Jan  6 17:18:07 z2 kernel: audit(1136589487.378:9): avc:  denied  {
search } for  pid=20130 comm="ls" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:07 z2 kernel: audit(1136589487.379:10): avc:  denied  {
search } for  pid=19969 comm="initdb" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:07 z2 kernel: audit(1136589487.380:11): avc:  denied  {
search } for  pid=20131 comm="mkdir" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:07 z2 kernel: audit(1136589487.381:12): avc:  denied  {
getattr } for  pid=20131 comm="mkdir" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:07 z2 kernel: audit(1136589487.382:13): avc:  denied  {
search } for  pid=20132 comm="mkdir" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:07 z2 kernel: audit(1136589487.382:14): avc:  denied  {
search } for  pid=20132 comm="mkdir" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:07 z2 kernel: audit(1136589487.418:15): avc:  denied  {
search } for  pid=20155 comm="postmaster" name="/" dev=sdb1 ino=2
scontext=root:system_r:postgresql_t tcontext=system_u:object_r:file_t
tclass=dir
Jan  6 17:18:09 z2 postgresql: Starting postgresql service:  failed

I still haven't quite been able to wrap my head around what this selinux
thing is supposed to do aside from preventing me from getting anything
done :)  but I was hoping someone here could interpret the above string
of errors and tell me if there's any reasonable hope that I can do what
I originally wanted to do. Thanks...

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
