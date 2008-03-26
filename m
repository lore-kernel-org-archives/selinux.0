From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: USER_AVC vs USER_MAC_POLICY_LOAD ?
Date: Wed, 26 Mar 2008 10:05:30 -0400
Cc: selinux@tycho.nsa.gov
References: <200803260844.45708.sgrubb@redhat.com> <1206538008.3302.317.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206538008.3302.317.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803261005.30598.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 March 2008 09:26:48 Stephen Smalley wrote:
> Using a separate type makes sense to me. 

OK, in the next audit release, there will be a new type:

#define AUDIT_USER_MAC_POLICY_LOAD  2310


> But it may require a change/extension to the libselinux callback
> interface - there isn't a way to convey such type information presently
> I think.

Hmm...I haven't checked lately either.


> However, isn't there a separate issue with regard to the above dbus
> message - the "Can't send to audit system" part?

Right, I thought about altering the message so we didn't go down that 
path.  :)

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
