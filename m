From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        =?utf-8?B?T25kxZllaiBWYcWhw61r?=
 <ovasik@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, James Morris
 <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: setfscreatecon-w/invalid-context can mistakenly succeed
In-Reply-To: <1208175424.18883.6.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 14 Apr 2008 08:17:04 -0400")
References: <Pine.LNX.4.44.0803271805390.3341-100000@redline.boston.redhat.com>
	<874pa5buqs.fsf@rho.meyering.net>
	<1208175424.18883.6.camel@moss-spartans.epoch.ncsc.mil>
Date: Mon, 14 Apr 2008 14:45:30 +0200
Message-ID: <87ve2k7ggl.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Sounds more like a bug in mcstrans to me - giving back an empty string
> in place of the "xxx" so that the kernel never sees the "xxx"?  Or do I
> misunderstand your description above.

I filed the bug against mcstrans:

  http://bugzilla.redhat.com/442327

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
