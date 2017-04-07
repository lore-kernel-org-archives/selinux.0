MIME-Version: 1.0
References: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
 <1491594062.20167.4.camel@tycho.nsa.gov>
 <1491595109.20167.6.camel@tycho.nsa.gov>
In-Reply-To: <1491595109.20167.6.camel@tycho.nsa.gov>
From: Dennis Sherrell <sherrellconsulting@gmail.com>
Date: Fri, 07 Apr 2017 20:15:11 +0000
Message-ID: <CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com>
Subject: Re: MLS directory label inheritance rules
To: Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114420f8028955054c9949a6
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114420f8028955054c9949a6
Content-Type: text/plain; charset=UTF-8

In a thread ending with Nick Kravelich's contact infirmation, it was
written:

"
If you write top secret data it should stay top secret even if you're
writing to a folder that is normally reserved for secret data, or perhaps
mixed data. Iirc it uses the MLS of the process when creating the file
entry."

I disagree. Top Secret data shoud not be written to a folder which was not
provisioned for such. Allowing persons or processess of lower
classification access to "containers" with higher clearance requirements
could cause a data spill. Any thoughts as to active handling of such?

Dennis Sherrell
Sherrell Consulting
Bakersfield, California Company #136601
Counter-Terrorism
Cybernetic Countermeasure Developer

On Fri, Apr 7, 2017, 12:55 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2017-04-07 at 15:41 -0400, Stephen Smalley wrote:
> > On Fri, 2017-04-07 at 11:39 -0700, Nick Kralevich wrote:
> > > When a file is created in a directory, the default label for the
> > > file
> > > is based on the label of the enclosing directory (unless something
> > > like setfscreatecon is used). For example:
> > >
> > > bullhead:/ # cd /data/misc/zoneinfo/
> > >
> > > bullhead:/data/misc/zoneinfo # ls -ladZ .
> > > drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
> > > 1971-06-19 17:07 .
> > > bullhead:/data/misc/zoneinfo # touch asdf
> > > bullhead:/data/misc/zoneinfo # ls -ladZ . asdf
> > >
> > > drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
> > > 2017-04-07 18:32 .
> > > -rw-rw-rw- 1 root   root   u:object_r:zoneinfo_data_file:s0    0
> > > 2017-04-07 18:32 asdf
> > >
> > > note how the label of the "asdf" file matches the label of the
> > > enclosing directory.
> > >
> > > However, that's not true when the directory uses categories. In
> > > that
> > > case, the newly created file inherits the label, but not the
> > > categories. For example:
> > >
> > > bullhead:/data/data # cd /data/data/com.android.chrome
> > > bullhead:/data/data/com.android.chrome # ls -ladZ .
> > > drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768
> > > 4096
> > > 1971-07-15 15:31 .
> > > bullhead:/data/data/com.android.chrome # touch asdf
> > > bullhead:/data/data/com.android.chrome # ls -laZd . asdf
> > > drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768
> > > 4096
> > > 2017-04-07 18:35 .
> > > -rw-rw-rw- 1
> > > root   root   u:object_r:app_data_file:s0              0
> > > 2017-04-07 18:35 asdf
> > >
> > > Note how the label is maintained, but the "c512,c768" portion is
> > > not
> > > maintained. While this example occurs when I'm running in a
> > > permissive
> > > domain, it also occurs in an enforcing domain.
> > >
> > > The inconsistency seems weird, and I'm sure there's a good reason
> > > why
> > > this occurs that I'm not familiar with. Can someone help me
> > > understand
> > > if this is expected, and if so, why?
> >
> > First, the good news is that you get to specify which behavior you
> > want
> > for each context field and object class through policy (as long as
> > your
> > kernel and policy version supports it), see:
> > https://selinuxproject.org/page/DefaultRules
> >
> > Second, there are different defaults for each of the fields of the
> > security contexts based on what is most normative for that particular
> > security model.  The user identity defaults to that of the creating
> > process since we typically do not allow a process to create files
> > with
> > a different user identity and want the file to reflect its creator
> > (this is defined through constraints on user identity in policies
> > that
> > define more than one, unlike Android). The role defaults to the fixed
> > object_r role because originally we didn't envision a use case for
> > roles on files.  The MLS range defaults to the low/current level of
> > the
> > process because a process is typically not allowed to create files at
> > a
> > different level and we want the file to reflect the sensitivity of
> > the
> > data which originated from the process. The type defaults to a
> > related
> > object type (in this case that of the parent directory) because
> > process
> > domains and object types are separate (aside from overlapping use for
> > /proc/pid) and the relationships among them are explicit through the
> > TE
> > rules / access matrix rather than through implicit rules.
> >
> > Of course, in addition to being able to globally configure the
> > default
> > behavior, you can also customize specific cases through the
> > role/type/range_transition rules.
> >
> > With your example above, you wanted the file to inherit the level of
> > the directory, but consider the situation where a process with
> > categories (:s0:c512,c768) creates a file in some shared
> > (mlstrustedobject) directory that is just :s0.  Do you want that file
> > to end up as just :s0?  In the MLS world, that would be a downgrade /
> > info leak.
>
> I guess that's not a great example since then the file would also end
> up with the same type by default and thus would be a mlstrustedobject
> and accessible regardless of its level.  So you'd want a type
> transition to a derived type for files created in that directory to
> avoid that.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

