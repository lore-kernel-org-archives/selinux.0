Subject: RE: Fix for segfault on duplicate role transitions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>, russell@coker.com.au
In-Reply-To: <200509261807.j8QI79Ys022306@gotham.columbia.tresys.com>
References: <200509261807.j8QI79Ys022306@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 15:25:14 -0400
Message-Id: <1127762714.19016.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-26 at 14:07 -0400, Karl MacMillan wrote:
> > Attached is a patch to fix a segfault on defining duplicate role
> > transitions. It also fixes an off-by-one error in the duplicate
> > range_transition code path. Russell Coker reported the bug.
> > 
> > The patch is against CVS as of Friday evening - sourceforge anonymous cvs
> > seems to be having issues and I can't update.
> > 
> > Karl
> > 
> 
> Sorry - the previous patch was old and incorrect. Correct patch attached.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
