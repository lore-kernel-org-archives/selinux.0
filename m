Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6MB2qpJ014748
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 07:02:52 -0400
Subject: Re: redis - selinux
To: =?UTF-8?Q?Kamil_Boraty=c5=84ski?= <kboratynski@linsec.pl>,
 selinux@tycho.nsa.gov
References: <C8680873-CCF4-4613-A4F0-DF34CF783389@linsec.pl>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <b6976984-2e9e-793e-a19c-dee230872d8b@redhat.com>
Date: Fri, 22 Jul 2016 07:02:31 -0400
MIME-Version: 1.0
In-Reply-To: <C8680873-CCF4-4613-A4F0-DF34CF783389@linsec.pl>
Content-Type: multipart/alternative;
 boundary="------------82E7E0E3A91A4730895A2739"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------82E7E0E3A91A4730895A2739
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please open a bugzilla for RHEL7


On 07/20/2016 05:34 PM, Kamil Boratyński wrote:
> It looks like SELinux policies block the connection betweeen Redis servers.
> It is needed for replication purposes.
>
>
> * sealert
>> root@redis-2 ~]# sealert -a /var/log/audit/audit.log
>>    3% done'list' object has no attribute 'split'
>> 103% done
>> found 1 alerts in /var/log/audit/audit.log
>> --------------------------------------------------------------------------------
>>
>> SELinux is preventing /usr/bin/redis-server from name_connect access on the tcp_socket port 6379.
>>
>> *****  Plugin catchall (100. confidence) suggests   **************************
>>
>> If you believe that redis-server should be allowed name_connect access on the port 6379 tcp_socket by default.
>> Then you should report this as a bug.
>> You can generate a local policy module to allow this access.
>> Do
>> allow this access for now by executing:
>> # grep redis-server /var/log/audit/audit.log | audit2allow -M mypol
>> # semodule -i mypol.pp
>>
>>
>> Additional Information:
>> Source Context                system_u:system_r:redis_t:s0
>> Target Context                system_u:object_r:redis_port_t:s0
>> Target Objects                port 6379 [ tcp_socket ]
>> Source                        redis-server
>> Source Path                   /usr/bin/redis-server
>> Port                          6379
>> Host                          <Unknown>
>> Source RPM Packages           redis-2.8.19-2.el7.x86_64
>> Target RPM Packages
>> Policy RPM                    selinux-policy-3.13.1-60.el7_2.7.noarch
>> Selinux Enabled               True
>> Policy Type                   targeted
>> Enforcing Mode                Enforcing
>> Host Name                     redis-2
>> Platform                      Linux redis-2 3.10.0-327.22.2.el7.x86_64 #1 SMP
>>                                Thu Jun 23 17:05:11 UTC 2016 x86_64 x86_64
>> Alert Count                   250
>> First Seen                    2016-07-20 21:14:59 UTC
>> Last Seen                     2016-07-20 21:26:05 UTC
>> Local ID                      90314588-4f75-485a-bce4-3b8b1742fe8f
>>
>> Raw Audit Messages
>> type=AVC msg=audit(1469049965.377:1214): avc:  denied  { name_connect } for  pid=5668 comm="redis-server" dest=6379 scontext=system_u:system_r:redis_t:s0 tcontext=system_u:object_r:redis_port_t:s0 tclass=tcp_socket
>>
>>
>> type=SYSCALL msg=audit(1469049965.377:1214): arch=x86_64 syscall=connect success=no exit=EACCES a0=5 a1=7f6e8c010df0 a2=10 a3=7fff1db82944 items=0 ppid=1 pid=5668 auid=4294967295 uid=995 gid=993 euid=995 suid=995 fsuid=995 egid=993 sgid=993 fsgid=993 tty=(none) ses=4294967295 comm=redis-server exe=/usr/bin/redis-server subj=system_u:system_r:redis_t:s0 key=(null)
>>
>> Hash: redis-server,redis_t,redis_port_t,tcp_socket,name_connect
>>
>> [root@redis-2 ~]#
>
>
> * sestatus
>> [root@redis-2 ~]# sestatus
>> SELinux status:                 enabled
>> SELinuxfs mount:                /sys/fs/selinux
>> SELinux root directory:         /etc/selinux
>> Loaded policy name:             targeted
>> Current mode:                   enforcing
>> Mode from config file:          enforcing
>> Policy MLS status:              enabled
>> Policy deny_unknown status:     allowed
>> Max kernel policy version:      28
>> [root@redis-2 ~]#
>> Policy Type
> * kernel-version
>> [root@redis-2 ~]# uname -a
>> Linux redis-2 3.10.0-327.22.2.el7.x86_64 #1 SMP Thu Jun 23 17:05:11 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
>> [root@redis-2 ~]#
>
> * checkpolicy version:
>> [root@redis-2 ~]# checkpolicy --version
>> 29 (compatibility range 29-15)
>> [root@redis-2 ~]#
> * libselinux-version:
>> [root@redis-2 ~]# yum info installed libselinux
>> Loaded plugins: fastestmirror
>> Installed Packages
>> Name        : libselinux
>> Arch        : x86_64
>> Version     : 2.2.2
>> Release     : 6.el7
>> Size        : 159 k
>> Repo        : installed
>>  From repo   : anaconda
>> Summary     : SELinux library and simple utilities
>> URL         : http://oss.tresys.com/git/selinux.git
>> License     : Public Domain
>> Description : Security-enhanced Linux is a feature of the Linux? kernel and a number
>>              : of utilities with enhanced security functionality designed to add
>>              : mandatory access controls to Linux.  The Security-enhanced Linux
>>              : kernel contains new architectural components originally developed to
>>              : improve the security of the Flask operating system. These
>>              : architectural components provide general support for the enforcement
>>              : of many kinds of mandatory access control policies, including those
>>              : based on the concepts of Type Enforcement?, Role-based Access
>>              : Control, and Multi-level Security.
>>              :
>>              : libselinux provides an API for SELinux applications to get and set
>>              : process and file security contexts and to obtain security policy
>>              : decisions.  Required for any applications that use the SELinux API.
>>
>> [root@redis-2 ~]#
> * libsemanage:
>> [root@redis-2 ~]# yum info installed libsemanage
>> Loaded plugins: fastestmirror
>> Installed Packages
>> Name        : libsemanage
>> Arch        : x86_64
>> Version     : 2.1.10
>> Release     : 18.el7
>> Size        : 220 k
>> Repo        : installed
>>  From repo   : anaconda
>> Summary     : SELinux binary policy manipulation library
>> URL         : http://oss.tresys.com/git/selinux.git
>> License     : LGPLv2+
>> Description : Security-enhanced Linux is a feature of the Linux? kernel and a number
>>              : of utilities with enhanced security functionality designed to add
>>              : mandatory access controls to Linux.  The Security-enhanced Linux
>>              : kernel contains new architectural components originally developed to
>>              : improve the security of the Flask operating system. These
>>              : architectural components provide general support for the enforcement
>>              : of many kinds of mandatory access control policies, including those
>>              : based on the concepts of Type Enforcement?, Role-based Access
>>              : Control, and Multi-level Security.
>>              :
>>              : libsemanage provides an API for the manipulation of SELinux binary
>>              : policies. It is used by checkpolicy (the policy compiler) and similar
>>              : tools, as well as by programs like load_policy that need to perform
>>              : specific transformations on binary policies such as customizing policy
>>              : boolean settings.
>>
>> [root@redis-2 ~]#
> * policy:
>> [root@redis-2 ~]# grep redis-server /var/log/audit/audit.log | audit2allow
>> #============= redis_t ==============
>> allow redis_t redis_port_t:tcp_socket name_connect;
>> [root@redis-2 ~]#
> In case of any further questions, feel free to ask me.
> I think it would be nice to have a boolean value for this.
>
> — K.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------82E7E0E3A91A4730895A2739
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Please open a bugzilla for RHEL7<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 07/20/2016 05:34 PM, Kamil
      Boratyński wrote:<br>
    </div>
    <blockquote
      cite="mid:C8680873-CCF4-4613-A4F0-DF34CF783389@linsec.pl"
      type="cite">
      <pre wrap="">It looks like SELinux policies block the connection betweeen Redis servers.
