Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 19 Oct 2006 11:54:55 -0500
Message-ID: <001101c6f39f$4deb3e50$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <4537A223.6040202@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Example:
> >
> > 1. An outbound connection to port 80 on machine 10.0.0.1
> >
> > SECMARK:
> > -A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> > SECMARK --selctx system_u:object_r:http_client_packet_t:s2
> >
> > SECPOINT:
> > -A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> > SECMARK --selctx system_u:object_r:httpd_t:s0
> >
> > Reason for the change in Type from http_client_packet_t to httpd_t:
> >
> >
> so what about all the other apps that use port 80 like yum, rss
> aggregators, email clients (when image links are on the body), etc,
> etc.. there are probably hundreds. I don't think you want them all
> sending packets labeled with firefox_t

No. You already have these running as yum_t, rss_aggregator_t,
email_client_t,
etc., don't you? The packet will just carry the label from the socket
instead
of from the secmark.

SECMARK:
allow yum_t http_client_packet_t:packet { send };
allow rss_aggregator_t http_client_packet_t:packet { send };
allow email_client_t http_client_packet_t:packet { send };
...

SECPOINT:
allow yum_t httpd_t:packet { flow_out };
allow rss_aggregator_t httpd_t:packet { flow_out };
allow email_client_t httpd_t:packet { flow_out };
...

Same number of rules in both cases. IOW:

SECMARK:
Can a socket send a http_client_packet_t?
Forwarded traffic: NA (Not Applicable)

SECPOINT:
Can a packet from a socket (firefox_t) flow_out to httpd_t?
Forwarded traffic: Can a packet carrying a specific domain label (webonly_t)
flow_out to httpd_t?

> >> I think this seriously limits the usefulness of this. I
> *must* be able
> >> to specify locally who can talk to me from a remote machine.
> >>
> >
> > Yes and this is indeed what you can acomplish what "remote" domains
> > a sock can recv.
> >
> > If this isn't what you meant, please give me an example and
> we will try
> > again.
> >
> >
> it may be. What would the rules look like for the client running as
> semanage_t and the server running as pms_t ?

On the server:

allow pms_t semanage_t:packet { recv }

On the client:

allow semanage_t pms_t:packet { flow_out } [ Assuming you have secpoint
defined as pms_t on the client ]
allow semanage_t pms_t:packet { recv }

You now have assurance, on the server, that no one else but semanage_t
can talk to pms_t, and you have assurance on the client that semanage_t
can only correspond with pms_t.

The associations used will be based on the socket context (all traffic
from pms_t will use pms_t association and all traffic from semanage_t
will use the semanage_t assoc; this will happen transparently once I
move the "equality" constraint from the constraints file into the kernel.

Once you have labeled-ipsec being used, you will additionally need the
following rules for flow-control:

SERVER:

allow semanage_t pms_client_t:packet { flow_in }
allow pms_t pms_client_t:packet { flow_out }

CLIENT:

allow semanage_t pms_server_t:packet { flow_out }
allow pms_t pms_server_t:packet { flow_in }

> That is fine, the current design loses a ton of granularity

Not totally though. You are guaranteed to use joshua_t as the
subject at the first security point on the way out. But after
this you are right, you are losing the granularity, although
the question to be asked is if this loss of granularity will
in practice matter? The reason I ask is that assuming we somehow
let the last secpoint prevail and do just one check, you are
then still doing only one check where joshua_t is the subject
(with the target being the last secpoint). So the difference
is:

allow joshua_t secpoint1_t:packet { flow_out }
allow secpoint1_t secpoint2_t:packet { flow_out }
allow secpoint2_t network_t:packet { flow_out }

versus

allow joshua_t secpoint2_t:packet { flow_out }

> by doing
> this though. Where you say the label gets 'refined' I believe
> it becomes
> ambiguous. When something is joshua_t and then turns into a generic
> pass_some_secpoint_t you've lost alot of information.
>

PS: Our office is moving between today/tomorrow but should be back up
running sometime Monday.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
