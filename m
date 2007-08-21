From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Date: Tue, 21 Aug 2007 11:11:26 -0400
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Kaigai Kohei <kaigai@ak.jp.nec.com>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <1187704058.1451.107.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1187704058.1451.107.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708211111.27019.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 21 2007 9:47:38 am Stephen Smalley wrote:
> We likely should look at optimizing the ebitmap code, or replacing it
> with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
> For example, ebitmap_next could possibly use find_next_bit().

[Removed the busybox list because I'm sure they don't care]

Would the fact that the MLS category bitmaps grow to 1024 bits be a concern 
with using a single contiguous bitmap instead of the sparse bitmap the 
ebitmap currently uses?  Granted, in the worst case of c0.c1023 the kernel 
bitmap would most certainly be better but I wonder what the common case is 
(and if the MLS compartments even factor into the discussion) and which type 
is better suited to handle this case.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
