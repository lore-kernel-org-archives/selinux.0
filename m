Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u08N9dwK028598
 for <selinux@tycho.nsa.gov>; Fri, 8 Jan 2016 18:09:39 -0500
Received: by mail-ob0-f179.google.com with SMTP id xn1so92387213obc.2
 for <selinux@tycho.nsa.gov>; Fri, 08 Jan 2016 15:09:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB5=j_rdr6mEPctVLSrL06RG8Nj9hNO=4khcE0Aayn4HsK4UkA@mail.gmail.com>
References: <CAB5=j_rdr6mEPctVLSrL06RG8Nj9hNO=4khcE0Aayn4HsK4UkA@mail.gmail.com>
Date: Fri, 8 Jan 2016 18:09:36 -0500
Message-ID: <CAHC9VhQQUCHcfF1BL1cEdPPn5W-FRtQLV+tU8K0=TOUbW843vQ@mail.gmail.com>
Subject: Re: Preventing packet sniffing
From: Paul Moore <paul@paul-moore.com>
To: Mark Steele <mark@control-alt-del.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 7, 2016 at 10:11 PM, Mark Steele <mark@control-alt-del.org> wrote:
> Hi all,
>
> I would like to know what a good approach might be to prevent packet
> sniffing on a local node from being able to see the network traffic related
> to an application.
>
> Would iptables (secmark/connsecmark) do the trick to prevent tools like
> tcpdump from being able to see these packets? Are there alternative
> approaches that would be better for handling this?

You should be able to block access to raw/packet sockets for a given
domain which would effectively prevent you from running tcpdump, or
similar tools.  However, applying that system wide would be difficult.

-- 
paul moore
www.paul-moore.com
