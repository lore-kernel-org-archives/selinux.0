Date: Wed, 12 Dec 2001 17:45:00 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: Undefined refs in compile attempt
Message-ID: <20011212174500.GB26201@vnl.com>
References: <20011212014335.GA16538@vnl.com> <Pine.GSO.4.33.0112120840590.6865-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0112120840590.6865-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 12, 2001 at 08:54:46AM -0500, Stephen Smalley wrote:

> These errors indicate that you enabled the MLS option without making the
> other changes described in the README.MLS file.  See the help text for
> this option and the README.MLS file for more information.  As noted there,
> the MLS policy component is considered experimental and has not been
> configured for use.  Unless you really want to experiment with it, I
> wouldn't recommend it.  Our focus has been on the RBAC and TE policies.
> Of course, you can even express a MLS policy as a TE configuration if you
> want, although the state space explodes if you have a lot of MLS levels.
> 

Thanks. James Morris got me past the first hurdle, but 
perhaps I will go back and drop the MLS option entirely
for now.

Also, have you included the Andrew Morton patches in your
newer release? If you are having odd compile failures
on Debian systems particularly with USB enabled, it's 
either that or downgrade binutils to an older less
strict one (or enable HOTPLUG for no other reason than
that it stops the bad bit of code from being left
hanging).

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
