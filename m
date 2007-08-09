From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 10:57:17 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov, joe@nall.com,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
References: <46BB2785.8040507@trustedcs.com>
In-Reply-To: <46BB2785.8040507@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708091057.17756.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 09 August 2007 10:41:09 am Darrel Goeddel wrote:
> ... I also think that there must be consistency forced between the different
> peer labeling mechanisms.  If I get packets that are specified as top_secret
> via CIPSO over an ipsec association labeled as user_u:user_r:user_t:secret,
> that packet should die. 

Yes.  This is one of the places in the labeled networking code that has always 
bothered me.  The current mashup of labels was rather a poor attempt at 
compromise by everyone involved and I think everyone will agree that we need 
to come up with a better solution.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
