Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7D7Cxmk024835
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 03:12:59 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7D7Cjt8006831
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 07:12:45 GMT
Message-ID: <37933.145.64.134.222.1218611576.squirrel@www.hardeman.nu>
In-Reply-To: <660E036C-3778-4D06-B32F-26CFC8D36603@redhat.com>
References: <C1DF76B68C82E64590F9448D012FB21884F567@exchange.afccc.mil>
    <660E036C-3778-4D06-B32F-26CFC8D36603@redhat.com>
Date: Wed, 13 Aug 2008 09:12:56 +0200 (CEST)
Subject: Re: Nagios and RHEL 5
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: "Gunnar Hellekson" <gunnar.hellekson@redhat.com>
Cc: "Cooper David Ctr 14WS/P3I" <david.cooper.ctr@afccc.af.mil>,
        selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, August 12, 2008 20:34, Gunnar Hellekson wrote:
>> type=AVC msg=audit(1218215558.890:3854): avc:  denied  { read write }
>> for  pid=1403 comm="ping"
>> path="/usr/local/nagios/var/spool/checkresults/checkcDARIP" dev=dm-0
>> ino=394381 scontext=user_u:system_r:ping_t:s0
>> tcontext=user_u:object_r:usr_t:s0 tclass=file type=SYSCALL
>> msg=audit(1218215558.890:3854): arch=40000003 syscall=11 success=yes
>> exit=0 a0=932fa70 a1=932fb08 a2=bf99b804 a3=932fb08 items=0 ppid=1402
>> pid=1403 auid=502 uid=501 gid=501 euid=0 suid=0 fsuid=0 egid=501
>> sgid=501 fsgid=501 tty=(none) ses=86 comm="ping" exe="/bin/ping"
>> subj=user_u:system_r:ping_t:s0 key=(null)
...
> I'm not smart enough to give you the exact policy change required, but
> I do know that cmd.cgi writes to the nagios.cmd fifo to push commands
> onto the Nagios server queue. This is exactly the kind of thing you
> don't want a CGI doing, usually, so you'll likely have to alter the
> standard CGI policies to allow this. This is required only if you want
> to use the web interface to manipulate the server.

Since nagios is installed in a different location than usual (/usr/local
rather than /usr), the file contexts will not be applied correctly to the
nagios files.

Either use standard paths or add local file contexts which match the ones
from the nagios policy
(http://oss.tresys.com/projects/refpolicy/browser/trunk/policy/modules/services/nagios.fc)
but with the /usr/local prefix and then relabel everything under
/usr/local/nagios.

The nagios policy should already have the necessary magic to allow it to
run ping.

-- 
David Härdeman


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
