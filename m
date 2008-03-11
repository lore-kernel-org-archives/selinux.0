Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
	when upstart runs a shell
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, jwcart2@tycho.nsa.gov,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204916629.20251.44.camel@gorn.columbia.tresys.com>
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>
	 <1204838797.1397.378.camel@moss-spartans.epoch.ncsc.mil>
	 <47D065E2.3000702@redhat.com>
	 <1204916629.20251.44.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 08:19:46 -0400
Message-Id: <1205237986.25555.37.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-07 at 14:03 -0500, Christopher J. PeBenito wrote:
> On Thu, 2008-03-06 at 16:45 -0500, Daniel J Walsh wrote:
> > Stephen Smalley wrote:
> > > On Thu, 2008-03-06 at 16:11 -0500, James Carter wrote:
> > >> Upstart spawns a shell during boot and, without this patch, it will
> > >> transition to the sysadm_t domain, but remain in the system_r role.
> > >> Services started by that shell will fail to start, even in permissive
> > >> mode, if system_u:system_r:sysadm_someservice_t is an invalid context.
> > >> We really don't want to be starting services from the sysadm_t domain
> > >> during boot.
> > > 
> > So it should probably transition to initrc_t, so apps started this way
> > would have a chance of transitioning properly.
> 
> No, the shell will execute /etc/rc.d/rc to start processing the init
> scripts, and thats when it'll transition to initrc_t.  If we do it on
> shell execution, it may cause problems for things executed directly out
> of init, like getty.

Turns out I was wrong, and upstart has separate stanzas in the config
files (/etc/event.d/*), one for directly executing programs like getty,
and one for scripting.  As also confirmed by Joe, the transition to
initrc_t makes sense, so I went with this in the init_upstart tunable.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
