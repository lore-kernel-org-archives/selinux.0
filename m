Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3TE1jd0005182
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 10:01:45 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3TE1j4Y020295
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 14:01:45 GMT
Message-ID: <4DBAC4C8.5050909@tresys.com>
Date: Fri, 29 Apr 2011 10:01:44 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Is there difference betweek sefiles and restorecon in terms of
 labels
References: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
In-Reply-To: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/27/11 18:59, Sam Gandhi wrote:
> Looking at man pages of sefiles and restorecon , both mention that
> they initialize security context database ( extended attributes) on
> one or more filesystems.
> 
> There are certainly differences between command line arguments, but
> can these programs be used interchangeably as far as extended
> attributes they assign to files?

They both use the system's file context specification from the policy
and should set the same file context on any given path (if not, its a
bug).  The only difference between the two is their command line
arguments.  Setfiles, and correspondingly its command line arguments, is
primarily for initializing a filesystem's labels.  Restorecon is
oriented towards resetting the label on a file or a directory tree.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
