Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3BLiQNu011163
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 17:44:26 -0400
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com
 [209.85.215.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8F1FD564682
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 23:44:21 +0200 (CEST)
Received: by mail-lf0-f52.google.com with SMTP id e190so174676107lfe.0
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 14:44:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460131535-15688-1-git-send-email-jason@perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
Date: Mon, 11 Apr 2016 23:44:20 +0200
Message-ID: <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
Subject: Re: genhomedircon USERID and USERNAME patches
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Jason Zaman <jason@perfinion.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e01183bc884c0a505303c725f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e01183bc884c0a505303c725f
Content-Type: text/plain; charset=UTF-8

On Fri, Apr 8, 2016 at 6:05 PM, Jason Zaman <jason@perfinion.com> wrote:

> Hi all,
>
> I finally finished adding more templates to genhomedircon and a lot of
> general
> cleanups.
>
> The first few patches refactor the templating functions so they are
> smaller and
> easier to add new. All the common bits were taken out and they all take the
> user_entry_t struct instead of passing args one by one.
>
> The last three patches add the new templating types. I went with %{USERID}
> and
> %{USERNAME}. They now have a clear start and end unlike USER in the past
> and $
> is end of line in regexes so % seems safer. The matcher for USER now
> specifically excludes any line that has the new patterns in it too so
> there can
> be no conflict. It appears to work in the testing I have done with adding
> strange fcontexts. make test passes in the repo too but i have not run the
> full
> selinux-testsuite.
>

Hi,
Thanks for your work. Your patches are very well built and I have been able
to test them without any trouble. Here are some comments:
* In Patch 1, the last parameter of write_replacements() can be made a
const pointer: "const replacement_pair_t *repl" (parameters s and tpl too
but there are not currently const pointers).
* Patch 5 introduces a "gid" field in "struct user_entry", which is not
used in the templates. Why did you introduce it?
* Patch 7 introduces two functions, write_username_context
and write_userid_context, which handle lines containing %{USERNAME}
and %{USERID} separately. If a line includes both patterns, like
"%{USERID}-%{USERNAME}", the generated file will have for root user two
lines: one with "%{USERID}-root" and the other "0-%{USERNAME}". As a user I
would have expected both templates to be replaced. I believe this may be
achieved by merging the two predicate functions together (in patch 6), and
the substitutions functions too (in patch 7).


>
> %{USERNAME} defaults to ".*" in the fallback just like USER originally did
> %{USERID} defaults to "[0-9]+" for the fallback.
>
> Another thing I noticed was that HOME_DIR's fallback is "[^/]*", should it
> be +
> instead of *? I dont think it makes a huge difference because then it
> should
> match HOME_ROOT but it still seems wrong.
>

I agree. Moreover empty usernames or usernames with / look wrong to me too.
As refpolicy seems to use "USER" as if there was no slash in it, IMHO I
would suggest using "[^/]+" for %{USERNAME} default value too.

By the way, by grep'ing HOME_DIR in refpolicy I got a hit in a support
script, "support/genhomedircon" [1]. This script is invoked only when
building modular policy and I have not found an easy way to
invoke semanage_genhomedircon() from either the command line or a Python
script. Does this script needs to be updated or is there a way to use
libsemanage implementation instead?

Cheers,
Nicolas

[1]
https://github.com/TresysTechnology/refpolicy/blob/master/support/genhomedircon

--089e01183bc884c0a505303c725f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Apr 8, 2016 at 6:05 PM, Jason Zaman <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:jason@perfinion.com" target=3D"_blank">jason@perfinion.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">Hi all,<br>
<br>
I finally finished adding more templates to genhomedircon and a lot of gene=
ral<br>
cleanups.<br>
<br>
The first few patches refactor the templating functions so they are smaller=
 and<br>
easier to add new. All the common bits were taken out and they all take the=
<br>
user_entry_t struct instead of passing args one by one.<br>
<br>
The last three patches add the new templating types. I went with %{USERID} =
and<br>
%{USERNAME}. They now have a clear start and end unlike USER in the past an=
d $<br>
is end of line in regexes so % seems safer. The matcher for USER now<br>
specifically excludes any line that has the new patterns in it too so there=
 can<br>
be no conflict. It appears to work in the testing I have done with adding<b=
r>
strange fcontexts. make test passes in the repo too but i have not run the =
full<br>
selinux-testsuite.<br></blockquote><div><br></div><div>Hi,</div><div>Thanks=
 for your work. Your patches are very well built and I have been able to te=
st them without any trouble. Here are some comments:</div><div>* In Patch 1=
, the last parameter of write_replacements() can be made a const pointer: &=
quot;const replacement_pair_t *repl&quot; (parameters s and tpl too but the=
re are not currently const pointers).</div><div>* Patch 5 introduces a &quo=
t;gid&quot; field in &quot;struct user_entry&quot;, which is not used in th=
e templates. Why did you introduce it?</div><div>* Patch 7 introduces two f=
unctions,=C2=A0write_username_context and=C2=A0write_userid_context, which =
handle lines containing=C2=A0%{USERNAME} and=C2=A0%{USERID} separately. If =
a line includes both patterns, like &quot;%{USERID}-%{USERNAME}&quot;, the =
generated file will have for root user two lines: one with &quot;%{USERID}-=
root&quot; and the other &quot;0-%{USERNAME}&quot;. As a user I would have =
expected both templates to be replaced. I believe this may be achieved by m=
erging the two predicate functions together (in patch 6), and the substitut=
ions functions too (in patch 7).</div><div>=C2=A0<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
>
<br>
%{USERNAME} defaults to &quot;.*&quot; in the fallback just like USER origi=
nally did<br>
%{USERID} defaults to &quot;[0-9]+&quot; for the fallback.<br>
<br>
Another thing I noticed was that HOME_DIR&#39;s fallback is &quot;[^/]*&quo=
t;, should it be +<br>
instead of *? I dont think it makes a huge difference because then it shoul=
d<br>
match HOME_ROOT but it still seems wrong.<br></blockquote><div><br></div><d=
iv>I agree. Moreover empty usernames or usernames with / look wrong to me t=
oo. As refpolicy seems to use &quot;USER&quot; as if there was no slash in =
it, IMHO I would suggest using &quot;[^/]+&quot; for %{USERNAME} default va=
lue too.</div><div><br></div><div>By the way, by grep&#39;ing HOME_DIR in r=
efpolicy I got a hit in a support script, &quot;support/genhomedircon&quot;=
 [1]. This script is invoked only when building modular policy and I have n=
ot found an easy way to invoke=C2=A0semanage_genhomedircon() from either th=
e command line or a Python script. Does this script needs to be updated or =
is there a way to use libsemanage implementation instead?</div><div><br></d=
iv><div>Cheers,</div><div>Nicolas</div><div><br></div><div>[1]=C2=A0<a href=
=3D"https://github.com/TresysTechnology/refpolicy/blob/master/support/genho=
medircon">https://github.com/TresysTechnology/refpolicy/blob/master/support=
/genhomedircon</a></div></div></div></div>

--089e01183bc884c0a505303c725f--
