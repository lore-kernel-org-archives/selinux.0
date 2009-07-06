Subject: Re: [Patch 2/2] libsemanage: create a don't audit flag
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CBC6C.5090709@redhat.com>
	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CC469.3050805@redhat.com>
	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CD320.2090706@redhat.com>
	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>
	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 09:52:06 -0400
Message-Id: <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 09:46 -0400, Stephen Smalley wrote:
> I don't believe that this is right.  semanage_get_disable_dontaudit()
> calls sepol_get_disable_dontaudit() which will always return 0 when the
> handle is first created and it cannot have been set yet since we are
> only just now creating the handle.  Then you'll pass that zero to
> semanage_set_disable_dontaudit() and always remove the flag file on
> handle creation.  Not what you want.

So I think that we don't need the libsepol patch at all anymore, nor do
we need semanage_get_disable_dontaudit().  So all we need is the change
to semanage_set_disable_dontaudit() along with the path definition in
libsemanage, and the patch to semodule in policycoreutils.  Re-post both
patches as a series with updated description and diffstat after
addressing the comments please.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
