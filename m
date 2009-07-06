From: Paul Moore <paul.moore@hp.com>
To: Thomas Liu <tliu@redhat.com>
Subject: Re: [PATCH 1/4 -v2] Namespacing of security/selinux
Date: Mon, 6 Jul 2009 16:28:06 -0400
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org
References: <1246906718.2460.12.camel@Ares>
In-Reply-To: <1246906718.2460.12.camel@Ares>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200907061628.06422.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 06 July 2009 02:58:38 pm Thomas Liu wrote:
> This patch namespaces the functions in security/selinux, prefixing
> non static functions with selinux_
>
> Patch 1 includes namespacing of the security/selinux folder,
> not including security/selinux/ss.
>
> Added selinux_ as a prefix to non static functions, not including
> functions beginning with avc_.  Swapped security_ with selinux_.

I haven't had a chance to look at all of you patches yet but a few quick 
thoughts in no particular order ...

* Why not prefix functions regardless of if they are static or not?  After 
all, when you are reading the function body of a caller you don't always know 
that the function being called is static.  I personally would find this nice, 
but I might be the only one.

* The "selinux_" prefix seems a tiny bit longer than necessary, how about 
something like "sel_"/"sel_ss_" (we already use SEL in a few places) or 
"selnx_"/"selnx_ss_"?

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
