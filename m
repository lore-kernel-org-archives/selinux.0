MIME-Version: 1.0
Reply-To: efw@eamonwalsh.com
In-Reply-To: <1339508992.8603.YahooMailClassic@web87701.mail.ir2.yahoo.com>
References: <1339508992.8603.YahooMailClassic@web87701.mail.ir2.yahoo.com>
Date: Wed, 13 Jun 2012 00:45:07 -0400
Message-ID: <CAC_5i8GvZKb4z=kaAnqthWk84Jda=9uyBq1sXSQrG9MGZVJGxw@mail.gmail.com>
Subject: Re: Subject: [PATCH 1/1] XSELinux: When SELinux is enabled the
 xserver seg faults
From: Eamon Walsh <ewalsh.mailinglists@gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: xorg-devel@lists.x.org, ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=14dae934111158a56804c2533f76
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae934111158a56804c2533f76
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Looks good to me, although I thought this was handled at the callsites.  I
guess some callsites have been added or changed that pass in the special
ID's.

Acked-by: Eamon Walsh <efw@eamonwalsh.com>


On Tue, Jun 12, 2012 at 9:49 AM, Richard Haines <
richard_c_haines@btinternet.com> wrote:

> This patch was created using xorg-server-1.12.0 source.
>
> When using Fedora 17 with xorg-server-1.12.0 and SELinux is enabled
> ('setsebool xserver_object_manager on') the xserver will not load. The X
> log file has a seg fault pointing to XACE/SELinux. Bug 50641 was raised
> (https://bugs.freedesktop.org/show_bug.cgi?id=50641). The patch below is a
> possible fix.
>
> The bug is caused by X calling XaceHook(XACE_DEVICE_ACCESS, client, ...)
> with a device ID of '1' that is XIAllMasterDevices. It would also happen
> if the device ID = 0 (XIAllDevices).
>
> The only places currently seen calling with a device id=1 are:
> GrabKey - in Xi/exevents.c and AddPassiveGrabToList - in dix/grabs.c
> These start life in ProcXIPassiveGrabDevice (in Xi/xipassivegrab.c) that
> has been called by XIGrabKeycode.
>
> The patch has been tested using the other XI calls that would also impact
> this: XIGrabTouchBegin, XIGrabButton, XIGrabFocusIn and XIGrabEnter with
> and without the correct permissions (grab and freeze) with no problems.
>
> Both possible classes have to be checked (x_keyboard and x_pointer) as it
> is not known whether it is a pointer or keyboard as this info is not
> available. To get this info would require a change to the
> XaceHook(XACE_DEVICE_ACCESS, client, ..) call to pass an additional
> parameter stating the actual devices (that would defeat the objective of
> the XIAllMasterDevices and XIAllDevices dev ids).
>
> Note that there are other devices apart from the keyboard and pointer, for
> example on the test system: DeviceID: 9 is the Integrated_Webcam_1.3M. As
> it is classed as a slave keyboard it is checked.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  Xext/xselinux_hooks.c |   44 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/Xext/xselinux_hooks.c b/Xext/xselinux_hooks.c
> index 0d4c9ab..c2b21d6 100644
> --- a/Xext/xselinux_hooks.c
> +++ b/Xext/xselinux_hooks.c
> @@ -336,9 +336,17 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused,
> pointer calldata)
>     SELinuxAuditRec auditdata = { .client = rec->client, .dev = rec->dev };
>     security_class_t cls;
>     int rc;
> +    DeviceIntPtr dev = NULL;
> +    int i = 0;
>
>     subj = dixLookupPrivate(&rec->client->devPrivates, subjectKey);
> -    obj = dixLookupPrivate(&rec->dev->devPrivates, objectKey);
> +       /*
> +        * The XIAllMasterDevices or XIAllDevices do not have devPrivates
> +        * entries. Therefore dixLookupPrivate for the object is done later
> +        * for these device IDs.
> +        */
> +       if (rec->dev->id != XIAllDevices && rec->dev->id !=
> XIAllMasterDevices)
> +       obj = dixLookupPrivate(&rec->dev->devPrivates, objectKey);
>
>     /* If this is a new object that needs labeling, do it now */
>     if (rec->access_mode & DixCreateAccess) {
> @@ -356,12 +364,38 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused,
> pointer calldata)
>        }
>     }
>
> -    cls = IsPointerDevice(rec->dev) ? SECCLASS_X_POINTER :
> SECCLASS_X_KEYBOARD;
> -    rc = SELinuxDoCheck(subj, obj, cls, rec->access_mode, &auditdata);
> -    if (rc != Success)
> -       rec->status = rc;
> +       if (rec->dev->id != XIAllDevices && rec->dev->id !=
> XIAllMasterDevices) {
> +               cls = IsPointerDevice(rec->dev) ? SECCLASS_X_POINTER :
> SECCLASS_X_KEYBOARD;
> +               rc = SELinuxDoCheck(subj, obj, cls, rec->access_mode,
> &auditdata);
> +               if (rc != Success)
> +                       rec->status = rc;
> +               return;
> +       } else {
> +               /*
> +                * Device ID must be 0 or 1
> +                * We have to check both possible classes as we don't know
> whether it
> +                * was a pointer or keyboard. Therefore all devices are
> checked for:
> +                *              rec->dev->id == XIAllDevices
> +                * and only masters for:
> +                *               rec->dev->id == XIAllMasterDevices
> +                *
> +                * An error is returned should any device fail
> SELinuxDoCheck
> +                */
> +               for (dev = inputInfo.devices; dev; dev = dev->next, i++) {
> +                       if (!IsMaster(dev) && rec->dev->id ==
> XIAllMasterDevices)
> +                               continue;
> +                       cls = IsPointerDevice(dev) ? SECCLASS_X_POINTER :
> SECCLASS_X_KEYBOARD;
> +                       obj = dixLookupPrivate(&dev->devPrivates,
> objectKey);
> +                   rc = SELinuxDoCheck(subj, obj, cls, rec->access_mode,
> &auditdata);
> +                   if (rc != Success) {
> +                               rec->status = rc;
> +                               return;
> +                       }
> +               }
> +       }
>  }
>
> +
>  static void
>  SELinuxSend(CallbackListPtr *pcbl, pointer unused, pointer calldata)
>  {
> --
> 1.7.10.2
>
> _______________________________________________
> xorg-devel@lists.x.org: X.Org development
> Archives: http://lists.x.org/archives/xorg-devel
> Info: http://lists.x.org/mailman/listinfo/xorg-devel
>

--14dae934111158a56804c2533f76
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Looks good to me, although I thought this was handled at the cal=
lsites.=A0 I guess some callsites have been added or changed that pass in t=
he special ID&#39;s.<br><br>Acked-by: Eamon Walsh &lt;<a href=3D"mailto:efw=
@eamonwalsh.com">efw@eamonwalsh.com</a>&gt;<br>
<br><br><div class=3D"gmail_quote">On Tue, Jun 12, 2012 at 9:49 AM, Richard=
 Haines <span dir=3D"ltr">&lt;<a href=3D"mailto:richard_c_haines@btinternet=
.com" target=3D"_blank">richard_c_haines@btinternet.com</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This patch was created using xorg-server-1.1=
2.0 source.<br>
<br>
When using Fedora 17 with xorg-server-1.12.0 and SELinux is enabled<br>
(&#39;setsebool xserver_object_manager on&#39;) the xserver will not load. =
The X<br>
log file has a seg fault pointing to XACE/SELinux. Bug 50641 was raised<br>
(<a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D50641" target=3D=
"_blank">https://bugs.freedesktop.org/show_bug.cgi?id=3D50641</a>). The pat=
ch below is a<br>
possible fix.<br>
<br>
The bug is caused by X calling XaceHook(XACE_DEVICE_ACCESS, client, ...)<br=
>
with a device ID of &#39;1&#39; that is XIAllMasterDevices. It would also h=
appen<br>
if the device ID =3D 0 (XIAllDevices).<br>
<br>
The only places currently seen calling with a device id=3D1 are:<br>
GrabKey - in Xi/exevents.c and AddPassiveGrabToList - in dix/grabs.c<br>
These start life in ProcXIPassiveGrabDevice (in Xi/xipassivegrab.c) that<br=
>
has been called by XIGrabKeycode.<br>
<br>
The patch has been tested using the other XI calls that would also impact<b=
r>
this: XIGrabTouchBegin, XIGrabButton, XIGrabFocusIn and XIGrabEnter with<br=
>
and without the correct permissions (grab and freeze) with no problems.<br>
<br>
Both possible classes have to be checked (x_keyboard and x_pointer) as it<b=
r>
is not known whether it is a pointer or keyboard as this info is not<br>
available. To get this info would require a change to the<br>
XaceHook(XACE_DEVICE_ACCESS, client, ..) call to pass an additional<br>
parameter stating the actual devices (that would defeat the objective of<br=
>
the XIAllMasterDevices and XIAllDevices dev ids).<br>
<br>
Note that there are other devices apart from the keyboard and pointer, for<=
br>
example on the test system: DeviceID: 9 is the Integrated_Webcam_1.3M. As<b=
r>
it is classed as a slave keyboard it is checked.<br>
<br>
Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinte=
rnet.com">richard_c_haines@btinternet.com</a>&gt;<br>
---<br>
=A0Xext/xselinux_hooks.c | =A0 44 +++++++++++++++++++++++++++++++++++++++--=
---<br>
=A01 file changed, 39 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/Xext/xselinux_hooks.c b/Xext/xselinux_hooks.c<br>
index 0d4c9ab..c2b21d6 100644<br>
--- a/Xext/xselinux_hooks.c<br>
+++ b/Xext/xselinux_hooks.c<br>
@@ -336,9 +336,17 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused, p=
ointer calldata)<br>
 =A0 =A0 SELinuxAuditRec auditdata =3D { .client =3D rec-&gt;client, .dev =
=3D rec-&gt;dev };<br>
 =A0 =A0 security_class_t cls;<br>
 =A0 =A0 int rc;<br>
+ =A0 =A0DeviceIntPtr dev =3D NULL;<br>
+ =A0 =A0int i =3D 0;<br>
<br>
 =A0 =A0 subj =3D dixLookupPrivate(&amp;rec-&gt;client-&gt;devPrivates, sub=
jectKey);<br>
- =A0 =A0obj =3D dixLookupPrivate(&amp;rec-&gt;dev-&gt;devPrivates, objectK=
ey);<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* The XIAllMasterDevices or XIAllDevices do not have devPr=
ivates<br>
+ =A0 =A0 =A0 =A0* entries. Therefore dixLookupPrivate for the object is do=
ne later<br>
+ =A0 =A0 =A0 =A0* for these device IDs.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 if (rec-&gt;dev-&gt;id !=3D XIAllDevices &amp;&amp; rec-&gt;d=
ev-&gt;id !=3D XIAllMasterDevices)<br>
+ =A0 =A0 =A0 obj =3D dixLookupPrivate(&amp;rec-&gt;dev-&gt;devPrivates, ob=
jectKey);<br>
<br>
 =A0 =A0 /* If this is a new object that needs labeling, do it now */<br>
 =A0 =A0 if (rec-&gt;access_mode &amp; DixCreateAccess) {<br>
@@ -356,12 +364,38 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused, =
pointer calldata)<br>
 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 }<br>
<br>
- =A0 =A0cls =3D IsPointerDevice(rec-&gt;dev) ? SECCLASS_X_POINTER : SECCLA=
SS_X_KEYBOARD;<br>
- =A0 =A0rc =3D SELinuxDoCheck(subj, obj, cls, rec-&gt;access_mode, &amp;au=
ditdata);<br>
- =A0 =A0if (rc !=3D Success)<br>
- =A0 =A0 =A0 rec-&gt;status =3D rc;<br>
+ =A0 =A0 =A0 if (rec-&gt;dev-&gt;id !=3D XIAllDevices &amp;&amp; rec-&gt;d=
ev-&gt;id !=3D XIAllMasterDevices) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls =3D IsPointerDevice(rec-&gt;dev) ? SECCLA=
SS_X_POINTER : SECCLASS_X_KEYBOARD;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D SELinuxDoCheck(subj, obj, cls, rec-&gt=
;access_mode, &amp;auditdata);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc !=3D Success)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rec-&gt;status =3D rc;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Device ID must be 0 or 1<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We have to check both possible classes a=
s we don&#39;t know whether it<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* was a pointer or keyboard. Therefore all=
 devices are checked for:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0rec-&gt;dev-&=
