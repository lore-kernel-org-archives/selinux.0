Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SDLqHx007819
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 09:21:53 -0400
Received: by mail-oi0-f54.google.com with SMTP id o62so56398765oig.1
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 06:21:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56F9293A.6090902@gmail.com>
References: <56F9293A.6090902@gmail.com>
Date: Mon, 28 Mar 2016 09:21:50 -0400
Message-ID: <CAHC9VhRmUz0tJs9ZNKrV8wgrOoSNokoLz2UhVM8yArRQpjztOg@mail.gmail.com>
Subject: Re: CIL: invalid protocol (dccp portcon)
From: Paul Moore <paul@paul-moore.com>
To: Dominick Grift <dac.override@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 28, 2016 at 8:53 AM, Dominick Grift <dac.override@gmail.com> wrote:
> I was adding support for syslog ports, and /etc/services indicated to
> me that syslog(_tls) has support for dccp protocol. So tried to add
> that support in.
>
> However when trying to specify a portcon, secilc tells me dccp is an
> invalid protocol.
>
> e.g.
>
> (portcon "dccp" 6514 port_obj_context)

I'm not sure if the CIL toolchain checks /etc/protocols or if it uses
hardcoded values, but did you check to make sure "dccp" is listed in
/etc/protocols?

-- 
paul moore
www.paul-moore.com
