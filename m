MIME-Version: 1.0
In-Reply-To: <CAHC9VhRGLbjN-U0-_Cx1j7Wmuz1u0JT1o4U0uf5aQeYLXamUpA@mail.gmail.com>
References: <CADs1-60DRNHOU2-k93oOTRRmYk4YtXP=af6cRhsK=Kwd+_t_3A@mail.gmail.com>
 <570E99A8.5000101@tycho.nsa.gov> <570E9E79.9000105@tycho.nsa.gov>
 <CAHC9VhRGLbjN-U0-_Cx1j7Wmuz1u0JT1o4U0uf5aQeYLXamUpA@mail.gmail.com>
Date: Thu, 14 Apr 2016 01:33:52 +0100
Message-ID: <CADs1-60rr4GRZeu2v8mBWMOYbjcq5mhHRCOM8ohREcV=g9j0pA@mail.gmail.com>
Subject: Re: Failure in sel_netport_sid_slow()
From: Greg <gkubok@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c05231e7db3ae0530670c6f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c05231e7db3ae0530670c6f
Content-Type: text/plain; charset=UTF-8

On 13 April 2016 at 22:36, Paul Moore <paul@paul-moore.com> wrote:

> On Wed, Apr 13, 2016 at 3:31 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > Looking at the sel_netport_sid_slow() code, I don't see why we need to
> > fail hard if the kzalloc() of the new node fails; we just won't be able
> > to cache the result but can still obtain and return the SID.  Paul, do
> > you see any reason we can't just move up the call to security_port_sid()
> > and only fail if that fails?  In the common case, that won't require
> > memory allocation at all (only needs it if it hasn't previously mapped
> > the resulting context to a SID).  In the same manner, we do not fail
> > just because we cannot add an entry to the AVC.  The same should apply
> > to netnode and netif caches.
>
> Sounds reasonable to me, I'll post a RFC patch in just a minute ... it
> will be RFC because it will be completely untested, once I've had a
> chance to test it I'll merge it.
>
> > That said, it seems hard to envision that kzalloc() failing and being
> > able to complete the bind() operation at all, but maybe it is a
> > transient failure.
>
> Agreed, although it might be that the rest of the allocations in the
> network stack are done with something other than GFP_ATOMIC, not sure
> off the top of my head.


It doesn't appear to be a memory constrain. My initial report was from an
EC2 instance with 4GiB memory, a "t2.medium" (but plenty left, JupyterHub's
footprint is minimal, overall ~3.1GiB still spare after everything is
started). I also just tried on a new "m4.4xlarge" with 64GiB memory, same
problem.

It's very difficult to replicate outside of the first run of the 2 Ansible
roles on a fresh instance. On one instance, I was able to replicate it 4
more times after rebooting, by either running just a couple of last tasks
from role 1, and the first task from role 2, or by running equivalent
commands directly (*). But, I can't replicate it anymore (despite more
reboots, resetting SE bools etc), and unable to replicate on any other
identical instances, so it's 100% repeatable when I build brand new
instance and run the 2 roles for the first time (without any additional
waits), but after that, very hard to trigger.

(*) I ran something like this, where first parentheses pair corresponds
with last 2 tasks of role 1, and second pair with first task of role 2, and
I run them in parallel to simulate second role starting while first is
still finishing or at least systemd still starting the service --
"(sss_cache -E && systemctl restart sssd oddjobd; systemctl restart
jupyterhub) & (setsebool -P httpd_can_network_connect 1 && setsebool -P
httpd_can_network_relay 1)". Initially I thought SSS might have something
to do with this, but not sure anymore.

I also added "strace" to the systemd unit definition for JupyterHub and
spun new instances, but as "strace" adds quite a lot of overhead and
therefore time/delay, everything suddenly just works, so I can't witness
the ENOMEM in a trace unfortunately. For sanity I tried yet another build
with "strace" removed again, and the issue is back.

If you're changing it to soft failure, that will save the bind in user
space and it'll silently succeed I'm assuming, but based on the above, the
root cause that triggers this in the first place might be something
different than not enough system memory.

Thanks,

Greg.

