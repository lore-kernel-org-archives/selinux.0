Message-ID: <46BB200A.1080904@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 10:09:14 -0400 
MIME-Version: 1.0
in-reply-to: <1186663363.6916.393.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-08-07 at 10:14 -0400, Paul Moore wrote:
>> This patchset adds the static/fallback labeling feature to NetLabel that
has
>> been requested on the SELinux mailing list more and more recently.  This
new
>> bit of functionality also matches what can be found on similar
trusted/labeled
>> OSs such as Trusted Solaris, HP-UX CMW, etc.  This patchset it not yet
ready
>> for "upstreaming" so please do not pull this into any tree bound for the
>> mainline kernel; I still need to do more review and testing of the code.
>> However, I know there are several of you on this list that have been
anxiously
>> awaiting this patchset so I thought I would make an early release so you
could
>> get a peek and test it out.  I won't be able to work on this patchset
much, if
>> at all, between August 10th and the 20th so don't expect an update from
me
>> until the end of August.
>>
>> The basic idea is that currently there is no method for providing an
external
>> label to fallback on if a labeled networking mechanism such as
NetLabel/CIPSO
>> or labeled IPsec is not in use.  This patch adds a mechanism for
providing a
>> static fallback label, specified per interface/network, which is used
when
>> a NetLabel recognized labeling protocol (at this point CIPSO) is not in
use.
>>
>> For those of you wishing to try this patchset, it is backed against
Linus'
>> linux-2.6 git tree from the afternoon of August 6th, but I don't imagine
you'll
>> have many problems applying the patchset to later trees at this point in
the
>> 2.6.23 release cycle.  In addition to the kernel patches you will also
need a
>> modified version of netlabelctl from the netlabel_tools package.  A very
crude
>> version of the modified tools can be found in the netlabel_tools SVN
repository
>> in the static_label branch.  Please check the NetLabel website on
SourceForge,
>> http://netlabel.sf.net, for information on the SVN repository.  The three
new
>> netlabelctl commands are as follows:
>>
>>  # netlabelctl unlbl add interface:<DEV> address:<ADDR>[/<MASK>]
label:<LABEL>
>>  # netlabelctl unlbl del interface:<DEV> address:<ADDR>[/<MASK>]
>>  # netlabelctl -p unlbl list
>>
>>    DEV = interface, examples: eth0, lo
>>    ADDR = IP address, examples: 192.168.0.3, ::1
>>    MASK = IP address mask length, examples 8, 24, 64
>>    LABEL = LSM/SELinux label, example: system_u:object_r:unlabeled_t:s2
>>
>> For example, if you wanted to label all inbound traffic on eth1 from
>> 192.168.0.0/16 with the label "system_u:object_r:staticlabel_t:s7" you
would
>> type:
>>
>>  # netlabelctl unlbl add interface:eth1 address:192.168.0.0/16 \
>>                          label:system_u:object_r:staticlabel_t:s7
>>
>> Both IPv4 and IPv6 addresses can be used and if the address mask is
ommitted
>> from the command the address is assumed to be a host address, not a
network,
>> and the maximum mask size for that address family is used.  If you do not
wish
>> to specify an address, simply use a address mask of zero, "/0", which
will
>> cause all addresses within that address family to match.
> 
> Hi,
> 
> I like the functionality, but I don't like having yet another mechanism
> and configuration, and I'm concerned about it being netlabel-centric.
> Especially when we already have a more generic and flexible mechanism
> for specifying packet labels, i.e. secmark.
> 
> The only reason to not use secmark today for a fallback mechanism is the
> current separation between 'internal' and 'external' labels.  But I
> don't believe that separation is necessary or useful, and secmark today
> is effectively unused.  The original usage scenario for it simply hasn't
> materialized.

I agree whole-heartedly with the above statements.  I actually use the
secmark
mechanism and labeled ipsec, but unfortunately I need a patched kernel to
make
the useful in in regards to the issues of flow control (providing a
mechanism
for a controlled network interface) and loopback labeling.  These are
necessary
features for the user base I work with.  This user base happens to be the
LSPP
crowd, folks that needed a certified platform, but now they can't use the
certified
platform because it is woefully lacking in the network control department.

> Meanwhile, getting secmark employed, not only as a mechanism for
> assigning default labels (via iptables rules) but also as a seamless way
> of propagating labels with socket buffers would solve a lot of our
> current limitations.  We'd get loopback labeling for free, flexible and
> generic fallback labeling, forwarding controls would become
> straightforward, and PEERSEC/SCM_SECURITY becomes much simpler.
> NetLabel would benefit from it as well.  There are alternative
> implementation approaches, but none as clean and efficient and reliable.
> There was a reason we put a sid in the sk_buff in the original SELinux
> implementations (prior to Linux 2.6 merge).
> 
> I've had some initial discussions with James, and he seemed open to
> revisiting this notion, so I think we need to take another look.

Because of the position I am in (needing to find something workable for
actual
users), I have been trying to get my head aounrd the state of SELinux
networking,
the ideas that have been talked about in the past, and how we can prevent
the
SELinux networking infrastructure from resembling a Rube-Goldberg machine.
I'll
be presenting some of the problems I perceive along with some very high
level
ideas early next week.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