It is needed for replication purposes.


* sealert
</pre>
      <blockquote type="cite">
        <pre wrap="">root@redis-2 ~]# sealert -a /var/log/audit/audit.log
  3% done'list' object has no attribute 'split'
103% done
found 1 alerts in /var/log/audit/audit.log
--------------------------------------------------------------------------------

SELinux is preventing /usr/bin/redis-server from name_connect access on the tcp_socket port 6379.

*****  Plugin catchall (100. confidence) suggests   **************************

If you believe that redis-server should be allowed name_connect access on the port 6379 tcp_socket by default.
Then you should report this as a bug.
You can generate a local policy module to allow this access.
Do
allow this access for now by executing:
# grep redis-server /var/log/audit/audit.log | audit2allow -M mypol
# semodule -i mypol.pp


Additional Information:
Source Context                system_u:system_r:redis_t:s0
Target Context                system_u:object_r:redis_port_t:s0
Target Objects                port 6379 [ tcp_socket ]
Source                        redis-server
Source Path                   /usr/bin/redis-server
Port                          6379
Host                          &lt;Unknown&gt;
Source RPM Packages           redis-2.8.19-2.el7.x86_64
Target RPM Packages
Policy RPM                    selinux-policy-3.13.1-60.el7_2.7.noarch
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Enforcing
Host Name                     redis-2
Platform                      Linux redis-2 3.10.0-327.22.2.el7.x86_64 #1 SMP
                              Thu Jun 23 17:05:11 UTC 2016 x86_64 x86_64
Alert Count                   250
First Seen                    2016-07-20 21:14:59 UTC
Last Seen                     2016-07-20 21:26:05 UTC
Local ID                      90314588-4f75-485a-bce4-3b8b1742fe8f

