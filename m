Subject: Re: USER_AVC vs USER_MAC_POLICY_LOAD ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200803260844.45708.sgrubb@redhat.com>
References: <200803260844.45708.sgrubb@redhat.com>
Content-Type: text/plain
Date: Wed, 26 Mar 2008 09:26:48 -0400
Message-Id: <1206538008.3302.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-26 at 08:44 -0400, Steve Grubb wrote:
> Hi,
> 
> Lately dbus has taken to sending this again:
> 
> localhost  dbus: Can't send to audit system: USER_AVC avc:  received 
> policyload notice (seqno=2) : exe="?" (sauid=81, hostname=?, addr=?, 
> terminal=?)
> 
> This is clearly not an AVC - which is an access control decision. This is a 
> policy load - something entirely different. The audit system wants to have 1 
> type = 1 meaning. We need to be able to differentiate information flow 
> decisions from everything else.
> 
> I will be releasing an update to the audit system this week. I can add 
> USER_MAC_POLICY_LOAD type to libaudit.h if that would help solve the problem. 
> This does beg the question, though, do we really want these events being 
> recorded? If so, I think we should use an appropriate type and not USER_AVC.

I think it is useful to record these events, as it shows that a given
userspace object manager (application) has received notification of a
new policy and is thus now enforcing that new policy.

Using a separate type makes sense to me.  I think the current use of a
single type is just a historical result of the fact that the userspace
AVC was created before we had such message typing in the kernel AVC.
But it may require a change/extension to the libselinux callback
interface - there isn't a way to convey such type information presently
I think.

However, isn't there a separate issue with regard to the above dbus
message - the "Can't send to audit system" part?  That suggests that the
unprivileged dbus is still trying to generate audit messages?  Or that
something else is going wrong when it tries to audit?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
