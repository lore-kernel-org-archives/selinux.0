Subject: Re: avc_init & avc_open
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <75F5689B-C03A-4840-A560-B77AF2DCBDFB@nall.com>
References: <7A092CE0-19C7-4686-96CF-698A69267BBA@nall.com>
	 <1208785055.15796.40.camel@moss-spartans.epoch.ncsc.mil>
	 <75F5689B-C03A-4840-A560-B77AF2DCBDFB@nall.com>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 12:04:10 -0400
Message-Id: <1208793850.15796.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-21 at 10:47 -0500, Joe Nall wrote:
> On Apr 21, 2008, at 8:37 AM, Stephen Smalley wrote:
> 
> >
> > On Mon, 2008-04-21 at 08:21 -0500, Joe Nall wrote:
> >> I have a userspace object manager that I would like to specify the  
> >> log
> >> callback and the enforcing mode for simultaneously. The enforcing  
> >> mode
> >> can be set with avc_open (no man page) and the callbacks with
> >> avc_init(3). What is the best strategy?
> >
> > avc_init() was the old interface.
> > selinux_set_callback() + avc_open() is the new interface.
> 
> Do you know what rawhide rpm SELABEL_CB_LOG and friends might be in?  
> They are not in <selinux/selinux.h> or in /usr/include on a current  
> rawhide with libselinux-devel.

Looks like the man page is wrong - it is SELINUX_CB_LOG, not SELABEL_

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
