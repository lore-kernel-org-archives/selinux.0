Subject: Re: Label Translation on Fedora 9
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Warner <warner@rubix.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <490EE548.60400@rubix.com>
References: <490EE548.60400@rubix.com>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 08:29:38 -0500
Message-Id: <1225718978.3609.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-11-03 at 12:49 +0100, Andy Warner wrote:
> I am running Fedora 9 with the MLS policy and see no evidence that the
> label translation is enabled. I am using the default setrans.conf and
> the "disable=1" flag is commented out.
> 
> Using the selinux_trans_to_raw (e.g., with a SystemHigh level)
> produces the exact same label string as passed in which will not pass
> validation (using s15:c0.c1023 will pass validation). 
> 
> Trying id-Z followed by newrole produces:
> id -Z
> warner_u:secadm_r:secadm_t:s0-s15:c0.c1023
> 
> newrole -l SystemLow-SystemHigh
> warner_u:secadm_r:secadm_t:SystemLow-SystemHigh is not a valid context
> 
> Is there something that must be done to activate label translation?

Label translation is provided by a daemon, mcstrans.

yum install mcstrans
/sbin/chkconfig mcstrans on
/sbin/service mcstrans start

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
