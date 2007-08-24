Date: Fri, 24 Aug 2007 13:17:00 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: casey@schaufler-ca.com, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <200708241549.05839.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0708241315280.26160@us.intercode.com.au>
References: <454500.99769.qm@web36612.mail.mud.yahoo.com>
 <200708241549.05839.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Aug 2007, Paul Moore wrote:

> Feel free to suggest something better, I don't think anyone was ever really in 
> love with the term "secmark label".  I believe at one point Stephen 
> suggested "iptables label", does that sound any better?

I like packet label, because it's a label based on the attributes of the 
packet.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
