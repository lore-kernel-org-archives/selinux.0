Subject: Re: audit logging & log callback for avc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051031153235.87168.qmail@web51513.mail.yahoo.com>
References: <20051031153235.87168.qmail@web51513.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 10:52:11 -0500
Message-Id: <1130773931.22731.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 07:32 -0800, Steve G wrote:
> I have run across a problem as perhaps the only user of the log callback for
> avcs. I want to get the correct uid & loginuid of the user receiving the MAC
> denial in the message. For example, in dbus, you could get this message:
> 
> Oct 6 20:47:39 devsvr01 dbus: Can't send to audit system: USER_AVC
> pid=2426 uid=81 loginuid=-1 message=avc: denied { send_msg } for
> scontext=root:system_r:unconfined_t tcontext=user_u:system_r:initrc_t
> tclass=dbus
> 
> loginuid is unset since dbus is a daemon started by init & uid is the dbus
> daemon's uid. The log callback function signature is:
> 
> void log_callback (const char *fmt, ...);
> 
> So, either the callback needs to have the parameters passed for auid & uid or the
> message being generated needs to include this info.
> 
> Which way is the best to handle this scenario?

Inserting this kind of object manager-specific information into an audit
message is normally handled via the audit callback.  The caller (dbusd)
registers such a callback upon avc_init, and then upon avc_has_perm
calls, the caller (dbusd) passes a pointer to the supplemental data as
the void* last argument to avc_has_perm().  If an audit message needs to
be generated, the AVC then invokes the callback with a buffer to fill in
with the supplemental data.  dbusd already uses this mechanism to fill
in various auxiliary data such as service name and sender and target
pids.  The supplemental data can be anything the object managers wants,
e.g. the object manager can just pass a pointer to a struct and print to
the buffer upon callback, or it can pre-generate the string and just
copy it upon callback (the latter seems to be the approach of dbusd).

Is the auid of the sender even available to dbusd?  SCM_CREDENTIALS
provides the uid, but there isn't an augmented form that provides the
auid AFAIK.  Hence, that would be the natural starting point, and you'd
have to do it in a way that doesn't break compatibility.  Likely a topic
for linux-audit or redhat-lspp, although I thought that they planned to
disable dbusd for eval.  Once the information is available, you can then
easily extend the existing code that is generating auxdata to also
include the uid and auid.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
