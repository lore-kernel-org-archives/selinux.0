MIME-Version: 1.0
In-Reply-To: <1337622828.28413.106.camel@moss-pluto>
References: <CAFftDdp7eW0swem7kMD589eQm6LT4pN5yf4-at9wMv1T9wY9rQ@mail.gmail.com>
	<1337622828.28413.106.camel@moss-pluto>
Date: Mon, 21 May 2012 12:05:52 -0700
Message-ID: <CAFftDdpDFf_OhvmV+nMhccode2LRA7JybXR9iZvEv4Fy37WQoQ@mail.gmail.com>
Subject: Re: local_mainfest.xml
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, seandroid@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff1c3d0438d4804c090976f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff1c3d0438d4804c090976f
Content-Type: text/plain; charset=ISO-8859-1

I think that would be ok; I like the 2 files, 3 branches approach with the
names similar to aosp's branch names.

Currently I maintain my own manifest repository that includes some of your
stuff, and I want to keep the manifests up to date and having them in git
would make it much easier. Currently their a logical merge of
local_manifest.xml and default.xml. You could just start with the present
files, I don't need history from before present.

Bill

On Mon, May 21, 2012 at 10:53 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2012-05-21 at 10:22 -0700, William Roberts wrote:
> > Is the local_manifest file under git revision control somewhere that
> > we could track from?
>
> Not presently.  If it would be helpful, we could set one up, but we
> should make sure we work out how it should be organized up front.  At
> present, we provide 6 versions of the local_manifest.xml file.  There
> are three baselines (master, 4.0.3, 4.0.4) and two fetch URLs (one
> git-based and one http-based).  The repo could contain two files
> (local_manifest.xml and local_manifest_http.xml) with three branches
> (master, seandroid-4.0.3, seandroid-4.0.4), thereby mirroring the
> structure of the other git projects.  Is that what you would want?  Did
> you need/want any of the older versions of the files included in the
> history (if so, which ones?) or just start from the current ones?
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--e89a8ff1c3d0438d4804c090976f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think that would be ok; I like the 2 files, 3 branches approach with the =
names=A0similar=A0to aosp&#39;s branch names.=A0<div><br></div><div>Current=
ly I maintain my own manifest repository that includes some of your stuff, =
and I want to keep the manifests up to date and having them in git would ma=
ke it much easier. Currently their a logical merge of local_manifest.xml an=
d default.xml. You could just start with the present files, I don&#39;t nee=
d history from before present.</div>
<div><br></div><div>Bill</div><div><br><div class=3D"gmail_quote">On Mon, M=
ay 21, 2012 at 10:53 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Mon, 2012-05-21 at 10:2=
2 -0700, William Roberts wrote:<br>
&gt; Is the local_manifest file under git revision control somewhere that<b=
r>
&gt; we could track from?<br>
<br>
</div>Not presently. =A0If it would be helpful, we could set one up, but we=
<br>
should make sure we work out how it should be organized up front. =A0At<br>
present, we provide 6 versions of the local_manifest.xml file. =A0There<br>
are three baselines (master, 4.0.3, 4.0.4) and two fetch URLs (one<br>
git-based and one http-based). =A0The repo could contain two files<br>
(local_manifest.xml and local_manifest_http.xml) with three branches<br>
(master, seandroid-4.0.3, seandroid-4.0.4), thereby mirroring the<br>
structure of the other git projects. =A0Is that what you would want? =A0Did=
<br>
you need/want any of the older versions of the files included in the<br>
history (if so, which ones?) or just start from the current ones?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--e89a8ff1c3d0438d4804c090976f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
