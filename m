MIME-Version: 1.0
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Fri, 3 Feb 2017 00:19:32 +0100
Message-ID: <CAJfZ7=mGTk+0Z0Mte5DwWKBVaxxBetp2nF8NtSy1Ha2seGnORA@mail.gmail.com>
Subject: Re: [PATCH 0/5] checkpolicy: Cleanup declare and require functions
To: James Carter <jwcart2@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c1cd198e09f4a054794656a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c1cd198e09f4a054794656a
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 31, 2017 at 8:41 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:

> Cleanup declare and require functions in module_compiler.c to improve
> maintainability and clarity. Functionality is not changed.
>
> James Carter (5):
>   checkpolicy: Create common function for type declares and requires
>   checkpolicy: Create common function for role declares and requires
>   checkpolicy: Create common function for user declares and requires
>   checkpolicy: Cleanup error messages
>   checkpolicy: Move common require and declare code into new function
>
>  checkpolicy/module_compiler.c | 892 +++++++++++++++++++-----------
> ------------
>  1 file changed, 395 insertions(+), 497 deletions(-)
>

Thanks for your patches. I have tested the 8 patches you sent and
everything seems fine: the issue I reported is fixed, there is no new
memory leak, and the code looks right when I read it. I am only wondering
why the new functions create_type(), create_role(), create_user()
and print_error_msg() are not static.

By the way I have been working on integrating this project with Travis-CI
for a few months and now I have a stable working configuration file. I used
it to build-test this patchset with several compilers/linkers. The
(successful) results are available on
https://travis-ci.org/fishilico/selinux/builds/197478803 and the commit
which introduced .travis.yml file is the last one on
https://github.com/fishilico/selinux/commits/2017-01-31_James_Carter_patches
. Would there be an interest to have the Travis-CI configuration file in
the project?

Cheers,
Nicolas

--94eb2c1cd198e09f4a054794656a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jan 31, 2017 at 8:41 PM, James Carter <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jwcart2@tycho.nsa.gov" target=3D"_blank">jwcart2@tycho.nsa.gov</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Clean=
up declare and require functions in module_compiler.c to improve<br>
maintainability and clarity. Functionality is not changed.<br>
<br>
James Carter (5):<br>
=C2=A0 checkpolicy: Create common function for type declares and requires<b=
r>
=C2=A0 checkpolicy: Create common function for role declares and requires<b=
r>
=C2=A0 checkpolicy: Create common function for user declares and requires<b=
r>
=C2=A0 checkpolicy: Cleanup error messages<br>
=C2=A0 checkpolicy: Move common require and declare code into new function<=
br>
<br>
=C2=A0checkpolicy/module_compiler.c | 892 +++++++++++++++++++-----------<wb=
r>------------<br>
=C2=A01 file changed, 395 insertions(+), 497 deletions(-)<br></blockquote><=
div><br></div><div>Thanks for your patches. I have tested the 8 patches you=
 sent and everything seems fine: the issue I reported is fixed, there is no=
 new memory leak, and the code looks right when I read it. I am only wonder=
ing why the new functions create_type(),=C2=A0create_role(), create_user() =
and=C2=A0print_error_msg() are not static.</div><div><br></div><div>By the =
way I have been working on integrating this project with Travis-CI for a fe=
w months and now I have a stable working configuration file. I used it to b=
uild-test this patchset with several compilers/linkers. The (successful) re=
sults are available on=C2=A0<a href=3D"https://travis-ci.org/fishilico/seli=
nux/builds/197478803">https://travis-ci.org/fishilico/selinux/builds/197478=
803</a> and the commit which introduced .travis.yml file is the last one on=
=C2=A0<a href=3D"https://github.com/fishilico/selinux/commits/2017-01-31_Ja=
mes_Carter_patches">https://github.com/fishilico/selinux/commits/2017-01-31=
_James_Carter_patches</a> . Would there be an interest to have the Travis-C=
I configuration file in the project?</div><div><br></div><div>Cheers,</div>=
<div>Nicolas</div></div></div></div>

--94eb2c1cd198e09f4a054794656a--
