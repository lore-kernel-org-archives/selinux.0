Subject: Re: port numbers for sctp support?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <480E3F8F.3070502@redhat.com>
References: <20080422182103.GJ7449@angus.ind.WPI.EDU>
	 <480E3ABF.2020109@redhat.com> <20080422192552.GM7449@angus.ind.WPI.EDU>
	 <480E3F8F.3070502@redhat.com>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 16:02:52 -0400
Message-Id: <1208894572.15796.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-22 at 15:42 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Chuck Anderson wrote:
> > On Tue, Apr 22, 2008 at 03:21:35PM -0400, Daniel J Walsh wrote:
> >> TCP Port 22 is labeled ssh_port_t.
> > 
> > For TCP, yes.  I need SCTP, a different IP protocol.
> > 
> > --
> > fedora-selinux-list mailing list
> > fedora-selinux-list@redhat.com
> > https://www.redhat.com/mailman/listinfo/fedora-selinux-list
> 
> I have no idea if this is handled  SCTP  Are you seeing AVC messages?

Should show up as name_bind checks on port_t:rawip_socket, as per:
http://marc.info/?l=fedora-selinux-list&m=112806295900352&w=2

Policy toolchain doesn't presently allow specification of port contexts
for anything other than udp or tcp, although I think the kernel side
would support it just fine.  So we'd need to update libsepol/libsemanage
first, then adjust seobject.py to recognize "sctp".  Along with
checkpolicy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
