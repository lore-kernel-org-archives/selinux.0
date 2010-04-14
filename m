Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3FIYfpH014245
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2010 14:34:41 -0400
Received: from hades.sngx.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3FIZZaX028392
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2010 18:35:35 GMT
To: jimi@sngx.net
Subject: Re: sudo + selinux
MIME-Version: 1.0
Date: Wed, 14 Apr 2010 11:37:39 -0500
From: James Cammarata <jimi@sngx.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Selinux <selinux@tycho.nsa.gov>
Reply-To: jimi@sngx.net
In-Reply-To: <6ca2b6d9d71e1b8e0b6f4b2656d924c2@sngx.net>
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com> <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net> <4BC5D183.20403@redhat.com> <3acfd6eb614d7ebec2d3c10d98940708@sngx.net> <4BC5F226.5090006@redhat.com> <34f60e632890202669f67e9498c0fa9e@sngx.net> <4BC7511F.90100@redhat.com> <6ca2b6d9d71e1b8e0b6f4b2656d924c2@sngx.net>
Message-ID: <43c51087c230c590d8eadc3b58fbbc07@sngx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 14 Apr 2010 11:16:56 -0500, James Cammarata <jimi@sngx.net> wrote:
>>> 
>> Does this work in permissive mode?
> 
> Actually, no, it doesn't, but I think I found the problem.  I was
assuming
> all I needed at the end of newrole was --, but the man page says to use
"--
> -c", which does seem to be working now.  Turning enforcing back on:
> 
> [test@kvm001 ~]$ sudo /usr/bin/audit.sh echo "hi there"
> Password:
> hi there
> 
> So, that seems to be good, but it's still asking for the password for the
> selinux user.  Is pam_rootok not doing what it's supposed to?

Something else weird... I added a shebang line to the top of the audit.sh
script, and now when I run it I don't get prompted for a password, but it
fails with this message:

[test@kvm001 ~]$ sudo /usr/bin/audit.sh echo hi
Could not determine enforcing mode.

Once again, there are no AVC's in the audit.log.  I did have to add this to
my custom policy though:

allow staff_sudo_t newrole_exec_t:file { execute execute_no_trans };


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
