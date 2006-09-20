Subject: Re: NetLabel base SID
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
In-Reply-To: <45115834.30504@hp.com>
References: <45115834.30504@hp.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 16:56:17 -0400
Message-Id: <1158785777.15340.219.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 11:03 -0400, Paul Moore wrote:
> As discussed earlier I am going to be submitting a patch which converts
> the NetLabel receive permission from "recv_msg" to "recvfrom".  I've
> also been thinking about a discussion I've had with Venkat about what to
> use as the NetLabel "base" SID in this particular case (this is ignoring
> the secid reconciliation work right now as I think we need to have a
> good solution in place until the secid work is completed).
> 
> Currently NetLabel uses the socket's SID which is convienient but may
> make it difficult to distinguish NetLabel traffic in policy.  Venkat
> suggested using the SECINITSID_UNLABELED as a base but I don't like that
> approach because of the unlabeled connotation.  I believe Stephen
> suggested at some point using SECINITSID_NETMSG as the base (Stephen, my
> apologies for not doing this sooner, I didn't fully understand at the
> time) - any objections?

Fine with me.

Note that the kernel will ignore changes to initial SID contexts upon a
policy reload, so that change in policy won't take affect anyway until
the kernel is rebooted.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
