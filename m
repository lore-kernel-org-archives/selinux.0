Content-Type: multipart/alternative;
 boundary="Apple-Mail=_30D00252-8CD2-4E89-BEF4-CB3335A0BD4D"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Inconsistent RSS on Red Hat 7 but not 6.
From: Todd Rinaldo <toddr@cpanel.net>
In-Reply-To: <035700d1-4630-cd1a-5e8b-d4b9d1a3f5be@tycho.nsa.gov>
Date: Thu, 14 Jul 2016 11:38:41 -0500
Cc: selinux@tycho.nsa.gov
Message-Id: <7B5705B0-4E16-4464-A010-411AFF8086D8@cpanel.net>
References: <D13ED7AE-0CB2-4D6B-8BB2-6C78F16FB46B@cpanel.net>
 <035700d1-4630-cd1a-5e8b-d4b9d1a3f5be@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>


--Apple-Mail=_30D00252-8CD2-4E89-BEF4-CB3335A0BD4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jul 12, 2016, at 2:44 PM, Stephen Smalley <sds@tycho.nsa.gov> =
wrote:
>=20
> On 07/12/2016 11:58 AM, Todd Rinaldo wrote:
>> We keep metrics on our binaries with respect to how much memory
>> they take up at startup time. So for instance if you run ./a.pl
>> --basemem, it grabs the VmRSS value out of /proc/$$/status and
>> exits.
>>=20
>> When we added Red Hat 7 support to our product, we noticed that
>> this value was VERY unstable. After much poking, I accidentally
>> discovered that this was a side effect of having selinux enabled
>> when doing the check.
>>=20
>> When I disable selinux in /etc/selinux/config and reboot, I found
>> that ./a.pl --basemem became much more stable.
>>=20
>> I am guessing something changed between Red Hat 6 and 7 which
>> caused libselinux to map differently into the address space. I'm
>> however not ruling out a libc change. Can anyone shed light on this
>> or point me to something that would indicate why? For reference,
>> this is libselinux 2.2.2 vs 2.0.94.
>=20
> Can you provide more details, e.g a reproducer without needing your
> particular binaries or a.pl?

Heh. I should have known this would have been asked. I'll try to get you =
a reproducible test case by next week.

Thanks,
Todd=

--Apple-Mail=_30D00252-8CD2-4E89-BEF4-CB3335A0BD4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jul 12, 2016, at 2:44 PM, Stephen Smalley &lt;<a =
href=3D"mailto:sds@tycho.nsa.gov" class=3D"">sds@tycho.nsa.gov</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">On 07/12/2016 11:58 AM, Todd Rinaldo =
wrote:</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">We keep =
metrics on our binaries with respect to how much memory<br class=3D"">they=
 take up at startup time. So for instance if you run ./a.pl<br =
class=3D"">--basemem, it grabs the VmRSS value out of /proc/$$/status =
and<br class=3D"">exits.<br class=3D""><br class=3D"">When we added Red =
Hat 7 support to our product, we noticed that<br class=3D"">this value =
was VERY unstable. After much poking, I accidentally<br =
class=3D"">discovered that this was a side effect of having selinux =
enabled<br class=3D"">when doing the check.<br class=3D""><br =
class=3D"">When I disable selinux in /etc/selinux/config and reboot, I =
found<br class=3D"">that ./a.pl --basemem became much more stable.<br =
class=3D""><br class=3D"">I am guessing something changed between Red =
Hat 6 and 7 which<br class=3D"">caused libselinux to map differently =
into the address space. I'm<br class=3D"">however not ruling out a libc =
change. Can anyone shed light on this<br class=3D"">or point me to =
something that would indicate why? For reference,<br class=3D"">this is =
libselinux 2.2.2 vs 2.0.94.<br class=3D""></blockquote><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Can you provide =
more details, e.g a reproducer without needing your</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">particular binaries =
or a.pl?</span></div></blockquote></div><br class=3D""><div =
class=3D"">Heh. I should have known this would have been asked. I'll try =
to get you a reproducible test case by next week.</div><div class=3D""><br=
 class=3D""></div><div class=3D"">Thanks,</div><div =
class=3D"">Todd</div></body></html>=

--Apple-Mail=_30D00252-8CD2-4E89-BEF4-CB3335A0BD4D--
