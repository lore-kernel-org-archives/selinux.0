Date: Tue, 4 Mar 2008 17:39:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
Cc: Chris Wright <chrisw@sous-sol.org>, sds@tycho.nsa.gov, jmorris@namei.org,
        casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
Message-ID: <20080305013954.GH4416@sequoia.sous-sol.org>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov> <20080304232608.GD4416@sequoia.sous-sol.org> <1204672026.14520.133.camel@moss-terrapins.epoch.ncsc.mil> <20080304235225.GE4416@sequoia.sous-sol.org> <1204673709.14520.141.camel@moss-terrapins.epoch.ncsc.mil> <20080305001013.GF4416@sequoia.sous-sol.org> <1204675140.14520.145.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204675140.14520.145.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Dave Quigley (dpquigl@tycho.nsa.gov) wrote:
> I'm not sure if its a question of better helpers. The code is pretty
> simple.

Yeah, not complextiy issue, just proper layering.

> I think the question is who should be calling fsnotify. 

The VFS ;-)  Shouldn't be too tough to make a simple helper that's used
from SELinux as well as VFS during setxattr.  This keeps things like
locking rules and fsnotify calls in one place.

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
