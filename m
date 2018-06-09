Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w595CVA4015959
 for <selinux@tycho.nsa.gov>; Sat, 9 Jun 2018 01:12:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 412nTS2WGbz2Sj4Z
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 05:12:28 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 412nTR3CsKz2Sj4X
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 05:12:27 +0000 (UTC)
Received: by mail-it0-f41.google.com with SMTP id 76-v6so4795756itx.4
 for <selinux@tycho.nsa.gov>; Fri, 08 Jun 2018 22:12:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSTSvekvxv0gq5a1N-kxkd-mGL+SC71ia=2YPVN0R4jAQ@mail.gmail.com>
References: <CANjv_kN3XAjhJZbZ_uTh7aBJ2w3dhmeGrhrLtVvuKuDO_Y0g=A@mail.gmail.com>
 <CAHC9VhQZzKmT1PXjT==3UstqEV47LyfWZwy0yrHJchJLN6kyQA@mail.gmail.com>
 <CAHC9VhSTSvekvxv0gq5a1N-kxkd-mGL+SC71ia=2YPVN0R4jAQ@mail.gmail.com>
From: Sgeeta Dhundale <sgeeta.in@gmail.com>
Date: Sat, 9 Jun 2018 10:42:24 +0530
Message-ID: <CANjv_kN1wXQngtLbcCEoY8j091P508KwYfDh+vmBarxKcna-FQ@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="000000000000e744c5056e2e8f3b"
Subject: Re: selinux-testsuite inet_socket test failure
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000e744c5056e2e8f3b
Content-Type: text/plain; charset="UTF-8"

Thank you Paul for looking at the issue.
Yes I am using RHEL6.9/6.10 and OL6.9/6.10.
I would wait for the fix, hope it will be fixed soon.