Raw Audit Messages
type=AVC msg=audit(1469049965.377:1214): avc:  denied  { name_connect } for  pid=5668 comm="redis-server" dest=6379 scontext=system_u:system_r:redis_t:s0 tcontext=system_u:object_r:redis_port_t:s0 tclass=tcp_socket


type=SYSCALL msg=audit(1469049965.377:1214): arch=x86_64 syscall=connect success=no exit=EACCES a0=5 a1=7f6e8c010df0 a2=10 a3=7fff1db82944 items=0 ppid=1 pid=5668 auid=4294967295 uid=995 gid=993 euid=995 suid=995 fsuid=995 egid=993 sgid=993 fsgid=993 tty=(none) ses=4294967295 comm=redis-server exe=/usr/bin/redis-server subj=system_u:system_r:redis_t:s0 key=(null)

Hash: redis-server,redis_t,redis_port_t,tcp_socket,name_connect

[root@redis-2 ~]#
</pre>
      </blockquote>
      <pre wrap="">


* sestatus
</pre>
      <blockquote type="cite">
        <pre wrap="">[root@redis-2 ~]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      28
[root@redis-2 ~]#
Policy Type
</pre>
      </blockquote>
      <pre wrap="">
* kernel-version
</pre>
      <blockquote type="cite">
        <pre wrap="">[root@redis-2 ~]# uname -a
Linux redis-2 3.10.0-327.22.2.el7.x86_64 #1 SMP Thu Jun 23 17:05:11 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
[root@redis-2 ~]#
</pre>
      </blockquote>
      <pre wrap="">

* checkpolicy version:
</pre>
      <blockquote type="cite">
        <pre wrap="">[root@redis-2 ~]# checkpolicy --version
29 (compatibility range 29-15)
[root@redis-2 ~]#
</pre>
      </blockquote>
      <pre wrap="">
* libselinux-version:
</pre>
      <blockquote type="cite">
        <pre wrap="">[root@redis-2 ~]# yum info installed libselinux
Loaded plugins: fastestmirror
Installed Packages
Name        : libselinux
Arch        : x86_64
Version     : 2.2.2
Release     : 6.el7
Size        : 159 k
Repo        : installed
>From repo   : anaconda
Summary     : SELinux library and simple utilities
URL         : <a class="moz-txt-link-freetext" href="http://oss.tresys.com/git/selinux.git">http://oss.tresys.com/git/selinux.git</a>
License     : Public Domain
Description : Security-enhanced Linux is a feature of the Linux? kernel and a number
            : of utilities with enhanced security functionality designed to add
            : mandatory access controls to Linux.  The Security-enhanced Linux
            : kernel contains new architectural components originally developed to
            : improve the security of the Flask operating system. These
            : architectural components provide general support for the enforcement
            : of many kinds of mandatory access control policies, including those
            : based on the concepts of Type Enforcement?, Role-based Access
            : Control, and Multi-level Security.
            :
            : libselinux provides an API for SELinux applications to get and set
            : process and file security contexts and to obtain security policy
            : decisions.  Required for any applications that use the SELinux API.

[root@redis-2 ~]#
</pre>
      </blockquote>
      <pre wrap="">
* libsemanage:
</pre>
      <blockquote type="cite">
        <pre wrap="">[root@redis-2 ~]# yum info installed libsemanage
Loaded plugins: fastestmirror
Installed Packages
Name        : libsemanage
Arch        : x86_64
Version     : 2.1.10
Release     : 18.el7
Size        : 220 k
Repo        : installed
>From repo   : anaconda
Summary     : SELinux binary policy manipulation library
URL         : <a class="moz-txt-link-freetext" href="http://oss.tresys.com/git/selinux.git">http://oss.tresys.com/git/selinux.git</a>
License     : LGPLv2+
Description : Security-enhanced Linux is a feature of the Linux? kernel and a number
            : of utilities with enhanced security functionality designed to add
            : mandatory access controls to Linux.  The Security-enhanced Linux
            : kernel contains new architectural components originally developed to
            : improve the security of the Flask operating system. These
            : architectural components provide general support for the enforcement
            : of many kinds of mandatory access control policies, including those
            : based on the concepts of Type Enforcement?, Role-based Access
            : Control, and Multi-level Security.
            :
            : libsemanage provides an API for the manipulation of SELinux binary
            : policies. It is used by checkpolicy (the policy compiler) and similar
            : tools, as well as by programs like load_policy that need to perform
            : specific transformations on binary policies such as customizing policy
            : boolean settings.

[root@redis-2 ~]#
</pre>
      </blockquote>
      <pre wrap="">
* policy:
</pre>
      <blockquote type="cite">
        <pre wrap="">[root@redis-2 ~]# grep redis-server /var/log/audit/audit.log | audit2allow
#============= redis_t ==============
allow redis_t redis_port_t:tcp_socket name_connect;
[root@redis-2 ~]#
</pre>
      </blockquote>
      <pre wrap="">
In case of any further questions, feel free to ask me.
I think it would be nice to have a boolean value for this.

— K.

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------82E7E0E3A91A4730895A2739--
