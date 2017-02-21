Subject: Re: [PATCH] sepolgen: strip non-printable characters when parsing
 audit messages
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20170221144123.22532-1-vmojzis@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <63d8b953-f9fc-1872-6324-82635a929b9c@tycho.nsa.gov>
Date: Tue, 21 Feb 2017 13:56:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170221144123.22532-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/21/2017 09:41 AM, Vit Mojzis wrote:
> Strip the following characters
> \x1c	File Separator
> \x1d	Group Separator
> \x1e	Record Separator
> \x85	Next Line (C1 Control Code)
> from audit message fields to make sure they are not evaluated
> as part of some identifier (eg. ausearch used insert \x1d into
> --raw output resulting in "unrecognized class" error messages).
>
> This is done as part of str.split() in python3.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1406328

Applied.

Thanks,
Jim

> ---
>  python/sepolgen/src/sepolgen/audit.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/sepolgen/audit.py
> index 724d3ea..26ce6c9 100644
> --- a/python/sepolgen/src/sepolgen/audit.py
> +++ b/python/sepolgen/src/sepolgen/audit.py
> @@ -376,7 +376,9 @@ class AuditParser:
>      #   AuditMessage (or subclass) - object representing a parsed
>      #      and valid audit message.
>      def __parse_line(self, line):
> -        rec = line.split()
> +        # strip("\x1c\x1d\x1e\x85") is only needed for python2
> +        # since str.split() in python3 already does this
> +        rec = [x.strip("\x1c\x1d\x1e\x85") for x in line.split()]
>          for i in rec:
>              found = False
>              if i == "avc:" or i == "message=avc:" or i == "msg='avc:":
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