On Fri, Jun 8, 2018 at 10:11 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Fri, Jun 8, 2018 at 12:35 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jun 8, 2018 at 9:17 AM, Sgeeta Dhundale <sgeeta.in@gmail.com>
> wrote:
> >> Hi,
> >>   While running selinux testsuits I am seeing some of the inet_socket
> tests
> >> failure.
> >> Googled alotbut couldnt see any similler issue reported as such.
> >> It would be really helpful if you can give some pointer to  resolved
> this.
> >>
> >> Selinux rpms I am using =>
> >> # rpm -qa | grep selinux
> >> libselinux-devel-2.0.94-7.el6.x86_64
> >> libselinux-utils-2.0.94-7.el6.x86_64
> >> selinux-policy-targeted-3.7.19-312.0.1.el6.noarch
> >> libselinux-2.0.94-7.el6.x86_64
> >> selinux-policy-3.7.19-312.0.1.el6.noarch
> >> libselinux-python-2.0.94-7.el6.x86_64
> >> -------------------------------
> >>
> >> Output snippet of test run
> >> chcon -R -t test_file_t .
> >> Running as user root with context unconfined_u:unconfined_r:
> unconfined_t
> >>
> >> .....
> >> ......
> >> dyntrace/test ............ ok
> >> bounds/test .............. ok
> >> mmap/test ................ ok
> >> unix_socket/test ......... ok
> >> inet_socket/test .........
> >> Dubious, test returned 2 (wstat 512, 0x200)
> >> Failed 2/33 subtests
> >> checkreqprot/test ........ ok
> >> mqueue/test .............. skipped: mqueue fileystem not
> supported/mounted
> >> mac_admin/test ........... ok
> >> infiniband_pkey/test ..... ok
> >> infiniband_endport/test .. ok
> >>
> >> Test Summary Report
> >> -------------------
> >> inet_socket/test       (Wstat: 512 Tests: 33 Failed: 2)
> >>   Failed tests:  7, 9
> >>   Non-zero exit status: 2
> >> Files=46, Tests=325, 54 wallclock secs ( 0.27 usr  0.10 sys +  0.76 cusr
> >> 1.46 csys =  2.59 CPU)
> >> Result: FAIL
> >> make: Leaving directory `/root/SELinux/selinux-testsuite-master/tests'
> >> ASSERT:SELinux-Test run failed, pls check testrun.log file for details
> >> expected:<0> but was:<1>
> >> FAILED
> >
> > It looks like you are running RHEL-6.x or CentOS-6.x?
> >
> > I just ran the tests on my RHEL-6.x test system and saw similar
> > results, it appears to be the result of the following commit to the
> > selinux-testsuite:
> >
> >  commit c618ab669b0c580bb3fa000b168d7d4b5a00c5ee
> >  Author: Stephen Smalley <sds@tycho.nsa.gov>
> >  Date:   Thu Oct 26 09:29:37 2017 -0400
> >
> >    selinux-testsuite: inet_socket: tighten checking
> >
> >    As demonstrated by https://github.com/SELinuxProject/selinux-kernel/
> issues/3
> >    the inet_socket tests can "pass" for the wrong reasons.  Change the
> >    client program to use different exit codes for different failures,
> >    and change the test script to check the expected exit code for all
> tests.
> >    With this change, getting an unexpected peer label causes a test
> failure
> >    rather than being treated identically to a permission denial.
> >
> >    NB This could make the tests more fragile, e.g. it appears that we
> encounter
> >    permission denial failures at different points for different tests,
> so we
> >    may need to relax the checking somewhat based on testing a wider
> range of
> >    older kernels.
> >
> >    Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > ... I think we may need to take a closer look at what RHEL-6.x based
> > kernels are currently doing to ensure they are "correct" (I'm going to
> > assume yes, but that is an assumption), and perhaps update the test
> > suite to reflect the RHEL-6.x behavior.
>
> FYI, I created an issue on GH to track this:
>
> * https://github.com/SELinuxProject/selinux-testsuite/issues/37
>
> --
> paul moore
> www.paul-moore.com
>



-- 
Regards,
-Sgeeta

--000000000000e744c5056e2e8f3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Thank you Paul for looking at the issue. <br></d=
iv>Yes I am using RHEL6.9/6.10 and OL6.9/6.10. <br></div><div>I would wait =
for the fix, hope it will be fixed soon. <br></div></div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Fri, Jun 8, 2018 at 10:11 PM, Pa=
ul Moore <span dir=3D"ltr">&lt;<a href=3D"mailto:paul@paul-moore.com" targe=
t=3D"_blank">paul@paul-moore.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Fri, Jun 8, 2018 a=
t 12:35 PM, Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.com">paul@paul=
-moore.com</a>&gt; wrote:<br>
&gt; On Fri, Jun 8, 2018 at 9:17 AM, Sgeeta Dhundale &lt;<a href=3D"mailto:=
sgeeta.in@gmail.com">sgeeta.in@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;=C2=A0 =C2=A0While running selinux testsuits I am seeing some of th=
e inet_socket tests<br>
&gt;&gt; failure.<br>
&gt;&gt; Googled alotbut couldnt see any similler issue reported as such.<b=
r>
&gt;&gt; It would be really helpful if you can give some pointer to=C2=A0 r=
esolved this.<br>
&gt;&gt;<br>
&gt;&gt; Selinux rpms I am using =3D&gt;<br>
&gt;&gt; # rpm -qa | grep selinux<br>
&gt;&gt; libselinux-devel-2.0.94-7.el6.<wbr>x86_64<br>
&gt;&gt; libselinux-utils-2.0.94-7.el6.<wbr>x86_64<br>
&gt;&gt; selinux-policy-targeted-3.7.<wbr>19-312.0.1.el6.noarch<br>
&gt;&gt; libselinux-2.0.94-7.el6.x86_64<br>
&gt;&gt; selinux-policy-3.7.19-312.0.1.<wbr>el6.noarch<br>
&gt;&gt; libselinux-python-2.0.94-7.<wbr>el6.x86_64<br>
&gt;&gt; ------------------------------<wbr>-<br>
&gt;&gt;<br>
&gt;&gt; Output snippet of test run<br>
&gt;&gt; chcon -R -t test_file_t .<br>
&gt;&gt; Running as user root with context unconfined_u:unconfined_r:<wbr>u=
nconfined_t<br>
&gt;&gt;<br>
&gt;&gt; .....<br>
&gt;&gt; ......<br>
&gt;&gt; dyntrace/test ............ ok<br>
&gt;&gt; bounds/test .............. ok<br>
&gt;&gt; mmap/test ................ ok<br>
&gt;&gt; unix_socket/test ......... ok<br>
&gt;&gt; inet_socket/test .........<br>
&gt;&gt; Dubious, test returned 2 (wstat 512, 0x200)<br>
&gt;&gt; Failed 2/33 subtests<br>
&gt;&gt; checkreqprot/test ........ ok<br>
&gt;&gt; mqueue/test .............. skipped: mqueue fileystem not supported=
/mounted<br>
&gt;&gt; mac_admin/test ........... ok<br>
&gt;&gt; infiniband_pkey/test ..... ok<br>
&gt;&gt; infiniband_endport/test .. ok<br>
&gt;&gt;<br>
&gt;&gt; Test Summary Report<br>
&gt;&gt; -------------------<br>
&gt;&gt; inet_socket/test=C2=A0 =C2=A0 =C2=A0 =C2=A0(Wstat: 512 Tests: 33 F=
ailed: 2)<br>
&gt;&gt;=C2=A0 =C2=A0Failed tests:=C2=A0 7, 9<br>
&gt;&gt;=C2=A0 =C2=A0Non-zero exit status: 2<br>
&gt;&gt; Files=3D46, Tests=3D325, 54 wallclock secs ( 0.27 usr=C2=A0 0.10 s=
ys +=C2=A0 0.76 cusr<br>
&gt;&gt; 1.46 csys =3D=C2=A0 2.59 CPU)<br>
&gt;&gt; Result: FAIL<br>
&gt;&gt; make: Leaving directory `/root/SELinux/selinux-<wbr>testsuite-mast=
er/tests&#39;<br>
&gt;&gt; ASSERT:SELinux-Test run failed, pls check testrun.log file for det=
ails<br>
&gt;&gt; expected:&lt;0&gt; but was:&lt;1&gt;<br>
&gt;&gt; FAILED<br>
&gt;<br>
&gt; It looks like you are running RHEL-6.x or CentOS-6.x?<br>
&gt;<br>
&gt; I just ran the tests on my RHEL-6.x test system and saw similar<br>
&gt; results, it appears to be the result of the following commit to the<br=
>
&gt; selinux-testsuite:<br>
&gt;<br>
&gt;=C2=A0 commit c618ab669b0c580bb3fa000b168d7d<wbr>4b5a00c5ee<br>
&gt;=C2=A0 Author: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov"=
>sds@tycho.nsa.gov</a>&gt;<br>
&gt;=C2=A0 Date:=C2=A0 =C2=A0Thu Oct 26 09:29:37 2017 -0400<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 selinux-testsuite: inet_socket: tighten checking<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 As demonstrated by <a href=3D"https://github.com/SELinuxP=
roject/selinux-kernel/issues/3" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/<wbr>SELinuxProject/selinux-kernel/<wbr>issues/3</a><br>
&gt;=C2=A0 =C2=A0 the inet_socket tests can &quot;pass&quot; for the wrong =
reasons.=C2=A0 Change the<br>
&gt;=C2=A0 =C2=A0 client program to use different exit codes for different =
failures,<br>
&gt;=C2=A0 =C2=A0 and change the test script to check the expected exit cod=
e for all tests.<br>
&gt;=C2=A0 =C2=A0 With this change, getting an unexpected peer label causes=
 a test failure<br>
