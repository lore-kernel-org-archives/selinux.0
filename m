Subject: Re: patched wdm (new API)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Peter Simons <simons+sel@cryp.to>, SELinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200310081505.33814.russell@coker.com.au>
References: <20031002145936.A16412@lemuria.org>
	 <87isn0a5ot.fsf@peti.cryp.to>  <200310081505.33814.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065616221.8181.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Oct 2003 08:30:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-08 at 01:05, Russell Coker wrote:
> Have you tried the PAM module that Dan wrote?  It should work for xdm as long 
> as it's PAM enabled. 

I don't think you can just use a PAM session module for [xgk]dm; the
pam_open_session call is performed from the wrong process.  But there is
a patched gdm available from Dan's site, under
ftp://people.redhat.com/dwalsh/SELinux, that will obtain and use the
user's default context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
