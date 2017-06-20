Message-ID: <1497989063.12069.18.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>, Luis Ressel <aranea@aixah.de>
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Date: Tue, 20 Jun 2017 16:04:23 -0400
In-Reply-To: <CAHC9VhQsVa+0LgqFyguqq0bhXOz7mrbJfXy-+rJjY53xnCkixg@mail.gmail.com>
References: <20170619213348.2970-1-aranea@aixah.de>
 <CAHC9VhQsVa+0LgqFyguqq0bhXOz7mrbJfXy-+rJjY53xnCkixg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-06-20 at 15:49 -0400, Paul Moore wrote:
> On Mon, Jun 19, 2017 at 5:33 PM, Luis Ressel <aranea@aixah.de> wrote:
> > For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
> > net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.
> > 
> > Signed-off-by: Luis Ressel <aranea@aixah.de>
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/hooks.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> My only concern is what effect this will have on existing policy.
> Prior to this patch PF_UNIX/SOCK_RAW will result in the generic
> "socket" class where after this patch it will result in the
> "unix_dgram_socket".  I believe this is the right change, but it
> seems
> like this should be wrapped by a policy capability, yes?

I doubt it is worth a policy capability.  Permission to create/use
socket tends to be far rarer than permission to create/use
unix_dgram_socket; looks like we never allow the former without the
latter in Fedora, for example.

> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 819fd6858b49..1a331fba4a3c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1275,6 +1275,7 @@ static inline u16
> > socket_type_to_security_class(int family, int type, int protoc
> >                 case SOCK_SEQPACKET:
> >                         return SECCLASS_UNIX_STREAM_SOCKET;
> >                 case SOCK_DGRAM:
> > +               case SOCK_RAW:
> >                         return SECCLASS_UNIX_DGRAM_SOCKET;
> >                 }
> >                 break;
> > --
> > 2.13.1
> 
> 
