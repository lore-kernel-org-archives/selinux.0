MIME-Version: 1.0
In-Reply-To: <1308926890.15355.74.camel@moss-pluto>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	<1308920243.15355.55.camel@moss-pluto>
	<BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	<1308924690.15355.72.camel@moss-pluto>
	<BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	<1308926890.15355.74.camel@moss-pluto>
Date: Fri, 24 Jun 2011 14:52:27 +0000
Message-ID: <BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
Subject: Re: Wrong context for user
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=000325557c86b2122a04a6765987
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000325557c86b2122a04a6765987
Content-Type: multipart/alternative; boundary=000325557c86b2121f04a6765985

--000325557c86b2121f04a6765985
Content-Type: text/plain; charset=ISO-8859-1

attached for your reference.


Regards,
Madhu

On Fri, Jun 24, 2011 at 2:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2011-06-24 at 14:44 +0000, c.r.madhusudhanan@gmail.com wrote:
> > Thanks Daniel, Stephen.
> >
> > I am able to get init_t, local_login_t for init, and login
> > respectively.
> > The mistake was tat I missed relabeling the file system, so all the
> > executable was in the type file_t.
> >
> > But it looks my problem still remains somehow, so that when I try
> > login it still shows me wrong domain/type.
> >
> > When I login using 'login' (tty1), the context shows as
> > user_u:user_r:chkpwd_t and when I check in the X (auto login to user
> > 'meego' using 'uxlaunch') shows as user_u:user_r:consoletype_t.
> >
> > Attached is the "ps -aeZ" after relabeling the system.
>
> What does your default_contexts file contain?
>
> --
> Stephen Smalley
> National Security Agency
>
>

--000325557c86b2121f04a6765985
Content-Type: text/html; charset=ISO-8859-1

attached for your reference.<br><br><br>Regards,<br>Madhu<br><br><div class="gmail_quote">On Fri, Jun 24, 2011 at 2:48 PM, Stephen Smalley <span dir="ltr">&lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class="im">On Fri, 2011-06-24 at 14:44 +0000, <a href="mailto:c.r.madhusudhanan@gmail.com">c.r.madhusudhanan@gmail.com</a> wrote:<br>

&gt; Thanks Daniel, Stephen.<br>
&gt;<br>
&gt; I am able to get init_t, local_login_t for init, and login<br>
&gt; respectively.<br>
&gt; The mistake was tat I missed relabeling the file system, so all the<br>
&gt; executable was in the type file_t.<br>
&gt;<br>
&gt; But it looks my problem still remains somehow, so that when I try<br>
&gt; login it still shows me wrong domain/type.<br>
&gt;<br>
&gt; When I login using &#39;login&#39; (tty1), the context shows as<br>
&gt; user_u:user_r:chkpwd_t and when I check in the X (auto login to user<br>
&gt; &#39;meego&#39; using &#39;uxlaunch&#39;) shows as user_u:user_r:consoletype_t.<br>
&gt;<br>
&gt; Attached is the &quot;ps -aeZ&quot; after relabeling the system.<br>
<br>
</div>What does your default_contexts file contain?<br>
<font color="#888888"><br>
--<br>
</font><div><div></div><div class="h5">Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--000325557c86b2121f04a6765985--

--000325557c86b2122a04a6765987
Content-Type: application/octet-stream; name=seusers
Content-Disposition: attachment; filename=seusers
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpbqoa400

c3lzdGVtX3U6c3lzdGVtX3UKcm9vdDpyb290Cl9fZGVmYXVsdF9fOnVzZXJfdQo=
--000325557c86b2122a04a6765987
Content-Type: application/octet-stream; name=default_contexts
Content-Disposition: attachment; filename=default_contexts
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpbqosp31

c3lzdGVtX3I6Y3JvbmRfdAl1c2VyX3I6Y3JvbmpvYl90IHN0YWZmX3I6Y3JvbmpvYl90IHN5c2Fk
bV9yOmNyb25qb2JfdCBzeXN0ZW1fcjpzeXN0ZW1fY3JvbmRfdCB1bmNvbmZpbmVkX3I6dW5jb25m
aW5lZF9jcm9uam9iX3QKc3lzdGVtX3I6bG9jYWxfbG9naW5fdAl1c2VyX3I6dXNlcl90IHN0YWZm
X3I6c3RhZmZfdCBzeXNhZG1fcjpzeXNhZG1fdCB1bmNvbmZpbmVkX3I6dW5jb25maW5lZF90CnN5
c3RlbV9yOnJlbW90ZV9sb2dpbl90CXVzZXJfcjp1c2VyX3Qgc3RhZmZfcjpzdGFmZl90IHVuY29u
ZmluZWRfcjp1bmNvbmZpbmVkX3QKc3lzdGVtX3I6c3NoZF90CQl1c2VyX3I6dXNlcl90IHN0YWZm
X3I6c3RhZmZfdCBzeXNhZG1fcjpzeXNhZG1fdCB1bmNvbmZpbmVkX3I6dW5jb25maW5lZF90CnN5
c3RlbV9yOnN1bG9naW5fdAlzeXNhZG1fcjpzeXNhZG1fdApzeXN0ZW1fcjp4ZG1fdAkJdXNlcl9y
OnVzZXJfdCBzdGFmZl9yOnN0YWZmX3Qgc3lzYWRtX3I6c3lzYWRtX3QgdW5jb25maW5lZF9yOnVu
Y29uZmluZWRfdAoKc3RhZmZfcjpzdGFmZl9zdV90CXVzZXJfcjp1c2VyX3Qgc3RhZmZfcjpzdGFm
Zl90IHN5c2FkbV9yOnN5c2FkbV90CnN0YWZmX3I6c3RhZmZfc3Vkb190CXN5c2FkbV9yOnN5c2Fk
bV90IHN0YWZmX3I6c3RhZmZfdAoKc3lzYWRtX3I6c3lzYWRtX3N1X3QJdXNlcl9yOnVzZXJfdCBz
dGFmZl9yOnN0YWZmX3Qgc3lzYWRtX3I6c3lzYWRtX3QKc3lzYWRtX3I6c3lzYWRtX3N1ZG9fdAlz
eXNhZG1fcjpzeXNhZG1fdAoKdXNlcl9yOnVzZXJfc3VfdAl1c2VyX3I6dXNlcl90IHN0YWZmX3I6
c3RhZmZfdCBzeXNhZG1fcjpzeXNhZG1fdAp1c2VyX3I6dXNlcl9zdWRvX3QJc3lzYWRtX3I6c3lz
YWRtX3QgdXNlcl9yOnVzZXJfdAo=
--000325557c86b2122a04a6765987--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
