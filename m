Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <1123159932.13654.17.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
	 <1123159932.13654.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 12:14:11 -0400
Message-Id: <1123172051.13654.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-04 at 08:52 -0400, Stephen Smalley wrote:
> This patch modifies the assertion checking code to expand the avtabs
> prior to checking the assertions, leveraging the expand_avtab function
> that was added by the prior patch to provide compatibility support for
> writing older binary policy versions.  This appears to eliminate the
> performance penalty introduced by the earlier patches for assertion
> checking.

The above patch is also available from
http://www.cs.utah.edu/~sds/libsepol-assert.patch

I've also now converted over most users of ebitmaps in libsepol and
checkpolicy to using the new inline operators, and added a
ebitmap_for_each_bit macro to simplify the code.  Those patches are
available from http://www.cs.utah.edu/~sds/libsepol-ebitmap.patch and
http://www.cs.utah.edu/~sds/checkpolicy-ebitmap.patch.

Next step is to similarly convert the users of ebitmaps in the kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
