Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9C22xRZ030601
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2008 22:02:59 -0400
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9C22wNX022360
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 02:02:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Murray McAllister <mmcallis@redhat.com>
Subject: Re: user guide drafts: Maintaining SELinux Labels
Date: Sun, 12 Oct 2008 12:02:49 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <737og9$5vh3i@dmzms99902.na.baesystems.com> <200810112217.15754.russell@coker.com.au> <48F13A4D.3040706@redhat.com>
In-Reply-To: <48F13A4D.3040706@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810121302.51080.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 12 October 2008 10:44, Murray McAllister <mmcallis@redhat.com> 
wrote:
> > object_r is for future support and also to give a regular format of the
> > context for all operations.  Note that files under /proc that relate to
> > processes have different roles.
>
> I could only find the system_r and object_r roles in /proc/. Are there
> any others? /proc/pid/* seem to only use system_r (I did not check
> everything).

Run in a "strict" configuration and you will see staff_r, user_r, and 
sysadm_r, with MLS you will see secadm_r.

> How about:
>
> object_r is a generic role for used most files.

All filesystem objects on persistent storage or network filesystems.

> Under the /proc/ 
> directory, files relating to processes may use the system_r role.

Or the other four roles I listed, and maybe others with customised policy.

Back in 2002 I had machines running with 16 roles and I had the policy working 
well for creating arbitrary roles with minimal effort.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
