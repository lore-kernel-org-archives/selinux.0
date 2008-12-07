Date: Mon, 8 Dec 2008 09:05:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] SELinux: Add new security mount option to indicate
 security label support.
In-Reply-To: <alpine.LRH.1.10.0812080903520.22527@tundra.namei.org>
Message-ID: <alpine.LRH.1.10.0812080905100.22527@tundra.namei.org>
References: <1228421890-9467-1-git-send-email-dpquigl@tycho.nsa.gov>  <1228421890-9467-3-git-send-email-dpquigl@tycho.nsa.gov>  <alpine.LRH.1.10.0812051200380.11818@tundra.namei.org> <1228488915.15920.42.camel@moss-terrapins.epoch.ncsc.mil>
 <alpine.LRH.1.10.0812080903520.22527@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 Dec 2008, James Morris wrote:

> > I'm assuming you mean change SBLABELSUPP to SE_SBLABELSUPP, correct?
> 
> Yes, although the Linux way would likely be SE_SB_LABEL_SUPP for 
> readability.

It's probably not worth changing again, so don't worry.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
