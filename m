Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA5K6IfQ031775
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 15:06:18 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA5K6Hfx029874
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 20:06:17 GMT
Message-ID: <4911FCA8.8040602@redhat.com>
Date: Wed, 05 Nov 2008 15:06:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: Re: user guide drafts: "Searching for and Viewing Denials" and "Analyzing
 Denials"
References: <49114299.4070400@redhat.com>
In-Reply-To: <49114299.4070400@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murray McAllister wrote:
> Hi,
> 
> The following are drafts for the "Searching for and Viewing Denials" and
> "Analyzing Denials" sections:
> 
> Searching For and Viewing Denials
> 
> This section assumes the setroubleshoot, setroubleshoot-server, and
> audit packages are installed, and that the auditd, rsyslogd, and
> setroubleshootd daemons are running. Refer to Section 5.2, “Which Log
> File is Used” for information about starting these daemons. A number of
> tools are available for searching for and viewing SELinux denials, such
> as ausearch, aureport, and sealert.
> 
> ausearch
> 
> The audit package provides ausearch. From the ausearch(8) manual page:
> "ausearch is a tool that can query the audit daemon logs based for
> events based on different search criteria"[1]. The ausearch tool
> accesses /var/log/audit/audit.log, and as such, must be run as the Linux
> root user:
> 
> <table>
> all denials    /sbin/ausearch -m avc
> denials for that today    /sbin/ausearch -m avc -ts today
> denials from the last 10 minutes    /sbin/ausearch -m avc -ts recent
> </table>
> 
> To search for SELinux denials for a particular service, use the -c
> comm-name option, where comm-name "is the executable’s name"[2], for
> example, httpd for the Apache HTTP Server, and smbd for Samba:
> 
> /sbin/ausearch -m avc -c httpd
> 
> /sbin/ausearch -m avc -c smbd
> 
> Refer to the ausearch(8) manual page for further ausearch options.
> 
> [1] From the ausearch(8) manual page, as shipped with the audit package
> in Fedora 10.
> 
> [2] From the ausearch(8) manual page, as shipped with the audit package
> in Fedora 10.
> 
> aureport
> 
> The audit package provides aureport. From the aureport(8) manual page:
> "aureport is a tool that produces summary reports of the audit system
> logs"[3]. The aureport tool accesses /var/log/audit/audit.log, and as
> such, must be run as the Linux root user. To view a list of SELinux
> denials and how often each one occurred, run the aureport -a command.
> The following is example output that includes two denials:
> 
> [example output]
> 
> [3] From the aureport(8) manual page, as shipped with the audit package
> in Fedora 10.
> 
> sealert
> 
> The setroubleshoot-server package provides sealert, which reads denial
> messages translated by setroubleshoot-server. Denials are assigned IDs,
> as seen in /var/log/messages. The following is an example denial from
> messages:
> 
> setroubleshoot: SELinux is preventing httpd (httpd_t) "getattr" to
> /var/www/html/file1 (samba_share_t). For complete SELinux messages. run
> sealert -l 84e0b04d-d0ad-4347-8317-22e74f6cd020
> 
> In this example, the denial ID is 84e0b04d-d0ad-4347-8317-22e74f6cd020.
> The -l option takes an ID as an argument. Running the sealert -l
> 84e0b04d-d0ad-4347-8317-22e74f6cd020 command presents a detailed
> analysis of why SELinux denied access, and a possible solution for
> allowing access.
> 
> If you are running the X Window System, have the setroubleshoot and
> setroubleshoot-server packages installed, and the setroubleshootd daemon
> running, a yellow star and a warning are displayed when access is denied
> by SELinux. Clicking on the star launches the sealert GUI, and displays
> denials in HTML output:
> 
> [sealert GUI screenshot]
> 
> * Run the sealert -b command to launch the sealert GUI.
> * Run the sealert -l \* command to view a detailed anaylsis of all denials.
> * As the Linux root user, run the sealert -a /var/log/audit/audit.log -H
>> audit.html command to create a HTML version of the sealert analysis,
> as seen with the sealert GUI.
> 
> Analyzing Denials
> 
> [fill in introduction when sections are complete]
> 
> Raw Audit Messages
> 
> Raw audit messages are logged to /var/log/audit/audit.log. The following
> is an example AVC denial that occurred when the Apache HTTP Server
> (running in the httpd_t domain) attempted to access the
> /var/www/html/file1 file (labeled with the samba_share_t type):
> 
> type=AVC msg=audit(1225875185.864:96): avc:  denied  { getattr } for
> pid=2608 comm="httpd" path="/var/www/html/file1" dev=dm-0 ino=284916
> scontext=unconfined_u:system_r:httpd_t:s0
> tcontext=unconfined_u:object_r:samba_share_t:s0 tclass=file
> 
> { getattr }: The item in braces indicates the permission that was
> denied. getattr is used before opening a file. This action is denied due
getattr indicates the source process was trying to read the target files
  status information,  processes usually check files status before reading.
