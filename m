Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1105571319.11828.19.camel@cobra.ivg2.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1105571319.11828.19.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1105632619.24406.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 11:10:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:08, Ivan Gyurdiev wrote:
> What about a tool that creates a hybrid type on demand, and stores that
> information in the policy?
> 
> createcon samba_httpd_content_t --inherit 
> 	samba_share_t httpd_sys_content_t
> chcon -R samba_httpd_content_t ~/webserver

That would certainly be feasible.  libsepol provides an interface for
direct manipulation of binary policies, so you can build tools on it
that directly perform any kind of transformation, and it is already used
for boolean customization (init, load_policy) and regenerating the user
database (genpolusers) without requiring full policy sources.  The
experimental binary policy modules work by Tresys is another step in
this direction, you might want to experiment with it (which would also
help it to mature and get it mainstreamed sooner).

However, something to note is that if tools begin to directly manage the
TE portion of the binary policy (vs. easily separable elements like
booleans and users where we can maintain local config files that
override the base settings in the shipped binary policy), then we have
to have some way to deal with merging/conflicts when policy updates
occur from a source rebuild.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
