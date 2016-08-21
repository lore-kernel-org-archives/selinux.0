Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7L3PA2B005956
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 23:25:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id e80so9156016oig.2
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 20:24:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 20 Aug 2016 23:24:40 -0400
Message-ID: <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
Subject: Re: [PATCH] Differentiate between Unix Stream Socket and Sequential
 Packet Socket
To: Guido Trentalancia <guido@trentalancia.net>
Cc: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 20, 2016 at 3:09 PM, Guido Trentalancia
<guido@trentalancia.net> wrote:
> Hello Paul!
>
> The message subject used in the Reference Policy mailing list is: "Update the lvm module" and it's one of the most recent posting.
>
> I haven't tried yet reproducing the problem outside of the system bootup.
>
> I believe it happens when cryptsetup uses the user-space interface to the kernel Crypto API.
>
> Do you have any idea on the reason why the class is being marked as "socket" instead of "unix_stream_socket" (for sequential packet socket)?

Thanks for the pointer to the thread; that helped.

As far as the socket class is concerned, I wonder if cryptsetup is
using an AF_ALG socket?  Some quick Googling of the cryptsetup source
repo indicates this may be the case.  We don't currently have a
specific object class for the AF_ALG socket family so it would appear
as the generic socket class.

-- 
paul moore
www.paul-moore.com
