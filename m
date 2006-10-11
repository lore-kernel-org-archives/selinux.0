Subject: Re: security_compute_av
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F2943B992BBD6E030CCB84DAF140@phx.gbl>
References: <BAY114-F2943B992BBD6E030CCB84DAF140@phx.gbl>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 08:11:53 -0400
Message-Id: <1160568713.4795.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-11 at 14:02 +0200, Salvo Giuffrida wrote:
> If the security_compute_av function is called by the AVC when a cache miss 
> occurs, then how is first contacted the AVC by the object manager? Which 
> function is used?

avc_has_perm() is the permission checking interface between the object
manager and the AVC.  

> And the security_compute_create, by who is called? The object manager on 
> creation of new objects?

Yes.  Within the kernel, that is security_transition_sid.
security_compute_create is just the userland API to it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