> to the file being accessed having the wrong label. Commonly seen
> permissions include getattr, read, and write.
> 
> comm="httpd": The file that launched the process. In this case, the
> /usr/sbin/httpd file launched the Apache HTTP Server.
> 
> path="/var/www/html/file1": The path to the object (target) that the
> process or user attempted to access.
> 
> scontext="unconfined_u:system_r:httpd_t:s0": The SELinux context of the
> process or user that attempted the denied action. In this case, it is
I would remove "or user"
> the SELinux context of the Apache HTTP Server, which is running in the
> httpd_t domain.
> 
> tcontext="unconfined_u:object_r:samba_share_t:s0": The SELinux context
> of the object (target) that the process or user attempted to access. In
Remove "or user"
> this case, it is the SELinux context of file1. Note: the samba_share_t
> type is not accessible to processes running in the httpd_t domain.
> 
> In certain situations, the tcontext may match the scontext, such as when
> a Linux user is confined and SELinux policy prevents them from
> performing an action, for example, running a setuid application.
> 
This happens when a process tries to execute a system service that will
change characteristics of the running process, such as changing the uid
or chaning limits, or calling the fork system service.  SELinux also
generates this type of access violation when a process tries to use a
DAC Capability such as reading files that you do not have read access
to, or binding to a network port less then 1024.

All process access

        fork
        transition
        sigchld # commonly granted from child to parent
        sigkill # cannot be caught or ignored
        sigstop # cannot be caught or ignored
        signull # for kill(pid, 0)
        signal  # all other signals
        ptrace
        getsched
        setsched
        getsession
        getpgid
        setpgid
        getcap
        setcap
        share
        getattr
        setexec
        setfscreate
        noatsecure
        siginh
        setrlimit
        rlimitinh
        dyntransition
        setcurrent
        execmem
        execstack
        execheap
        setkeycreate
        setsockcreate


list of capabilities

 chown dac_override dac_read_search fowner fsetid kill setgid setuid
setpcap linux_immutable net_bind_service net_broadcast net_admin net_raw
ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct
sys_admin sys_boot sys_nice sys_resource sys_time sys_tty_config mknod
lease audit_write audit_control setfcap

> An incorrect file type is a common cause for SELinux denying access. To
> start troubleshooting, compare the source context (scontext) with the
> target context (tcontext). Should the process or user (scontext) be
> accessing such an object (tcontext)? For example, the Apache HTTP Server
> (httpd_t) should only be accessing types specified in the
> httpd_selinux(8) manual page, such as httpd_sys_content_t,
> public_content_t, and so on, unless configured otherwise.
> 
> sealert Messages
> 
> Denials are assigned IDs, as seen in /var/log/messages. The following is
> an example AVC denial (logged to messages) that occurred when the Apache
> HTTP Server (running in the httpd_t domain) attempted to access the
> /var/www/html/file1 file (labeled with the samba_share_t type):
> 
> hostname setroubleshoot: SELinux is preventing httpd (httpd_t) "getattr"
> to /var/www/html/file1 (samba_share_t). For complete SELinux messages.
> run sealert -l 84e0b04d-d0ad-4347-8317-22e74f6cd020
> 
> As suggested, run the sealert -l 84e0b04d-d0ad-4347-8317-22e74f6cd020
> command to view the complete message. This presents the same information
> from the sealert GUI:
> 
People don't understand that this command will only work on the local
machine, not sure if we need to say this.
> [example output]
> 
> Summary: A brief summary of the denied action. This is the same as the
> denial in /var/log/messages. In this example, the httpd process was
> denied access to a file (file1) labeled with the samba_share_t type.
> 
> Detailed Description: A more verbose description. In this example, file1
> is labeled with the samba_share_t. This type is used for files and
> directories that you want to export via Samba. The description suggests
> changing the type to a type that can be accessed by the Apache HTTP
> Server and Samba, if such access is desired.
> 
> Allowing Access: A suggestion for how to allow access. This may be
> relabeling files, turning a Boolean on, or making a local policy module.
> In this case, the suggestion is to label the file with a type accessable
> to both the Apache HTTP Server and Samba.
> 
> Fix Command: A suggested command to allow access and resolve the denial.
> In this example, it gives the command to change the file1 type to
> public_content_t, which is accessable to the Apache HTTP Server and Samba.
> 
> Additional Information: Information that is useful in bug reports, such
> as the policy package name and version (selinux-policy-3.5.13-11.fc10),
> but may not help towards solving why the denial occurred.
> 
> Raw Audit Messages: The raw audit messages from /var/log/audit/audit.log
> that are associated with the denial. Refer to Section 7.4.1, “Raw Audit
> Messages” for information about each item in the AVC denial.
> 
> The next sections will look at why access was denied (audit2why, dac
> rules, etc), and then fixing problems.
> 
> Regards.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkR/KgACgkQrlYvE4MpobO5IwCeK8cI8oEhzpjHGt55T4VIOx7b
i1gAoKqrvli632J2brWAzMFHDg07WEa1
=+UUq
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