--001a114420f8028955054c9949a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">In a thread ending with Nick Kravelich&#39;s contact infirma=
tion, it was written:</p>
<p dir=3D"ltr">&quot;<br>
If you write top secret data it should stay top secret even if you&#39;re w=
riting to a folder that is normally reserved for secret data, or perhaps mi=
xed data. Iirc it uses the MLS of the process when creating the file entry.=
&quot;</p>
<p dir=3D"ltr">I disagree. Top Secret data shoud not be written to a folder=
 which was not provisioned for such. Allowing persons or processess of lowe=
r classification access to &quot;containers&quot; with higher clearance req=
uirements could cause a data spill. Any thoughts as to active handling of s=
uch?</p>
<p dir=3D"ltr">Dennis Sherrell<br>
Sherrell Consulting<br>
Bakersfield, California Company #136601<br>
Counter-Terrorism<br>
Cybernetic Countermeasure Developer</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Apr 7, 2017, 12:55 =
PM Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.g=
ov</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 2017-04-0=
7 at 15:41 -0400, Stephen Smalley wrote:<br class=3D"gmail_msg">
&gt; On Fri, 2017-04-07 at 11:39 -0700, Nick Kralevich wrote:<br class=3D"g=
mail_msg">
&gt; &gt; When a file is created in a directory, the default label for the<=
br class=3D"gmail_msg">
&gt; &gt; file<br class=3D"gmail_msg">
&gt; &gt; is based on the label of the enclosing directory (unless somethin=
g<br class=3D"gmail_msg">
&gt; &gt; like setfscreatecon is used). For example:<br class=3D"gmail_msg"=
>
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; bullhead:/ # cd /data/misc/zoneinfo/<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; bullhead:/data/misc/zoneinfo # ls -ladZ .<br class=3D"gmail_msg">
&gt; &gt; drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096<=
br class=3D"gmail_msg">
&gt; &gt; 1971-06-19 17:07 .<br class=3D"gmail_msg">
&gt; &gt; bullhead:/data/misc/zoneinfo # touch asdf<br class=3D"gmail_msg">
&gt; &gt; bullhead:/data/misc/zoneinfo # ls -ladZ . asdf<br class=3D"gmail_=
msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096<=
br class=3D"gmail_msg">
&gt; &gt; 2017-04-07 18:32 .<br class=3D"gmail_msg">
&gt; &gt; -rw-rw-rw- 1 root=C2=A0=C2=A0=C2=A0root=C2=A0=C2=A0=C2=A0u:object=
_r:zoneinfo_data_file:s0=C2=A0=C2=A0=C2=A0=C2=A00<br class=3D"gmail_msg">
&gt; &gt; 2017-04-07 18:32 asdf<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; note how the label of the &quot;asdf&quot; file matches the label=
 of the<br class=3D"gmail_msg">
