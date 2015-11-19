Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAJL4qPq009286
 for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2015 16:04:52 -0500
Received: by obdgf3 with SMTP id gf3so71529718obd.3
 for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2015 13:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1815745045.4800143.1446846287294.JavaMail.zimbra@redhat.com>
References: <cover.1446805443.git.jstancek@redhat.com>
 <fbc99e6ee9a6bdbf27d6ff71d3548c20b4bbf23c.1446805443.git.jstancek@redhat.com>
 <CAHC9VhQBOmybowY2H4rR3E6xoz-F21Ak3VQ61Y3O8GgwepjPsQ@mail.gmail.com>
 <1815745045.4800143.1446846287294.JavaMail.zimbra@redhat.com>
Date: Thu, 19 Nov 2015 16:04:19 -0500
Message-ID: <CAHC9VhRqB+HpvWJwU4kH_017vEHSrOq_sQZFRHuzHc6b1YukoQ@mail.gmail.com>
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

On Fri, Nov 6, 2015 at 4:44 PM, Jan Stancek <jstancek@redhat.com> wrote:
> ----- Original Message -----
>> From: "Paul Moore" <paul@paul-moore.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: selinux@tycho.nsa.gov, "Stephen Smalley" <sds@tycho.nsa.gov>
>> Sent: Friday, 6 November, 2015 6:58:38 PM
>> Subject: Re: [selinux-testsuite PATCH 1/4] tests/inet_socket: check 'ip xfrm policy ctx' support
>>
>> On Fri, Nov 6, 2015 at 8:07 AM, Jan Stancek <jstancek@redhat.com> wrote:
>> > Early RHEL6 distros like RHEL6.0 do not support "ctx" parameter,
>> > which is causing test to fail:
>> >   Error: argument "ctx" is wrong: unknown
>> >
>> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
>> > Cc: Paul Moore <paul@paul-moore.com>
>> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  tests/inet_socket/test | 31 +++++++++++++++++++------------
>> >  1 file changed, 19 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/tests/inet_socket/test b/tests/inet_socket/test
>> > index 4deca746208c..4f6ee51cec5c 100755
>> > --- a/tests/inet_socket/test
>> > +++ b/tests/inet_socket/test
>> > @@ -1,7 +1,14 @@
>> >  #!/usr/bin/perl
>> > -
>> > -use Test;
>> > -BEGIN { plan tests => 20}
>> > +use Test::More;
>> > +
>> > +BEGIN {
>> > +    # check if ip xfrm supports ctx parameter
>> > +    if (system("ip xfrm policy help 2>&1 | grep ctx") != 0) {
>> > +        plan skip_all => "ctx not supported in ip xfrm policy";
>> > +    } else {
>> > +        plan tests => 20;
>> > +    }
>> > +}
>> >
>> >  $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
>> >
>> > @@ -17,7 +24,7 @@ sleep 1; # Give it a moment to initialize.
>> >
>> >  # Verify that authorized client can communicate with the server.
>> >  $result = system "runcon -t test_inet_client_t $basedir/client stream
>> >  65535";
>> > -ok($result, 0);
>> > +ok($result eq 0);
>>
>> My understanding of Perl is *very* basic - why this change (and the
>> similar ones in this patch)?
>
> I wanted to skip the test, but skip_all is supported only in Test::More
> framework. And arguments in ok() have slightly different meaning.
>
> In "Test" args are "ok($have, $expect);" [1]
> In "Test::More" args are "ok($got eq $expected, $test_name);" [2]
>
> This change adapts parameters to "Test::More" style.

That's really annoying that Test::More changes the ok() function;
bummer.  Okay, I'll merge the patch, thanks for the clarification.

> [1] http://perldoc.perl.org/Test.html
> [2] http://perldoc.perl.org/Test/More.html

-- 
paul moore
www.paul-moore.com
