Date: Thu, 18 Dec 2008 15:30:33 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Hasan Rezaul-CHR010 <CHR010@motorola.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
Subject: Re: Avc denies while running in Permissive mode...
In-Reply-To: <1229535751.31499.22.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0812181525050.30403@tundra.namei.org>
References: <1228865476.3737.13.camel@localhost.localdomain>  <1228916038.23307.1.camel@localhost.localdomain>  <D06FE0A2807BC145B0D38744789D4F5D051775A7@de01exm68.ds.mot.com> <1229535751.31499.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Dec 2008, Stephen Smalley wrote:

> In permissive mode, when a permission would be denied for a given
> (source context, target context, target class) triple for the first
> time, the kernel audits the denial (avc:  denied) and then adds that
> permission to the allowed vector for that triple in the AVC (access
> vector cache).  Thus, subsequent uses of that same permission on that
> same triple will not trigger further denials until the cache entry is
> evicted from the cache (which can happen automatically if we need to
> free up space for use by other entries or explicitly upon either a
> policy reload or changing a policy boolean).

What about adding a kernel option (say, selinux_permissive_debug), which 
causes the permission update to be bypassed, but still allows the 
operation?

Something like:

int avc_has_perm_noaudit(...)
{

	...

        if (denied) {
                if (flags & AVC_STRICT)
                        rc = -EACCES;
                else if (!selinux_enforcing || security_permissive_sid(ssid))
			if (!selinux_permissive_debug)
				avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
                                	        tsid, tclass);
                else
                        rc = -EACCES;
        }

	...
}

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
