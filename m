Subject: Re: [PATCH 6/7] libselinux: labeling support (try 4)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1182350581.15064.98.camel@moss-spartans.epoch.ncsc.mil>
References: <467320D6.5040703@tycho.nsa.gov>  <4673243E.30304@tycho.nsa.gov>
	 <1182350581.15064.98.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 11:13:56 -0400
Message-Id: <1182352436.15064.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-20 at 10:43 -0400, Stephen Smalley wrote:
> On Fri, 2007-06-15 at 19:43 -0400, Eamon Walsh wrote:
> > This patch rebases the matchpathcon code to use the new interface.
> 
> matchpathcon() is supposed to internally call matchpathcon_init if it
> hasn't already been called, and this behavior is relied upon by some
> programs including restorecon.  So I'll have to at least modify your
> matchpathcon() to call matchpathcon_init if !hnd.  You'll see similar
> logic in the original matchpathcon_common() function before your patch.

Like so, on top of your patch:

diff -u libselinux/src/matchpathcon.c libselinux/src/matchpathcon.c
--- libselinux/src/matchpathcon.c	(working copy)
+++ libselinux/src/matchpathcon.c	(working copy)
@@ -312,8 +312,8 @@
 
 int matchpathcon(const char *name, mode_t mode, security_context_t * con)
 {
-	if (!mycanoncon)
-		mycanoncon = default_canoncon;
+	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
+			return -1;
 
 	return notrans ?
 		selabel_lookup_raw(hnd, con, name, mode) :

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