&gt;=C2=A0 =C2=A0 rather than being treated identically to a permission den=
ial.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 NB This could make the tests more fragile, e.g. it appear=
s that we encounter<br>
&gt;=C2=A0 =C2=A0 permission denial failures at different points for differ=
ent tests, so we<br>
&gt;=C2=A0 =C2=A0 may need to relax the checking somewhat based on testing =
a wider range of<br>
&gt;=C2=A0 =C2=A0 older kernels.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Signed-off-by: Stephen Smalley &lt;<a href=3D"mailto:sds@=
tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt;<br>
&gt; ... I think we may need to take a closer look at what RHEL-6.x based<b=
r>
&gt; kernels are currently doing to ensure they are &quot;correct&quot; (I&=
#39;m going to<br>
&gt; assume yes, but that is an assumption), and perhaps update the test<br=
>
&gt; suite to reflect the RHEL-6.x behavior.<br>
<br>
</div></div>FYI, I created an issue on GH to track this:<br>
<br>
* <a href=3D"https://github.com/SELinuxProject/selinux-testsuite/issues/37"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/<wbr>SELinuxProjec=
t/selinux-<wbr>testsuite/issues/37</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-- <br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" rel=3D"noreferrer" target=3D"_blank">=
www.paul-moore.com</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">Regards,<br>-Sgeet=
a<br></div>
</div>

--000000000000e744c5056e2e8f3b--