gt;id =3D=3D XIAllDevices<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and only masters for:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 rec-&gt;dev-=
&gt;id =3D=3D XIAllMasterDevices<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* An error is returned should any device f=
ail SELinuxDoCheck<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (dev =3D inputInfo.devices; dev; dev =3D =
dev-&gt;next, i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!IsMaster(dev) &amp;&amp;=
 rec-&gt;dev-&gt;id =3D=3D XIAllMasterDevices)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cls =3D IsPointerDevice(dev) =
? SECCLASS_X_POINTER : SECCLASS_X_KEYBOARD;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 obj =3D dixLookupPrivate(&amp=
;dev-&gt;devPrivates, objectKey);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D SELinuxDoCheck(subj, obj, cls,=
 rec-&gt;access_mode, &amp;auditdata);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc !=3D Success) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rec-&gt;statu=
s =3D rc;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
=A0}<br>
<br>
+<br>
=A0static void<br>
=A0SELinuxSend(CallbackListPtr *pcbl, pointer unused, pointer calldata)<br>
=A0{<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.10.2<br>
<br>
_______________________________________________<br>
<a href=3D"mailto:xorg-devel@lists.x.org">xorg-devel@lists.x.org</a>: X.Org=
 development<br>
Archives: <a href=3D"http://lists.x.org/archives/xorg-devel" target=3D"_bla=
nk">http://lists.x.org/archives/xorg-devel</a><br>
Info: <a href=3D"http://lists.x.org/mailman/listinfo/xorg-devel" target=3D"=
_blank">http://lists.x.org/mailman/listinfo/xorg-devel</a><br>
</font></span></blockquote></div><br>

--14dae934111158a56804c2533f76--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
