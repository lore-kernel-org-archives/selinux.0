MIME-Version: 1.0
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66612A3B13@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <5548BA95.2040908@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66611C4336@SC-VEXCH4.marvell.com>
 <554A06E8.8030202@tycho.nsa.gov>
 <F766E4F80769BD478052FB6533FA745D66612A3B13@SC-VEXCH4.marvell.com>
Date: Wed, 6 May 2015 21:02:07 -0700
Message-ID: <CAFftDdpctax+VBs713L2UdtQvZB_RurcwtaWN_QyGxHrCpYSOg@mail.gmail.com>
Subject: Re: Give out all the avc logs in ome time
From: William Roberts <bill.c.roberts@gmail.com>
To: Zhi Xin <xinzhi@marvell.com>
Content-Type: multipart/alternative; boundary=047d7b5d824dacdd32051575f943
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b5d824dacdd32051575f943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2015 at 8:18 PM, Zhi Xin <xinzhi@marvell.com> wrote:

> Thanks a lot~
>
> I have another question: in last email, you mentioned two ways to
> eliminate the ratelimit.
>
> (1) disable the audit ratelimit in logd by removing the
> AUDIT_STATUS_RATE_LIMIT flag from status.mask.
> (2) use the kernel
> https://bitbucket.org/seandroid/kernel-msm/commits/0388e1630648c481e42929=
135babb1dbba272e27
>
> I can understand how the kernel part work. But why do you still need to
> set a user space process like logd ? I mean the avc log is given by kerne=
l.
> Why a user space process can affect its output ? Is is because the kernel
> log brought to user by this logd and if I want to disable audit ratelimit=
,
> I have to apply both of them ?
>

If their is no audit daemon (userspace) running, the audit subsystem of the
kernel just simple printk's it to the kernel log. If their is a userspace
daemon running, it sends it via the audit netlink to the userspace daemon,
in this case logd. This is used in desktop distro's to send the logs over
the network, or to disk. In logd, it merges it into the logcat stream. The
audit subsystem was designed to be a flexible way to not only record
information from the LSM's, but also other features. You can enable things
like syscall auditing, in which more comprehensive records can be derived,
as well as set filters and watches.


>
> I also wonder do we have a more simple mechanism like a open/off switch
> during runtime ?
>

As in, we get denials messages or we don't? I think audit kernel has the
capability to filter on records, but the userspace support was never
brought into Android fully. When I had the auditd code on 4.3 base, some
contributions were added to be able to set watches and filters IIRC.


>
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: 2015=E5=B9=B45=E6=9C=886=E6=97=A5 20:20
> To: Zhi Xin; selinux@tycho.nsa.gov
> Cc: seandroid-list@tycho.nsa.gov
> Subject: Re: Give out all the avc logs in ome time
>
> On 05/05/2015 10:18 PM, Zhi Xin wrote:
> > Hi Stephen,
> >
> > Thanks a lot for the suggestion. I will try them later. I have another
> question for this audit ratelimit. Why not always disable it ? Too much
> printk come up ?
>
> In general, the printk and audit ratelimits are to prevent a denial of
> service (DOS) by flooding the system with too many messages/denials.  In
> the case of Android, they started setting the audit ratelimit in logd
> (starting with 5.1.0) because of reported crashes that _might_ have been
> due to a large number of SELinux denials flooding the serial console and
> ultimately leading to a watchdog reset, although I am not sure if the exa=
ct
> cause was ever fully confirmed.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.




--=20
Respectfully,

William C Roberts

--047d7b5d824dacdd32051575f943
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 6, 2015 at 8:18 PM, Zhi Xin <span dir=3D"ltr">&lt;<a href=
=3D"mailto:xinzhi@marvell.com" target=3D"_blank">xinzhi@marvell.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Thanks a lot~<br>
<br>
I have another question: in last email, you mentioned two ways to eliminate=
 the ratelimit.<br>
<br>
(1) disable the audit ratelimit in logd by removing the AUDIT_STATUS_RATE_L=
IMIT flag from status.mask.<br>
(2) use the kernel <a href=3D"https://bitbucket.org/seandroid/kernel-msm/co=
mmits/0388e1630648c481e42929135babb1dbba272e27" target=3D"_blank">https://b=
itbucket.org/seandroid/kernel-msm/commits/0388e1630648c481e42929135babb1dbb=
a272e27</a><br>
<br>
I can understand how the kernel part work. But why do you still need to set=
 a user space process like logd ? I mean the avc log is given by kernel. Wh=
y a user space process can affect its output ? Is is because the kernel log=
 brought to user by this logd and if I want to disable audit ratelimit, I h=
ave to apply both of them ?<br></blockquote><div><br></div><div>If their is=
 no audit daemon (userspace) running, the audit subsystem of the kernel jus=
t simple printk&#39;s it to the kernel log. If their is a userspace daemon =
running, it sends it via the audit netlink to the userspace daemon, in this=
 case logd. This is used in desktop distro&#39;s to send the logs over the =
network, or to disk. In logd, it merges it into the logcat stream. The audi=
t subsystem was designed to be a flexible way to not only record informatio=
n from the LSM&#39;s, but also other features. You can enable things like s=
yscall auditing, in which more comprehensive records can be derived, as wel=
l as set filters and watches.=C2=A0</div><div>=C2=A0<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
I also wonder do we have a more simple mechanism like a open/off switch dur=
ing runtime ?<br></blockquote><div><br></div><div>As in, we get denials mes=
sages or we don&#39;t? I think audit kernel has the capability to filter on=
 records, but the userspace support was never brought into Android fully. W=
hen I had the auditd code on 4.3 base, some contributions were added to be =
able to set watches and filters IIRC.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
-----Original Message-----<br>
From: Stephen Smalley [mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tych=
o.nsa.gov</a>]<br>
Sent: 2015=E5=B9=B45=E6=9C=886=E6=97=A5 20:20<br>
To: Zhi Xin; <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov=
</a><br>
Cc: <a href=3D"mailto:seandroid-list@tycho.nsa.gov">seandroid-list@tycho.ns=
a.gov</a><br>
Subject: Re: Give out all the avc logs in ome time<br>
<br>
On 05/05/2015 10:18 PM, Zhi Xin wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
&gt; Thanks a lot for the suggestion. I will try them later. I have another=
 question for this audit ratelimit. Why not always disable it ? Too much pr=
intk come up ?<br>
<br>
In general, the printk and audit ratelimits are to prevent a denial of serv=
ice (DOS) by flooding the system with too many messages/denials.=C2=A0 In t=
he case of Android, they started setting the audit ratelimit in logd (start=
ing with 5.1.0) because of reported crashes that _might_ have been due to a=
 large number of SELinux denials flooding the serial console and ultimately=
 leading to a watchdog reset, although I am not sure if the exact cause was=
 ever fully confirmed.<br>
<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</blockqu=
ote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_s=
ignature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--047d7b5d824dacdd32051575f943--
