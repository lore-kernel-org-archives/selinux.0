From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 08/13] SELinux: Add new peer permissions to the Flask definitions
Date: Mon, 12 Nov 2007 11:34:35 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net> <20071109212433.31738.71161.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0711120926410.7114@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0711120926410.7114@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711121134.35273.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 11 November 2007 5:31:44 pm James Morris wrote:
> On Fri, 9 Nov 2007, Paul Moore wrote:
> > Add additional Flask definitions to support the new "peer" object class.
>
> Should this be dependent on dynamic class/permission support?

I think it's okay to _define_ the Flask definitions regardless of what the 
policy supports as older policies should simply ignore these definitions.

> Or, will these checks only be invoked if labled networking is configured?

Bingo!  Look at patch 7/13, specifically the 'selinux_policycap_netpeer' 
variable and then at patch 9/13 where the new access checks are made 
conditional on this variable.  The whole mess needs more testing and 
verification, but "in theory" it shouldn't cause any breakage with older 
policies ... if someone does notice something broken please scream loudly.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
