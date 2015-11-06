Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6HweF7026385
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 12:58:41 -0500
Received: by obbww6 with SMTP id ww6so71991239obb.0
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 09:58:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fbc99e6ee9a6bdbf27d6ff71d3548c20b4bbf23c.1446805443.git.jstancek@redhat.com>
References: <cover.1446805443.git.jstancek@redhat.com>
 <fbc99e6ee9a6bdbf27d6ff71d3548c20b4bbf23c.1446805443.git.jstancek@redhat.com>
Date: Fri, 6 Nov 2015 12:58:38 -0500
Message-ID: <CAHC9VhQBOmybowY2H4rR3E6xoz-F21Ak3VQ61Y3O8GgwepjPsQ@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH 1/4] tests/inet_socket: check 'ip xfrm
 policy ctx' support
From: Paul Moore <paul@paul-moore.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Nov 6, 2015 at 8:07 AM, Jan Stancek <jstancek@redhat.com> wrote:
> Early RHEL6 distros like RHEL6.0 do not support "ctx" parameter,
> which is causing test to fail:
>   Error: argument "ctx" is wrong: unknown
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/inet_socket/test | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 4deca746208c..4f6ee51cec5c 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
> @@ -1,7 +1,14 @@
>  #!/usr/bin/perl
> -
> -use Test;
> -BEGIN { plan tests => 20}
> +use Test::More;
> +
> +BEGIN {
> +    # check if ip xfrm supports ctx parameter
> +    if (system("ip xfrm policy help 2>&1 | grep ctx") != 0) {
> +        plan skip_all => "ctx not supported in ip xfrm policy";
> +    } else {
> +        plan tests => 20;
> +    }
> +}
>
>  $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
>
> @@ -17,7 +24,7 @@ sleep 1; # Give it a moment to initialize.
>
>  # Verify that authorized client can communicate with the server.
>  $result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
> -ok($result, 0);
> +ok($result eq 0);

My understanding of Perl is *very* basic - why this change (and the
similar ones in this patch)?

-- 
paul moore
www.paul-moore.com
