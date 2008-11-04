Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA44HsiO022603
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2008 23:17:54 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA44HnAJ005270
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2008 04:17:54 GMT
Message-ID: <490FCCC7.2010708@redhat.com>
Date: Tue, 04 Nov 2008 14:17:11 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: user guide drafts: "What Happens when Access is Denied" and "Top
 Three Causes of Problems"
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

These are drafts for the Troubleshooting chapter. I have left out uses 
for audit2allow which could be included, as audit2allow will be covered 
in a later section.

I have not really had to fix SELinux problems before, so please pardon 
my ignorance :(

Cheers.

Troubleshooting

[introduction when sections are complete]

What Happens when Access is Denied

SELinux decisions, such as allowing or disallowing access, are cached. 
This cache is known as the Access Vector Cache (AVC). Denial messages 
are logged when SELinux denies access. These denials are also know as 
"AVC denials", and are logged to a different location, depending on 
which daemons are running:

[table from previous section showing where logs are written to depending 
on which daemons are running]

If you are running the X Window System, have the setroubleshoot and 
setroubleshoot-server packages installed, and the setroubleshootd daemon 
running, a yellow star and a warning are displayed when access is denied 
by SELinux:

[screenshot]

Clicking on the star presents a detailed analysis of why SELinux denied 
access, and a possible solution for allowing access. If you are not 
running the X Window System, it is less obvious when access is denied by 
SELinux. For example, users browing your website may receive an error 
similar to the following:

Forbidden

You don't have permission to access file name on this server

For these situations, if DAC rules (standard Linux permissions) allow 
access, check /var/log/messages and /var/log/audit/audit.log for SELinux 
is preventing and avc: denied errors respectively. This can be done by 
running the following commands as the Linux root user:

grep "SELinux is preventing" /var/log/messages

grep "avc: denied" /var/log/audit/audit.log

Top Three Causes of Problems
# taken from <http://danwalsh.livejournal.com/22347.html>

[introduction when sections are complete]

Labeling Problems

On systems running SELinux, all processes and files are labeled with a 
label that contains security-relevant information. This information is 
called the SELinux context. If these labels are wrong, access may be 
denied. If an application is labeled incorrectly, the process it 
transitions to may not have the correct label, possibly causing SELinux 
to deny access, and the process being able to create mislabeled files.

A common cause of labeling problems is when a non-standard directory is 
used for a service. For example, instead of using /var/www/html/ for a 
website, an administrator wants to use /srv/myweb/. On Fedora 10, the 
/srv/ directory is labeled with the var_t type. Files and directories 
created and /srv/ inherit this type. Also, newly-created top-level 
directories (such as /myserver) may be labeled with the default_t type. 
SELinux prevents the Apache HTTP Server (httpd) from accessing both of 
these types. To allow access, SELinux must know that the files in 
/srv/myweb/ are to be accessible to httpd:

# /usr/sbin/semanage fcontext -a -t httpd_sys_content_t \
"/srv/myweb(/.*)?"

This semanage command adds the context for the /srv/myweb/ directory 
(and all files and directories under it) to the SELinux file-context 
configuration[1]. The semanage command does not change the context. As 
the Linux root user, run the restorecon command to apply the changes:

# /sbin/restorecon -R -v /srv/myweb

Refer to Section 5.7.2, “Persistent Changes: semanage fcontext” for 
further information about adding contexts to the file-context 
configuration.

What is the Correct Context?

[cut down example from previous section on using matchpathcon]

Booleans for Confined Services

Booleans allow parts of SELinux policy to be changed at runtime, without 
any knowledge of SELinux policy writing. This allows changes, such as 
allowing services access to NFS file systems, without reloading or 
recompiling SELinux policy. Services can be run in a variety of ways. To 
cater for this, you must tell SELinux how you are running services. For 
example, to allow the Apache HTTP Server to communicate with MySQL, turn 
the httpd_can_network_connect_db Boolean on:

# /usr/sbin/setsebool -P httpd_can_network_connect_db on

If access is denied for a particular service, use the getsebool and grep 
commands to see if any Booleans are available to allow access. For 
example, use the getsebool -a | grep ftp command to search for FTP 
related Booleans:

[example output from "getsebool -a | grep ftp"]

For a list of Booleans and whether they are on or off, run the 
/usr/sbin/getsebool -a command. For a list of Booleans, an explanation 
of what each one is, and whether it is on or off, as the Linux root 
user, run the /usr/sbin/semanage boolean -l command. Refer to Section 
5.6, “Booleans” for information about listing and configuring Booleans.

[1] Files in /etc/selinux/targeted/contexts/files/ define contexts for 
files and directories. Files in this directory are read by restorecon 
and setfiles to restore files and directories to their default contexts.

Evolving Rules and Broken Applications

Applications may be broken, causing SELinux to deny access. Also, 
SELinux rules are evolving - SELinux may not have seen an application 
running in a certain way, possibly causing it to deny access, even 
though the application is working as expected. For example, if a new 
version of PostgreSQL is released, it may perform actions that the 
current policy has not seen before, causing access to be denied, even 
though access should be allowed.

For these situations, after access is denied, use audit2allow to create 
a custom policy module to allow access. The following example searches 
for postgresql entries in audit.log, and sends those entries through 
audit2allow to create a custom module:

# grep postgresql /var/log/audit/audit.log | audit2allow \
-R -M mypostgresql

To install the module, run the semodule -i command as the Linux root user:

# /usr/sbin/semodule -i mypostgresql.pp

The audit2allow command may allow more access than desired. When access 
is denied, it is best to report the denial in Red Hat Bugzilla, (against 
the selinux-policy package), or to a mailing list, such as 
fedora-selinux-list, allowing a more strict rule to be added, or to add 
your changes to the distribution's or upstream policy.

# The next section is "Searching For and Viewing Denials", which will 
give examples for ausearch, sealert, and setroubleshoot... The section 
after that will deal with analyzing avc messages.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