&gt; &gt; enclosing directory.<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; However, that&#39;s not true when the directory uses categories. =
In<br class=3D"gmail_msg">
&gt; &gt; that<br class=3D"gmail_msg">
&gt; &gt; case, the newly created file inherits the label, but not the<br c=
lass=3D"gmail_msg">
&gt; &gt; categories. For example:<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; bullhead:/data/data # cd /data/data/com.android.chrome<br class=
=3D"gmail_msg">
&gt; &gt; bullhead:/data/data/com.android.chrome # ls -ladZ .<br class=3D"g=
mail_msg">
&gt; &gt; drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768<=
br class=3D"gmail_msg">
&gt; &gt; 4096<br class=3D"gmail_msg">
&gt; &gt; 1971-07-15 15:31 .<br class=3D"gmail_msg">
&gt; &gt; bullhead:/data/data/com.android.chrome # touch asdf<br class=3D"g=
mail_msg">
&gt; &gt; bullhead:/data/data/com.android.chrome # ls -laZd . asdf<br class=
=3D"gmail_msg">
&gt; &gt; drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768<=
br class=3D"gmail_msg">
&gt; &gt; 4096<br class=3D"gmail_msg">
&gt; &gt; 2017-04-07 18:35 .<br class=3D"gmail_msg">
&gt; &gt; -rw-rw-rw- 1<br class=3D"gmail_msg">
&gt; &gt; root=C2=A0=C2=A0=C2=A0root=C2=A0=C2=A0=C2=A0u:object_r:app_data_f=
ile:s0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00<br class=3D"gmail_msg">
&gt; &gt; 2017-04-07 18:35 asdf<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Note how the label is maintained, but the &quot;c512,c768&quot; p=
ortion is<br class=3D"gmail_msg">
&gt; &gt; not<br class=3D"gmail_msg">
&gt; &gt; maintained. While this example occurs when I&#39;m running in a<b=
r class=3D"gmail_msg">
&gt; &gt; permissive<br class=3D"gmail_msg">
&gt; &gt; domain, it also occurs in an enforcing domain.<br class=3D"gmail_=
msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; The inconsistency seems weird, and I&#39;m sure there&#39;s a goo=
d reason<br class=3D"gmail_msg">
&gt; &gt; why<br class=3D"gmail_msg">
&gt; &gt; this occurs that I&#39;m not familiar with. Can someone help me<b=
r class=3D"gmail_msg">
&gt; &gt; understand<br class=3D"gmail_msg">
&gt; &gt; if this is expected, and if so, why?<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; First, the good news is that you get to specify which behavior you<br =
class=3D"gmail_msg">
&gt; want<br class=3D"gmail_msg">
&gt; for each context field and object class through policy (as long as<br =
class=3D"gmail_msg">
&gt; your<br class=3D"gmail_msg">
&gt; kernel and policy version supports it), see:<br class=3D"gmail_msg">
&gt; <a href=3D"https://selinuxproject.org/page/DefaultRules" rel=3D"norefe=
rrer" class=3D"gmail_msg" target=3D"_blank">https://selinuxproject.org/page=
/DefaultRules</a><br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Second, there are different defaults for each of the fields of the<br =
class=3D"gmail_msg">
&gt; security contexts based on what is most normative for that particular<=
br class=3D"gmail_msg">
&gt; security model.=C2=A0 The user identity defaults to that of the creati=
ng<br class=3D"gmail_msg">
&gt; process since we typically do not allow a process to create files<br c=
lass=3D"gmail_msg">
&gt; with<br class=3D"gmail_msg">
&gt; a different user identity and want the file to reflect its creator<br =
class=3D"gmail_msg">
&gt; (this is defined through constraints on user identity in policies<br c=
lass=3D"gmail_msg">
&gt; that<br class=3D"gmail_msg">
&gt; define more than one, unlike Android). The role defaults to the fixed<=
br class=3D"gmail_msg">
&gt; object_r role because originally we didn&#39;t envision a use case for=
<br class=3D"gmail_msg">
&gt; roles on files.=C2=A0=C2=A0The MLS range defaults to the low/current l=
evel of<br class=3D"gmail_msg">
&gt; the<br class=3D"gmail_msg">
&gt; process because a process is typically not allowed to create files at<=
br class=3D"gmail_msg">
&gt; a<br class=3D"gmail_msg">
&gt; different level and we want the file to reflect the sensitivity of<br =
class=3D"gmail_msg">
&gt; the<br class=3D"gmail_msg">
&gt; data which originated from the process. The type defaults to a<br clas=
s=3D"gmail_msg">
&gt; related<br class=3D"gmail_msg">
&gt; object type=C2=A0(in this case that of the parent directory) because<b=
r class=3D"gmail_msg">
&gt; process<br class=3D"gmail_msg">
&gt; domains and object types are separate (aside from overlapping use for<=
br class=3D"gmail_msg">
&gt; /proc/pid) and the relationships among them are explicit through the<b=
r class=3D"gmail_msg">
&gt; TE<br class=3D"gmail_msg">
&gt; rules / access matrix rather than through implicit rules.<br class=3D"=
gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Of course, in addition to being able to globally configure the<br clas=
s=3D"gmail_msg">
&gt; default<br class=3D"gmail_msg">
&gt; behavior, you can also customize specific cases through the<br class=
=3D"gmail_msg">
&gt; role/type/range_transition rules.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; With your example above, you wanted the file to inherit the level of<b=
r class=3D"gmail_msg">
&gt; the directory, but consider the situation where a process with<br clas=
s=3D"gmail_msg">
&gt; categories (:s0:c512,c768) creates a file in some shared<br class=3D"g=
mail_msg">
&gt; (mlstrustedobject) directory that is just :s0.=C2=A0=C2=A0Do you want =
that file<br class=3D"gmail_msg">
&gt; to end up as just :s0?=C2=A0=C2=A0In the MLS world, that would be a do=
wngrade /<br class=3D"gmail_msg">
&gt; info leak.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
I guess that&#39;s not a great example since then the file would also end<b=
r class=3D"gmail_msg">
up with the same type by default and thus would be a mlstrustedobject<br cl=
ass=3D"gmail_msg">
and accessible regardless of its level.=C2=A0 So you&#39;d want a type<br c=
lass=3D"gmail_msg">
transition to a derived type for files created in that directory to<br clas=
s=3D"gmail_msg">
avoid that.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
Selinux mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:Selinux@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_bla=
nk">Selinux@tycho.nsa.gov</a><br class=3D"gmail_msg">
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" class=3D"gmail_msg" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br=
 class=3D"gmail_msg">
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_blank">Selin=
ux-request@tycho.nsa.gov</a>.</blockquote></div>

--001a114420f8028955054c9949a6--
