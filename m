Subject: Re: svirt on MLS has strange AVC.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Eric Paris <eparis@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <201003291600.06024.paul.moore@hp.com>
References: <4BA7E4BF.1040002@redhat.com>
	 <201003261547.33226.paul.moore@hp.com>
	 <1269887364.2980.195.camel@dhcp231-113.rdu.redhat.com>
	 <201003291600.06024.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 30 Mar 2010 15:20:31 -0400
Message-Id: <1269976831.9831.13.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-03-29 at 16:00 -0400, Paul Moore wrote:
> Sorry, I don't think it is very intuitive and the directionality is still a 
> bit questionable.  If you're really looking to come up with directional socket 
> labels, let's just make directional socket labels; believe it or not, we're 
> actually much closer to that then you make think ... here is a clue, look at 
> the "peer_sid" field which we store for connected sockets.
> 
> I would need to think about this a bit more, but we could have both a 
> "local_label" and a "peer_label" (I'm just picking easy, descriptive names 
> right now) on both a socket and a sock, much like the "sid" and "peer_sid" 
> labels we have now.  All traffic leaving a sock would be wire-labeled based on 
> the "local_label" and all traffic being queued to a sock would be checked 
> against the "local_label" as well.  Applications trying to read and write data 
> to and from a sock queue would be checked against the "peer_label" and the 
> rest of the socket operations, 
> create/connect/listen/setsockopt/getsockopt/etc., would use the "local_label".
> 
> I need to think about this some more, but I like the approach above much more 
> than labeling the socket/sock differently.

I don't think this is necessary, and it seems to have the same problems
I noted previously with Eric's proposal - you end up with different
meanings for the same permission check for pre-connection vs
post-connection and for connection-oriented vs. connectionless.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
