Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBRE72Ii017581
	for <selinux@tycho.nsa.gov>; Mon, 27 Dec 2004 09:07:02 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBRE5ETv029754
	for <selinux@tycho.nsa.gov>; Mon, 27 Dec 2004 14:05:14 GMT
Subject: Re: [PATCH] Updated & fixed patch for Linux-PAM 0.78
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1103824445.27286.31.camel@localhost.localdomain>
References: <1103824445.27286.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1104156067.15615.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 27 Dec 2004 09:01:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-23 at 12:54, Lorenzo Hernández García-Hierro wrote:
> Hi,
> 
> I've fixed the old patch for Linux-PAM to make it applying to the latest
> code version (0.78) from kernel.org.
> 
> A few fixes on pam_unix module were applied because of code lacks and
> source changes during the development by upstreams.
> 
> I haven't tested it further but it should work out the box.

As with the coreutils patch, please compare with what is in the Fedora
CVS tree, as it is already updated for pam 0.78 (but again, it is
relative to other patches in the Fedora package, and thus may not apply
cleanly to the base tarball).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
