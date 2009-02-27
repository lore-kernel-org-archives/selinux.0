MIME-Version: 1.0
In-Reply-To: <1235744081.26843.17.camel@localhost.localdomain>
References: <e768086c0902270357w2b34b11rebd3e8a98c58877a@mail.gmail.com>
	 <1235744081.26843.17.camel@localhost.localdomain>
Date: Fri, 27 Feb 2009 20:53:40 +0500
Message-ID: <e768086c0902270753n3f16bbb6la8883bc4f7992073@mail.gmail.com>
Subject: Re: refpolicy compilation issue
From: "Kirill \"REDbyte\" Novikov" <redbyte.labs@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636c5a9b1fc69d10463e8786a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5a9b1fc69d10463e8786a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks, Stephen, it's much clearer with warnings. As for refpolicy version
and config - I'm trying to build refpolicy-2.20081210, with default
build.conf, just:
# make conf ; make policy

BTW, policy.conf contains lots of garbage. Is it OK?  Here is what's around
line 7140 of policy.conf

##### begin init_sigchld(amavis_t) depth: 2
#line 11

#line 11

#line 11

#line 11

#line 11
                        require {
#line 11

#line 11
                type init_t;
#line 11

#line 11
                        } # end require
#line 11

#line 11

#line 11

#line 11

#line 11
        allow amavis_t init_t:process sigchld;
#line 11

#line 11

#line 11
##### end init_sigchld(amavis_t) depth: 1

Regards,

Kirill Novikov,
EastLinux Team


On Fri, Feb 27, 2009 at 7:14 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2009-02-27 at 16:57 +0500, Kirill "REDbyte" Novikov wrote:
> > Hi there everyone!
> >
> > I'm got a strange problem compiling latest refpolicy (as well as all
> > other versions), found nothing alike on the mailing lists, so maybe
> > someone from here would help me.
> >
> > Policy compilation fails like this:
> >
> > Creating refpolicy policy.conf
> > cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
> > tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
> > policy.conf
> > Compiling refpolicy policy.23
> >
> > WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set
> > correctly?
> >
> > /usr/bin/checkpolicy policy.conf -o policy.23
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > policy/modules/services/amavis.te":11:ERROR 'syntax error' at token
> > ':' on line 7140:
> >         allow amavis_t init_t:process sigchld;
> > #line 11
> > checkpolicy:  error(s) encountered while parsing configuration
> > make: *** [policy.23] Error 1
> >
> > I'm using latest development versions of SELinux stuff, available from
> > Tresys' trac. I have checked /selinux/policyvers and it contains 24 -
> > but latest policy version supported by checkpolicy 2.0.16 is 23. Have
> > any ideas?
>
> The policy version mismatch warning is just a warning, not a fatal
> error.  The later compilation error in amavis.te looks unrelated and is
> presumably due to something wrong in the lines preceding that statement
> in policy.conf.
>
> Are you trying to build the last release of refpolicy
> (refpolicy-2.20081210) or the svn trunk?  What are your build.conf
> settings or command-line overrides to make?
>
> To generate policy.24, you'd need to build checkpolicy from the git
> development repository rather than using the last released version.
> But that shouldn't be necessary to build refpolicy, and although your
> kernel supports policy.24, it will accept policy.23 as well.  So I
> wouldn't bother changing your version of checkpolicy - I don't think it
> is related to the error.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--001636c5a9b1fc69d10463e8786a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks, Stephen, it&#39;s much clearer with warnings. As for refpolicy
version and config - I&#39;m trying to build refpolicy-2.20081210, with
default build.conf, just: <br># make conf ; make policy<br><br>BTW, policy.=
conf contains lots of garbage. Is it OK?=A0 Here is what&#39;s around line =
7140 of policy.conf<br>
<br><span style=3D"font-family: courier new,monospace;">##### begin init_si=
gchld(amavis_t) depth: 2</span><br style=3D"font-family: courier new,monosp=
ace;"><span style=3D"font-family: courier new,monospace;">#line 11</span><b=
r style=3D"font-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">#line 11</span><br style=3D"font-family: courier=
 new,monospace;"><br style=3D"font-family: courier new,monospace;"><span st=
yle=3D"font-family: courier new,monospace;">#line 11</span><br style=3D"fon=
t-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">#line 11</span><br style=3D"font-family: courier=
 new,monospace;"><br style=3D"font-family: courier new,monospace;"><span st=
