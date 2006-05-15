Subject: cvs repository at sourceforge (Was: Re: policycoreuitls patch)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4465E732.4080607@redhat.com>
References: <4465E732.4080607@redhat.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 10:00:21 -0400
Message-Id: <1147701621.14426.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-05-13 at 10:03 -0400, Daniel J Walsh wrote:
> More translations,
> 
> Change audit2allow to generate role XYZ_R typesABC_T; when discoving 
> invalid_sids.
> 
> This patch might overlap with your current stuff, but I can't get an 
> update from sourceforge.  Seems to have old stuff out there.

Per http://sourceforge.net/docs/A04/ :
"As of 2006-05-12 at 11:30 Pacific, the replacement CVS infrastructure
has been enabled for use. Do note that there are a number of changes,
including the hostname used for repository access. Also, of note is that
the last sync between the current developer CVS repository and the
previous CVS infrastructure will have been from days prior to the CVS
outage on the 9th. We recommend that users check out a copy of their new
repository, copy the files in their working copy on top of the newly
checked out repository, and then check those changes in. Due to the disk
failure on the primary CVS server, we didn't want to risk moving any
possible data corruption to the new hosts given the previous CVS
server's hardware problems. Refer to the site documentation for details
(https://www.sf.net/docs/E04). Please report any problems you see
immediately by submitting a Support Request."

In other words, sourceforge cvs has switched hostnames
(=>selinux.cvs.sourceforge.net), requiring a new checkout, and even
worse, has regressed to an older snapshot of the tree.

I'd recommend just switching to using the subversion repository, and
re-base your patch against it (as it does indeed duplicate your prior
patch).

svn co https://svn.sourceforge.net/svnroot/selinux 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
