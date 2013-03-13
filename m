MIME-Version: 1.0
In-Reply-To: <3265214.svHSTcnaWD@sifl>
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
	<2547229.Czz0AkDGmt@sifl>
	<DA8D339A60101247B36E202899B1C93A7C93C5@CHUNEX01.integrity-apps.com>
	<3265214.svHSTcnaWD@sifl>
Date: Wed, 13 Mar 2013 17:52:51 -0400
Message-ID: <CAOFCXeeoEdMkWze354_Fn=9=3Vv8L_t9sn0vRXY-qGLhvMb2DQ@mail.gmail.com>
Subject: Re: SELinux network labeling
From: Chad Hanson <dahchanson@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Langland, Blake" <blangland@integrity-apps.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=e89a8f3b9bdd75a73e04d7d56d7d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f3b9bdd75a73e04d7d56d7d
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 13, 2013 at 1:55 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Wednesday, March 13, 2013 05:29:47 PM Langland, Blake wrote:twork
> traffic
>
> > The reason I ruled that out IPSec labeling is that we are using Openswan
> for
> > IPSec and it is my understanding after talking with Josh Brindle that
> > labeling is not supported in Openswan. Are there any plans to bring
> labeled
> > associations to Openswan?
>
> I haven't tested it lately but my understanding is that the version of
> Openswan shipped with RHEL6 supports labeled IPsec.  I am unsure about
> other
> distributions.


Openswan supports labeling in RHEL 6, although it looks like there may have
been a policy issue which was probably resolved by RHEL 6.3 from looking at
this Red Hat Bugzilla report:
https://bugzilla.redhat.com/show_bug.cgi?id=748971

--e89a8f3b9bdd75a73e04d7d56d7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Wed, Mar 13, 2013 at 1:55 PM, Paul Moore <span dir=3D"ltr">&lt;<a href=
=3D"mailto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&g=
t;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Wednesday, March 13, 2013 05:29:47 PM=
 Langland, Blake wrote:<span style=3D"color:rgb(34,34,34)">twork traffic</s=
pan><br>
</div><div class=3D"im"><br>
&gt; The reason I ruled that out IPSec labeling is that we are using Opensw=
an for<br>
&gt; IPSec and it is my understanding after talking with Josh Brindle that<=
br>
&gt; labeling is not supported in Openswan. Are there any plans to bring la=
beled<br>
&gt; associations to Openswan?<br>
<br>
</div>I haven&#39;t tested it lately but my understanding is that the versi=
on of<br>
Openswan shipped with RHEL6 supports labeled IPsec. =A0I am unsure about ot=
her<br>
distributions.</blockquote><div><br></div><div style>Openswan supports labe=
ling in RHEL 6, although it looks like there may have been a policy issue w=
hich was probably resolved by RHEL 6.3 from looking at this Red Hat Bugzill=
a report: =A0<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D74897=
1">https://bugzilla.redhat.com/show_bug.cgi?id=3D748971</a></div>
<div>=A0</div></div></div></div>

--e89a8f3b9bdd75a73e04d7d56d7d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
