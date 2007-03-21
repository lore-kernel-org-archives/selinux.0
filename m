From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Date: Wed, 21 Mar 2007 18:42:14 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
References: <20070314025023.115872483@hp.com> <200703201734.18351.paul.moore@hp.com> <1174479635.22565.353.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174479635.22565.353.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703211842.14683.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, March 21 2007 8:20:35 am Stephen Smalley wrote:
> On Tue, 2007-03-20 at 17:34 -0400, Paul Moore wrote:
> > On Tuesday 20 March 2007 2:43:31 pm Stephen Smalley wrote:
> > > So what is your goal?  Do you want to allow
> > > non-netlabel'd packets under MLS (problematic then to use unlabeled SID
> > > as the basis) or deny it?
> >
> > My goal is to have the ability to specify, in SELinux policy on a
> > per-domain basis, access controls for both NetLabel'd and non-NetLabel'd
> > traffic.  Right now you can only specify access for NetLabel'd traffic
> > using SELinux policy, restricting non-NetLabel'd traffic must be done
> > outside of the SELinux policy on a system wide scale:
> >
> >  # netlabelctl unlbl allow on|off
>
> Always applying the permission check would allow such control, but the
> the issue is that if you use the unlabeled initial SID for the
> non-netlabel'd traffic, then the only way to allow a process to receive
> the packets would be to give its domain MLS networking overrides, and at
> that point, it could receive not only non-netlabel'd traffic but also
> netlabel'd traffic with a higher level if you allow it to receive any
> netlabel'd traffic at all.  Which limits you to one of (receive all
> non-netlabel'd traffic, receive netlabel'd traffic that I dominate, or
> receive all traffic even if it dominates my level) as your per-domain
> options.  Is that sufficient?

I was also planning on modifying the MLS constraint in a similar fashion to 
how the IPsec association constraints from recvfrom/sendto so that the 
NetLabel recvfrom constraint would look something like this:

 mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
         (( l1 eq l2 ) or
          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
          ( t1 == mlsnetread ) or
          ( t2 == unlabeled_t ));

This should solve the problem on the default SystemHigh MLS sensitivity label 
assigned to the unlabeled initial SID while increasing the similarities 
between labeled IPsec and NetLabel (for better or worse).  Once again, this 
assumes that the netmsg initial SID would have a type other than unlabeled_t.

> It also seems that you might want the ability to distinguish among
> different kinds of non-netlabel'd traffic based on receiving network
> interface, so you could map some of that traffic to one level and some
> of it to another level (which is actually closer in concept to the
> netmsg sids, as they can be configured per netif in policy, although
> nothing is using that support currently - legacy of when we were using
> it as the default packet label for incoming traffic on a network
> interface).

This is an interesting idea, one which I have tossed around since I started 
the NetLabel work.  In fact, have the reason for making a separate 
unlabeled "module" in NetLabel was to help break out unlabeled packet 
handling to make life easier if we wanted to go this route.  I know several 
existing MLS systems can be configured to assign default MLS sensitivity 
labels to packets coming in on a specific interface, it only seems reasonable 
that we would support a similar capability.

However, I postponed doing any work on this when I thought 
SECMARK/secid-reconciliation might be able to solve some part of this; 
although we know now that it is not the case (at least in the getpeercon() 
sense).  My only concern now about doing something like this is how the 
SELinux community would respond to getpeercon() returning a context for a 
peer which is not actually sending labeled traffic.

> So an alternative would be to use the netmsg SID (or even the per-netif
> netmsg SIDs obtained via sel_netif_sids(), specified in netifcon
> statements in policy, should be supported by libsemanage/libsepol but
> not in the current semanage interface) for the non-netlabel'd traffic
> rather than the other way around.  Then you aren't forced to having
> SystemHigh on that traffic, and can even support per-NIC levels in the
> future.  Although that will yield the amusing situation that your
> netlabel'd traffic will still have unlabeled_t and your non-netlabel'd
> traffic will have some other type.

Heh, if we went that route I don't think I would ever be able to answer all of 
the emails asking why the unlabeled_t packets are the ones coming from the 
labeled network and the unlabeled network packets would have type foo ... ;)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
