Subject: Re: setfiles vs getfilecon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@debian.org>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1077100334.5360.12.camel@kusturica>
References: <1077100334.5360.12.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077109296.17849.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 08:01:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-18 at 05:32, Magosányi Árpád wrote:
> It seems there is some inconsistency in computing the label of a
> symlink between setfiles and [sg]etfilecon.

setfiles uses lgetfilecon(3) and lsetfilecon(3).  [sg]etfilecon use
getfilecon(3) and setfilecon(3).  We should likely add a -h option to
setfilecon and getfilecon to indicate that they should use
lsetfilecon(3) and lgetfilecon(3), as with setfattr and getfattr.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