--94eb2c05231e7db3ae0530670c6f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 1=
3 April 2016 at 22:36, Paul Moore <span dir=3D"ltr">&lt;<a href=3D"mailto:p=
aul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style=
:solid;padding-left:1ex"><span class=3D"">On Wed, Apr 13, 2016 at 3:31 PM, =
Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov<=
/a>&gt; wrote:<br>
&gt; Looking at the sel_netport_sid_slow() code, I don&#39;t see why we nee=
d to<br>
&gt; fail hard if the kzalloc() of the new node fails; we just won&#39;t be=
 able<br>
&gt; to cache the result but can still obtain and return the SID.=C2=A0 Pau=
l, do<br>
&gt; you see any reason we can&#39;t just move up the call to security_port=
_sid()<br>
&gt; and only fail if that fails?=C2=A0 In the common case, that won&#39;t =
require<br>
&gt; memory allocation at all (only needs it if it hasn&#39;t previously ma=
pped<br>
&gt; the resulting context to a SID).=C2=A0 In the same manner, we do not f=
ail<br>
&gt; just because we cannot add an entry to the AVC.=C2=A0 The same should =
apply<br>
&gt; to netnode and netif caches.<br>
<br>
</span>Sounds reasonable to me, I&#39;ll post a RFC patch in just a minute =
... it<br>
will be RFC because it will be completely untested, once I&#39;ve had a<br>
chance to test it I&#39;ll merge it.<br>
<span class=3D""><br>
&gt; That said, it seems hard to envision that kzalloc() failing and being<=
br>
&gt; able to complete the bind() operation at all, but maybe it is a<br>
&gt; transient failure.<br>
<br>
</span>Agreed, although it might be that the rest of the allocations in the=
<br>
network stack are done with something other than GFP_ATOMIC, not sure<br>
off the top of my head.=C2=A0</blockquote><div><br></div><div>It doesn&#39;=
t appear to be a memory constrain. My initial report was from an EC2 instan=
ce with 4GiB memory, a &quot;t2.medium&quot; (but plenty left, JupyterHub&#=
39;s footprint is minimal, overall ~3.1GiB still spare after everything is =
started). I also just tried on a new &quot;m4.4xlarge&quot; with 64GiB memo=
ry, same problem.<div><br></div><div>It&#39;s very difficult to replicate o=
utside of the first run of the 2 Ansible roles on a fresh instance. On one =
instance, I was able to replicate it 4 more times after rebooting, by eithe=
r running just a couple of last tasks from role 1, and the first task from =
role 2, or by running equivalent commands directly (*). But, I can&#39;t re=
plicate it anymore (despite more reboots, resetting SE bools etc), and unab=
le to replicate on any other identical instances, so it&#39;s 100% repeatab=
le when I build brand new instance and run the 2 roles for the first time (=
without any additional waits), but after that, very hard to trigger.</div><=
/div><div><br></div><div>(*) I ran something like this, where first parenth=
eses pair corresponds with last 2 tasks of role 1, and second pair with fir=
st task of role 2, and I run them in parallel to simulate second role start=
ing while first is still finishing or at least systemd still starting the s=
ervice -- &quot;(sss_cache -E &amp;&amp; systemctl restart sssd oddjobd; sy=
stemctl restart jupyterhub) &amp; (setsebool -P httpd_can_network_connect 1=
 &amp;&amp; setsebool -P httpd_can_network_relay 1)&quot;. Initially I thou=
ght SSS might have something to do with this, but not sure anymore.</div><d=
iv><br></div><div>I also added &quot;strace&quot; to the systemd unit defin=
ition for JupyterHub and spun new instances, but as &quot;strace&quot; adds=
 quite a lot of overhead and therefore time/delay, everything suddenly just=
 works, so I can&#39;t witness the ENOMEM in a trace unfortunately. For san=
ity I tried yet another build with &quot;strace&quot; removed again, and th=
e issue is back.</div><div><br></div><div>If you&#39;re changing it to soft=
 failure, that will save the bind in user space and it&#39;ll silently succ=
eed I&#39;m assuming, but based on the above, the root cause that triggers =
this in the first place might be something different than not enough system=
 memory.</div><div><br></div><div>Thanks,</div><div><br></div><div>Greg.</d=
iv></div></div></div>

--94eb2c05231e7db3ae0530670c6f--
