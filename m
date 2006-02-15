Message-ID: <43F39797.1050602@trustedcs.com>
Date: Wed, 15 Feb 2006 15:05:27 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] collect security labels on user processes	generating
 audit messages
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>	<1139530450.12638.7.camel@localhost>	<1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil> <1139960902.326.5.camel@localhost>
In-Reply-To: <1139960902.326.5.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Timothy R. Chavez wrote:
> James & Stephen,
> 
> Thank you for the comments.  While implementing your feedback I came
> across a pretty severe bug.  I was basically obtaining the sid and then
> throwing it away (I was returning it from the function, but not actually
> assigning it to anything).  New patch below.  I still need to test this
> a little more.  Thanks!
> 
> -tim

Should you really be using an lsm interface for getting the sid?  The
patch is currently allowing any security module to put a secid (whose
comment says SELinux security id) into the netlink_skb_params struct.
This generic item is then only used in SELinux specific calls.  It
seems that the getsecid functionality could just fit into an SELinux
specific API just like selinux_id_to_ctx and friends.  That would also
avoid the overhead of lsm and all of the associated code changes.  Of
course this is probably moot if there are other planned uses for
security_task_getsecid().

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
