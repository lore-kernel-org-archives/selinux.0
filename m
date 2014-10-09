Message-ID: <543693F3.5060908@quarksecurity.com>
Date: Thu, 09 Oct 2014 09:56:03 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Nick Kralevich <nnk@google.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
 <CADjGSjg0c7X2kY1_qUg4GgKtOnkmFkPsmEMDXxwmj7a-h+K+5Q@mail.gmail.com>
 <CABXk95D6JEVXuUBBbkCcOqfZH5+okmjf_pD=HV0jqfb5OmE5sw@mail.gmail.com>
 <CAFJ0LnHo54QJhc+ojK5HP8RsiS0BNRHiC113SS=kEshVVf2drw@mail.gmail.com>
In-Reply-To: <CAFJ0LnHo54QJhc+ojK5HP8RsiS0BNRHiC113SS=kEshVVf2drw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nick Kralevich wrote:
> Thank you for putting together this patch Jeff.
>
> FWIW, I'm supportive of patches like this. Allowing policy to restrict
> access to unique persistent device identifiers without impacting other
> ioctl operations feels like a small but important privacy win for me,
> especially on distributions designed to run potentially untrustworthy
> applications. Hopefully the wider SELinux team agrees with this, and we
> can make progress towards producing a patch which works well for everyone.
>
> Joshua: This patch wasn't intended to address off-device leakage of MAC
> addresses. That's an important problem, but not something solvable via
> SELinux policy.
>

I understand now and agree that it is something desirable.

> -- Nick
>
>
>
> On Wed, Oct 8, 2014 at 9:09 PM, Jeffrey Vander Stoep <jeffv@google.com
> <mailto:jeffv@google.com>> wrote:
>
>     Hi Joshua,
>
>
>     Thank you for responding.
>
>
>     The intent is not to hide the MAC address from the
>     local-area-network, it is to restrict which applications on the
>     local machine have access to it. The use-case is to more tightly
>     sandbox untrusted applications from accessing persistent hardware
>     identifiers.
>
>
>     Consider a web client application that has a legitimate reason to
>     access the internet and network information in order to retrieve
>     information from a remote web server. Unbeknownst to the user, the
>     application reads the MAC address and sends it to the web server to
>     uniquely identify/fingerprint the hardware that its running on
>     (instead of using more privacy-friendly non-persistent methods like
>     cookies, certificates, temp files, username/password). Tracking with
>     persistent identifiers such as the MAC address is surprisingly
>     common, invisible to the user, and it allows for tracking that
>     persists across multiple users, different networks, history wipes,
>     disk wipes, factory resets, username/password changes etc. The
>     ability to limit access to persistent hardware identifiers like the
>     MAC address allows for writing policy that enhances user privacy by
>     making it more difficult for software to tie itself to specific
>     hardware. Many applications need network access, very few need the
>     MAC address. It would be useful to be able to write policy that
>     allows access to one without the other.
>
>     On Wed, Oct 8, 2014 at 6:01 PM, Joshua Brindle
>     <brindle@quarksecurity.com <mailto:brindle@quarksecurity.com>> wrote:
>
>         On Wed, Oct 8, 2014 at 8:41 PM, Jeffrey Vander Stoep
>         <jeffv@google.com <mailto:jeffv@google.com>> wrote:
>         >  First time poster to the list. I would appreciate
>         feedback/suggestions
>         >  regarding the following patch.
>         >
>         >  This patch which provides SELinux control over network
>         interface MAC
>         >  addresses. This patch allows access to the MAC address to be
>         controlled by
>         >  policy. Network MAC addresses are a long lived unique device
>         identifier, and
>         >  a security policy may wish to control access to the identifier
>         without
>         >  further limiting network use, perhaps for privacy reasons.
>         >
>         >  The existing SE Linux permissions are too coarse in that they
>         only allow
>         >  blanket read/no-read access to this socket ioctl. We would
>         like to consider
>         >  both the read/no-read permission as well as an additional
>         permission that
>         >  checks the ioctl cmd argument. This allows applications to
>         continue
>         >  accessing the IP address, netmask, etc, while being denied
>         access to the MAC
>         >  address.
>         >
>
>         If someone has another system on the same network they can just get
>         the address by pinging it and running arp -a, right?
>
>         What use case do you see covering by adding this permission?
>
>          > Thanks,
>          > Jeff Vander Stoep
>          >
>          > ---
>          >  security/selinux/hooks.c            | 7 +++++++
>          >  security/selinux/include/classmap.h | 2 +-
>          >  2 files changed, 8 insertions(+), 1 deletion(-)
>          >
>          > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>          > index 1e1266b..cb65fd9 100644
>          > --- a/security/selinux/hooks.c
>          > +++ b/security/selinux/hooks.c
>          > @@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct
>         file *file,
>          > unsigned int cmd,
>          >      SECURITY_CAP_AUDIT);
>          >   break;
>          >
>          > +    case SIOCGIFHWADDR:
>          > +        error = file_has_perm(cred, file, FILE__IOCTL);
>          > +        if (error)
>          > +            break;
>          > +        error = file_has_perm(cred, file, SOCKET__GET_HWADDR);
>          > +        break;
>          > +
>          >   /* default case assumes that the command will go
>          >   * to the file's ioctl() function.
>          >   */
>          > diff --git a/security/selinux/include/classmap.h
>          > b/security/selinux/include/classmap.h
>          > index c32ff7b..306f0d2 100644
>          > --- a/security/selinux/include/classmap.h
>          > +++ b/security/selinux/include/classmap.h
>          > @@ -7,7 +7,7 @@
>          >
>          >  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind",
>         "connect", \
>          > "listen", "accept", "getopt", "setopt", "shutdown",
>         "recvfrom",  \
>          > - "sendto", "recv_msg", "send_msg", "name_bind"
>          > + "sendto", "recv_msg", "send_msg", "name_bind", "get_hwaddr"
>          >
>          >  #define COMMON_IPC_PERMS "create", "destroy", "getattr",
>         "setattr", "read",
>          > \
>          > "write", "associate", "unix_read", "unix_write"
>          > --
>          > 2.1.0.rc2.206.gedb03e5
>          >
>          >
>          > _______________________________________________
>          > Selinux mailing list
>          > Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>          > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
>         <mailto:Selinux-leave@tycho.nsa.gov>.
>          > To get help, send an email containing "help" to
>          > Selinux-request@tycho.nsa.gov
>         <mailto:Selinux-request@tycho.nsa.gov>.
>
>
>
>     _______________________________________________
>     Selinux mailing list
>     Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>.
>     To get help, send an email containing "help" to
>     Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>
>
>
>
> --
> Nick Kralevich | Android Security | nnk@google.com
> <mailto:nnk@google.com> | 650.214.4037
