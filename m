Subject: Re: selinux and sctp
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Nigel Rumens <wooky@btconnect.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <200905261832.44705.paul.moore@hp.com>
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com>
	 <200905261832.44705.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 27 May 2009 08:12:05 -0400
Message-Id: <1243426325.19066.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-26 at 18:32 -0400, Paul Moore wrote:
> On Monday 25 May 2009 07:16:06 am Daniel J Walsh wrote:
> > On 05/24/2009 06:00 AM, Nigel Rumens wrote:
> > > Hi,
> > >
> > > Does selinux understand sctp?
> > >
> > > When I run (for example)
> > >
> > > sctp_darn -H 0 -P 9876 -l
> > >
> > > It results in an avc denial message which tells me the target object is
> > > of type None[rawip_socket]
> > >
> > > Also semanage port -l shows only udp and tcp
> > >
> > > Machine tested on was F11 (fully updated) - I also tried it F10 with the
> > > same results
> 
> Hi Nigel,
> 
> Can you send us the AVC denial messages?  If you are running a recent kernel 
> (F11/Rawhide should qualify and F10 will likely as well) there should only be 
> a handful of areas where you should be hitting transport protocol specific 
> code that isn't SCTP aware in the kernel, it would be nice to verify that so 
> we could better identify what work needs to be done.

- Need to define a sctp_socket class in the policy and kernel (presently
they get mapped to rawip_socket).
- Need to extend the node_bind/name_bind checking to handle multiple
address binding for SCTP.
- Need to extend the name_connect checking to support SCTP.
- Need to add getpeersec support (also missing for DCCP).
- Need to extend selinux_parse_skb* to handle it.
- Need to update libsepol/libsemanage, checkpolicy, and semanage to
support it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
