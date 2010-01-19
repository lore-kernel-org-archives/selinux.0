From: Paul Moore <paul.moore@hp.com>
To: Jason Shaw <js44352@gmail.com>
Subject: Re: Assigning a Type to Network Interfaces
Date: Tue, 19 Jan 2010 17:54:51 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@lists.fedoraproject.org,
        selinux@tycho.nsa.gov
References: <c63e41181001140608u37e57495s15bd7c7d2f50a0e3@mail.gmail.com> <1263910853.12068.6.camel@moss-pluto.epoch.ncsc.mil> <c63e41181001191007q12f5c91av4dbe9d87858f8f09@mail.gmail.com>
In-Reply-To: <c63e41181001191007q12f5c91av4dbe9d87858f8f09@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201001191754.52088.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 19 January 2010 01:07:53 pm Jason Shaw wrote:
> Can netif checks be enabled for 'packet_socket read'? If so, how?
> 
> My app requires this allow rule:
> allow myApp_t self:packet_socket { create read bind ioctl };
> 
> Currently, with this rule in place and the app running in its own
> domain, it can read data from any interface. If I am understanding
> correclty, with a netif-based check enabled for packet_socket read, could
> the application then be restricted to read from a specific eth interface
> as opposed to being able read from any eth interface?

The ingress/egress and secmark controls should work regardless of the socket 
type, so there _should_ be no problem with packet sockets.  Assuming you 
want to use the ingress/egress controls you would need to do the following:

 1. Ensure you have the right policy loaded

    For the examples shown here you will need to create two new types,
    "foo_netif_t" and "foo_peer_t", as well as the policy rules to allow
    them to work.  Stephen has already pointed you to some blog entries
    explaining what you need to do, so we'll consider this step as an
    exercise for the reader :)

 2. Label the interface

    You've already got this figured out for the most part, but for the
    record, the following will assign type "foo_netif_t" to eth0 and
    display the configured interface labels:

    # semanage interface -a -t foo_netif_t eth0
    # semanage interface -l

 3. Configure a static network peer label (assumes unlabeled traffic)

    If you aren't using a form of network peer labeling, e.g. labeled
    IPsec or CIPSO, you'll need to enable some form of per-packet
    peer labeling for the controls to take effect (otherwise the
    packets are unlabeled and the controls just don't make sense).
    In order to configure a static network peer label you need to ensure
    that you have "netlabelctl" installed:

    # yum install netlabel_tools

    From here you should read the netlabelctl man page (lots of good
    examples) and then come back to this email ... I'll wait .... okay,
    now you can go ahead and configure a static peer label; the following
    will assign the label "system_u:object_r:foo_peer_t:s0" to all
    IPv4 traffic coming in on eth0:

    # netlabelctl unlbl add interface:eth0 address:0.0.0.0/0 \
      label:system_u:object_r:foo_peer_t:s0

At this point everything should be up and running, if not let us know :)

Good luck!

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
