Date: Mon, 5 Jan 2009 20:28:39 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] SELinux: Add new security mount option to indicate
 security label support.
In-Reply-To: <7e0fb38c0901031416w596d9c25vf42fb72a6824268b@mail.gmail.com>
Message-ID: <alpine.LRH.1.10.0901052024310.16929@tundra.namei.org>
References: <1230915146-2359-1-git-send-email-dpquigl@tycho.nsa.gov>  <1230915146-2359-3-git-send-email-dpquigl@tycho.nsa.gov> <7e0fb38c0901031416w596d9c25vf42fb72a6824268b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 3 Jan 2009, Eric Paris wrote:

> > +#define LABELSUPP_STR "supports_labeling"
> 
> This is very selinux specific and "labeling" is very generic.  James,
> you have suggestions?

There are other existing uses of the term "label" for mounting 
filesystems, so I'd suggest using "seclabel" here.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
