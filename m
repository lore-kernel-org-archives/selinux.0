Date: Tue, 28 May 2002 08:58:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: David Caplan <dac@tresys.com>
cc: Russell Coker <russell@coker.com.au>, <SeLinux@tycho.nsa.gov>
Subject: RE: 2 checkpolicy bugs
In-Reply-To: <NJEELFKFDFJAACDDMCHCAEMFEAAA.dac@tresys.com>
Message-ID: <Pine.GSO.4.33.0205280853550.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 24 May 2002, David Caplan wrote:

> I think the important issue is that in order to compile a "valid" policy you
> may have to add things that you don't require.  In a sense this is allowing
> unnecessary permissions, violating the principle of least privilege.

I'm not sure that this is accurate.  In the case of port contexts, you
must have at least a single definition, but this definition can merely
assign the default context system_u:object_r:port_t (that is
associated with the 'port' initial SID) to a single port.  Since that
would be the default anyway, there is no real difference in the resulting
configuration.  No extra permissions would be granted by this "stub"
entry.

Is there some other section that poses a "least privilege" problem because
it must be included?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
