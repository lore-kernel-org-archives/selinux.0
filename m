Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120070819.20484.40.camel@celtics.boston.redhat.com>
References: <200506291817.j5TIHQ7f013656@gotham.columbia.tresys.com>
	 <1120070819.20484.40.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:53:41 -0400
Message-Id: <1120071221.3553.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 14:46 -0400, Ivan Gyurdiev wrote:
> > More importantly, we have just decided to remove specific user information from
> > the policy and leaving it in the file contexts seems strange.
> 
> The file contexts serves a different purpose.
> I agree with you in that I don't like having hundreds of files there,
> but at the same time I don't see an alternative.

Polyinstantiate every user home directory ;)
Anyone following up on Chad Seller's work there?
Then you have dynamically created per-role home directories
transparently mounted on the user's home directory for whatever role the
user happens to be logged in as.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
