Subject: Re: avc_init & avc_open
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <7A092CE0-19C7-4686-96CF-698A69267BBA@nall.com>
References: <7A092CE0-19C7-4686-96CF-698A69267BBA@nall.com>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 09:37:35 -0400
Message-Id: <1208785055.15796.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-21 at 08:21 -0500, Joe Nall wrote:
> I have a userspace object manager that I would like to specify the log  
> callback and the enforcing mode for simultaneously. The enforcing mode  
> can be set with avc_open (no man page) and the callbacks with  
> avc_init(3). What is the best strategy?

avc_init() was the old interface.
selinux_set_callback() + avc_open() is the new interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
