Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1119558539.16753.74.camel@celtics.boston.redhat.com>
References: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
	 <1119558539.16753.74.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 08:08:26 -0400
Message-Id: <1119614906.12865.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:28 -0400, Ivan Gyurdiev wrote:
>Karl MacMillan wrote:
> > Not certain, therefore, that libsepol is the correct place for the
> > client api (e.g. the one used by useradd). Thoughts?
> 
> It's difficult to me to write forward portable code, when I don't
> know the future :)

True.  But we can at least seek to provide an interface to useradd from
libsepol that doesn't expose the fact that we are necessarily dealing
with a binary policy file/image, just an abstract policy object that may
be backed by a binary policy or may be backed by the policy daemon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
