Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3ECvhD2008650
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 08:57:43 -0400
Received: from hades.sngx.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3ECwaaU002919
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 12:58:36 GMT
To: Selinux <selinux@tycho.nsa.gov>
Subject: Re: sudo + selinux
MIME-Version: 1.0
Date: Tue, 13 Apr 2010 06:00:43 -0500
From: James Cammarata <jimi@sngx.net>
Reply-To: jimi@sngx.net
In-Reply-To: <4BC5B6AC.1040101@redhat.com>
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com>
Message-ID: <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 14 Apr 2010 08:35:56 -0400, Daniel J Walsh <dwalsh@redhat.com>
wrote:
> sudo in RHEL6 and F11 and beyond added newrole type functionality to
> sudo.  This package will not be back ported to RHEL5.  (Sorry).
> One option would be to add newrole to a shell script executed by sudo.
> 
> sudo audit.sh
> 
> cat audit.sh
> newrole -r auditadm_r -t auditadm_t COMMAND
> 
> Then add pam_rootok to /etc/pam.d/newrole

That's a bit of a bummer.  I had seen your discussions with the sudo devs
that was about a year or more old, so I was hoping this had found its way
into RHEL already.  I'll test this workaround today and see if it does what
I want.

Thanks!

James C.

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
