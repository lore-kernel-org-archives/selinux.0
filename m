Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7LHWuJQ017936
 for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2016 13:32:56 -0400
Message-ID: <1471800773.2544.7.camel@trentalancia.net>
Subject: Re: [PATCH] Differentiate between Unix Stream Socket and Sequential
 Packet Socket
From: Guido Trentalancia <guido@trentalancia.net>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Sun, 21 Aug 2016 19:32:53 +0200
In-Reply-To: <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello Paul.

On Sat, 20/08/2016 at 23.24 -0400, Paul Moore wrote:
> On Sat, Aug 20, 2016 at 3:09 PM, Guido Trentalancia
> <guido@trentalancia.net> wrote:
> > 
> > Hello Paul!
> > 
> > The message subject used in the Reference Policy mailing list is:
> > "Update the lvm module" and it's one of the most recent posting.
> > 
> > I haven't tried yet reproducing the problem outside of the system
> > bootup.
> > 
> > I believe it happens when cryptsetup uses the user-space interface
> > to the kernel Crypto API.
> > 
> > Do you have any idea on the reason why the class is being marked as
> > "socket" instead of "unix_stream_socket" (for sequential packet
> > socket)?
> 
> Thanks for the pointer to the thread; that helped.
> 
> As far as the socket class is concerned, I wonder if cryptsetup is
> using an AF_ALG socket?  Some quick Googling of the cryptsetup source
> repo indicates this may be the case.  We don't currently have a
> specific object class for the AF_ALG socket family so it would appear
> as the generic socket class.

There has been a misunderstanding between the socket namespace and
style. Indeed, I was missing something !

I have now posted a new version of the patch (v2) which should properly
classify the new socket type.

Best regards,

Guido
