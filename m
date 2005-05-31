Date: Tue, 31 May 2005 22:10:27 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux@tycho.nsa.gov,
   dwalsh@redhat.com
Subject: Re: file_type_auto_trans is not sufficient
Message-ID: <20050531211027.GD11815@lkcl.net>
References: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com> <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com> <1117559223.28924.202.camel@moss-spartans.epoch.ncsc.mil> <1117561043.4455.1.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117561043.4455.1.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 31, 2005 at 01:37:23PM -0400, Ivan Gyurdiev wrote:
> 
> > Problem is that they both want to create directly in /tmp.  It would be
> > preferable if they had a dedicated subtree, e.g. /tmp/gconfd
> > and /tmp/orbit, with all per-user subdirectories underneath, so that the
> > top-level directory could be typed separately and set up a priori (at
> > boot if truly under /tmp, as they might otherwise have been deleted).
> 
> So you're saying that the directories should be created ahead of time by
> a startup script, and restorecon executed on them... something 
> like tmpskel? Maybe that can be used for libICE, which I want to
> label /tmp/.ICE-unix as ice_tmp_t.
 
 there is a whole slew of legacy applications that assume
 access to /tmp/.ICE-unix, /tmp/.X11-unix etc.

 it's a known problem for which the solution - creating tmp
 subdirectories - has been "scheduled" / "shelved".

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
