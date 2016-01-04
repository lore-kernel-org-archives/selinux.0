Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u04EDK6H023750
 for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2016 09:13:21 -0500
Received: by mail-qg0-f42.google.com with SMTP id b35so124561343qge.0
 for <selinux@tycho.nsa.gov>; Mon, 04 Jan 2016 06:13:05 -0800 (PST)
Message-ID: <568A7DED.8010609@quarksecurity.com>
Date: Mon, 04 Jan 2016 09:13:01 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] policycoreutils: semanage: list reserver_port_t
References: <1451896444-29665-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <1451896444-29665-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Petr Lautrbach wrote:
> reserver_port_t was omitted in 'semanage port -l'. There seems to be no
> reason for that nowadays therefore we can list it.
>
> Resolves https://bugzilla.redhat.com/show_bug.cgi?id=1225806
>
> Signed-off-by: Petr Lautrbach<plautrba@redhat.com>

Thanks, applied.

> ---
>   policycoreutils/semanage/seobject.py | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
> index c52be75..3b0b108 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1216,8 +1216,6 @@ class portRecords(semanageRecords):
>           for port in self.plist:
>               con = semanage_port_get_con(port)
>               ctype = semanage_context_get_type(con)
> -            if ctype == "reserved_port_t":
> -                continue
>               level = semanage_context_get_mls(con)
>               proto = semanage_port_get_proto(port)
>               proto_str = semanage_port_get_proto_str(proto)
> @@ -1238,8 +1236,6 @@ class portRecords(semanageRecords):
>           for port in self.plist:
>               con = semanage_port_get_con(port)
>               ctype = semanage_context_get_type(con)
> -            if ctype == "reserved_port_t":
> -                continue
>               proto = semanage_port_get_proto(port)
>               proto_str = semanage_port_get_proto_str(proto)
>               low = semanage_port_get_low(port)
