Subject: RE: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C82ED@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C82ED@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 08:33:27 -0500
Message-Id: <1165325607.15979.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-12-04 at 16:19 -0500, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > To allow the policy file to be analyzed without external reference.
> > 
> 
> Second time analysis was mentioned and still wrong (IMO). You can't
> analyze unknown permissions since the kernel which the kernel is
> inserted into also decides whether the permissions are checked.

It is true that there is a dependency on the kernel, but there is a
difference between being able to make statements based on the (kernel,
policy) pair about what is enforced and being able to make statements
based on (kernel, policy, selinuxfs setting) about what is enforced.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