yle=3D"font-family: courier new,monospace;">#line 11</span><br style=3D"fon=
t-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 require {</span><br style=
=3D"font-family: courier new,monospace;"><span style=3D"font-family: courie=
r new,monospace;">#line 11</span><br style=3D"font-family: courier new,mono=
space;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">#line 11</span><br style=3D"font-family: courier=
 new,monospace;"><span style=3D"font-family: courier new,monospace;">=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type init_t;</span><br style=3D"fon=
t-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">#line 11</span><br styl=
e=3D"font-family: courier new,monospace;"><br style=3D"font-family: courier=
 new,monospace;"><span style=3D"font-family: courier new,monospace;">#line =
11</span><br style=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } # end require</span><br =
style=3D"font-family: courier new,monospace;"><span style=3D"font-family: c=
ourier new,monospace;">#line 11</span><br style=3D"font-family: courier new=
,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">#line 11</span><br style=3D"font-family: courier=
 new,monospace;"><br style=3D"font-family: courier new,monospace;"><span st=
yle=3D"font-family: courier new,monospace;">#line 11</span><br style=3D"fon=
t-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">#line 11</span><br style=3D"font-family: courier=
 new,monospace;"><br style=3D"font-family: courier new,monospace;"><span st=
yle=3D"font-family: courier new,monospace;">#line 11</span><div class=3D"Ih=
2E3d">
<br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 a=
llow amavis_t init_t:process sigchld;</span><br style=3D"font-family: couri=
er new,monospace;"><span style=3D"font-family: courier new,monospace;">#lin=
e 11</span><br style=3D"font-family: courier new,monospace;">

<br style=3D"font-family: courier new,monospace;"></div><span style=3D"font=
-family: courier new,monospace;">#line 11</span><br style=3D"font-family: c=
ourier new,monospace;"><br style=3D"font-family: courier new,monospace;"><s=
pan style=3D"font-family: courier new,monospace;">#line 11</span><br style=
=3D"font-family: courier new,monospace;">

<span style=3D"font-family: courier new,monospace;">##### end init_sigchld(=
amavis_t) depth: 1</span><div class=3D"Ih2E3d"><br><br>Regards,<br><br>Kiri=
ll Novikov,<br>EastLinux Team</div><br><br><div class=3D"gmail_quote">On Fr=
i, Feb 27, 2009 at 7:14 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"Wj3C7c">On Fri, 2009-02-27 at 16:57 +0500, Kirill &quot;REDbyt=
e&quot; Novikov wrote:<br>

&gt; Hi there everyone!<br>
&gt;<br>
&gt; I&#39;m got a strange problem compiling latest refpolicy (as well as a=
ll<br>
&gt; other versions), found nothing alike on the mailing lists, so maybe<br=
>
&gt; someone from here would help me.<br>
&gt;<br>
&gt; Policy compilation fails like this:<br>
&gt;<br>
&gt; Creating refpolicy policy.conf<br>
&gt; cat tmp/pre_te_files.conf tmp/all_attrs_types.conf<br>
&gt; tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf &gt;<br=
>
&gt; policy.conf<br>
&gt; Compiling refpolicy policy.23<br>
&gt;<br>
&gt; WARNING: Policy version mismatch! =A0Is your OUTPUT_POLICY set<br>
&gt; correctly?<br>
&gt;<br>
&gt; /usr/bin/checkpolicy policy.conf -o policy.23<br>
&gt; /usr/bin/checkpolicy: =A0loading policy configuration from policy.conf=
<br>
&gt; policy/modules/services/amavis.te&quot;:11:ERROR &#39;syntax error&#39=
; at token<br>
&gt; &#39;:&#39; on line 7140:<br>
&gt; =A0 =A0 =A0 =A0 allow amavis_t init_t:process sigchld;<br>
&gt; #line 11<br>
&gt; checkpolicy: =A0error(s) encountered while parsing configuration<br>
&gt; make: *** [policy.23] Error 1<br>
&gt;<br>
&gt; I&#39;m using latest development versions of SELinux stuff, available =
from<br>
&gt; Tresys&#39; trac. I have checked /selinux/policyvers and it contains 2=
4 -<br>
&gt; but latest policy version supported by checkpolicy 2.0.16 is 23. Have<=
br>
&gt; any ideas?<br>
<br>
</div></div>The policy version mismatch warning is just a warning, not a fa=
tal<br>
error. =A0The later compilation error in amavis.te looks unrelated and is<b=
r>
presumably due to something wrong in the lines preceding that statement<br>
in policy.conf.<br>
<br>
Are you trying to build the last release of refpolicy<br>
(refpolicy-2.20081210) or the svn trunk? =A0What are your build.conf<br>
settings or command-line overrides to make?<br>
<br>
To generate policy.24, you&#39;d need to build checkpolicy from the git<br>
development repository rather than using the last released version.<br>
But that shouldn&#39;t be necessary to build refpolicy, and although your<b=
r>
kernel supports policy.24, it will accept policy.23 as well. =A0So I<br>
wouldn&#39;t bother changing your version of checkpolicy - I don&#39;t thin=
k it<br>
is related to the error.<br>
<font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></blockquote></div><br>

--001636c5a9b1fc69d10463e8786a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
