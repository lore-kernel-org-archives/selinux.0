Message-ID: <4ADF4301.30705@kutulu.org>
Date: Wed, 21 Oct 2009 13:21:05 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Laganowski <eric@laganowski.net>, selinux@tycho.nsa.gov
Subject: Re: 'make policy' issues
References: <4ADF2358.4050606@laganowski.net>	 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>	 <4ADF2663.2030105@laganowski.net>	 <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>	 <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>	 <4ADF3D2C.2030408@laganowski.net> <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 21 2009, Stephen Smalley wrote:

> My impression is that one of the patches carried by the distributions
> for flex is needed for checkpolicy to work, but no one has ever fully
> investigated the precise dependency - people just grab the Fedora srpm
> and apply those patches to flex, and then rebuild checkpolicy and it
> works.  I haven't seen any complaints from Debian or Gentoo so I presume
> that they also carry the same patches for flex.

Just for reference, Gentoo only has the gcc44 one in portage (plus two 
others that seem unrelated), and it build the refpolicy fine here.

--Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
