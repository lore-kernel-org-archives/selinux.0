Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA6LhxrE021801
 for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2016 16:44:00 -0500
From: Vaughn Clinton <vclinton@msn.com>
To: Dominick Grift <dac.override@gmail.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: setsebool or audit2allow rule
Date: Sun, 6 Nov 2016 21:43:53 +0000
Message-ID: <DM5PR20MB14997374142FEB060A14ABF0CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
References: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>,
 <1ce1961b-6766-6f8f-85d8-e081757174ef@gmail.com>
In-Reply-To: <1ce1961b-6766-6f8f-85d8-e081757174ef@gmail.com>
Content-Type: multipart/alternative;
 boundary="_000_DM5PR20MB14997374142FEB060A14ABF0CEA40DM5PR20MB1499namp_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_DM5PR20MB14997374142FEB060A14ABF0CEA40DM5PR20MB1499namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

No, I'm running FireFox as a normal user.


Thanks for responding.


Cheers,


________________________________
From: Selinux <selinux-bounces@tycho.nsa.gov> on behalf of Dominick Grift <=
dac.override@gmail.com>
Sent: Sunday, November 6, 2016 1:10 PM
To: selinux@tycho.nsa.gov
Subject: Re: setsebool or audit2allow rule

On 11/06/2016 08:58 PM, Vaughn Clinton wrote:
> I'm trying to understand and looking for clarity with future events  when=
 presented with an option to either generate an allow rule using audit2allo=
w or to execute setsebool to resolve an AVC denial, which would be consider=
ed the correct option given the following event below?  I can't seem to fin=
d the answer via Google or maybe I'm phrasing the question incorrectly.
>

Are you running firefox as root? If so, then it might be a better idea
to not run firefox as root.

>
> Thanks in advance.
>
>
> Cheers,
>
>
> *************************************************************************=
******************
>
>
> Here's the query out:
>
>
> sealert -l 4ae65592-42a8-4141-8977-fdef20ee84aa
> SELinux is preventing plugin-containe from using the dac_override capabil=
ity.
>
> *****  Plugin mozplugger (87.7 confidence) suggests   *******************=
*****
>
> If you want to use the plugin package
> Then you must turn off SELinux controls on the Firefox plugins.
> Do
> # setsebool -P unconfined_mozilla_plugin_transition 0
>
> *****  Plugin dac_override (12.1 confidence) suggests   *****************=
*****
>
> If you want to help identify if domain needs this access or you have a fi=
le with the wrong permissions on your system
> Then turn on full auditing to get path information about the offending fi=
le and generate the error again.
> Do
>
> Turn on full auditing
> # auditctl -w /etc/shadow -p w
> Try to recreate AVC. Then execute
> # ausearch -m avc -ts recent
> If you see PATH record check ownership/permissions on file, and fix it,
> otherwise report as a bugzilla.
>
> *****  Plugin catchall (1.66 confidence) suggests   *********************=
*****
>
> If you believe that plugin-containe should have the dac_override capabili=
ty by default.
> Then you should report this as a bug.
> You can generate a local policy module to allow this access.
> Do
> allow this access for now by executing:
> # ausearch -c 'plugin-containe' --raw | audit2allow -M my-plugincontaine
> # semodule -X 300 -i my-plugincontaine.pp
>
>
> Additional Information:
> Source Context                unconfined_u:unconfined_r:mozilla_plugin_t:=
s0-s0:c0.c1023
> Target Context                unconfined_u:unconfined_r:mozilla_plugin_t:=
s0-s0:c0.c1023
> Target Objects                Unknown [ capability ]
> Source                        plugin-containe
> Source Path                   plugin-containe
> Port                          <Unknown>
> Host                          <removed>
> Source RPM Packages
> Target RPM Packages
> Policy RPM                    selinux-policy-3.13.1-191.19.fc24.noarch
> Selinux Enabled               True
> Policy Type                   targeted
> Enforcing Mode                Enforcing
> Host Name                     <removed>
> Platform                      Linux <removed> 4.8.4-200.fc24.x86_64 #1 SM=
P Tue Oct 25 13:06:04 UTC 2016 x86_64 x86_64
> Alert Count                   3
> First Seen                    2016-11-06 10:23:58 MST
> Last Seen                     2016-11-06 10:43:52 MST
> Local ID                      4ae65592-42a8-4141-8977-fdef20ee84aa
>
> Raw Audit Messages
> type=3DAVC msg=3Daudit(1478454232.260:418): avc:  denied  { dac_override =
} for  pid=3D5985 comm=3D"plugin-containe" capability=3D1  scontext=3Duncon=
fined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tcontext=3Dunconfined_=
u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tclass=3Dcapability permissi=
ve=3D0
>
>
> Hash: plugin-containe,mozilla_plugin_t,mozilla_plugin_t,capability,dac_ov=
erride
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
.gov.
>


--
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift


--_000_DM5PR20MB14997374142FEB060A14ABF0CEA40DM5PR20MB1499namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>No, I'm running FireFox as a normal user.&nbsp; <br>
</p>
<p><br>
</p>
<p>Thanks for responding.</p>
<p><br>
</p>
<p>Cheers,<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Selinux &lt;selinux=
-bounces@tycho.nsa.gov&gt; on behalf of Dominick Grift &lt;dac.override@gma=
il.com&gt;<br>
<b>Sent:</b> Sunday, November 6, 2016 1:10 PM<br>
<b>To:</b> selinux@tycho.nsa.gov<br>
<b>Subject:</b> Re: setsebool or audit2allow rule</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 11/06/2016 08:58 PM, Vaughn Clinton wrote:<br>
&gt; I'm trying to understand and looking for clarity with future events&nb=
sp; when presented with an option to either generate an allow rule using au=
dit2allow or to execute setsebool to resolve an AVC denial, which would be =
considered the correct option given the
 following event below?&nbsp; I can't seem to find the answer via Google or=
 maybe I'm phrasing the question incorrectly.<br>
&gt; <br>
<br>
Are you running firefox as root? If so, then it might be a better idea<br>
to not run firefox as root.<br>
<br>
&gt; <br>
&gt; Thanks in advance.<br>
&gt; <br>
&gt; <br>
&gt; Cheers,<br>
&gt; <br>
&gt; <br>
&gt; **********************************************************************=
*********************<br>
&gt; <br>
&gt; <br>
&gt; Here's the query out:<br>
&gt; <br>
&gt; <br>
&gt; sealert -l 4ae65592-42a8-4141-8977-fdef20ee84aa<br>
&gt; SELinux is preventing plugin-containe from using the dac_override capa=
bility.<br>
&gt; <br>
&gt; *****&nbsp; Plugin mozplugger (87.7 confidence) suggests&nbsp;&nbsp; *=
***********************<br>
&gt; <br>
&gt; If you want to use the plugin package<br>
&gt; Then you must turn off SELinux controls on the Firefox plugins.<br>
&gt; Do<br>
&gt; # setsebool -P unconfined_mozilla_plugin_transition 0<br>
&gt; <br>
&gt; *****&nbsp; Plugin dac_override (12.1 confidence) suggests&nbsp;&nbsp;=
 **********************<br>
&gt; <br>
&gt; If you want to help identify if domain needs this access or you have a=
 file with the wrong permissions on your system<br>
&gt; Then turn on full auditing to get path information about the offending=
 file and generate the error again.<br>
&gt; Do<br>
&gt; <br>
&gt; Turn on full auditing<br>
&gt; # auditctl -w /etc/shadow -p w<br>
&gt; Try to recreate AVC. Then execute<br>
&gt; # ausearch -m avc -ts recent<br>
&gt; If you see PATH record check ownership/permissions on file, and fix it=
,<br>
&gt; otherwise report as a bugzilla.<br>
&gt; <br>
&gt; *****&nbsp; Plugin catchall (1.66 confidence) suggests&nbsp;&nbsp; ***=
***********************<br>
&gt; <br>
&gt; If you believe that plugin-containe should have the dac_override capab=
ility by default.<br>
&gt; Then you should report this as a bug.<br>
&gt; You can generate a local policy module to allow this access.<br>
&gt; Do<br>
&gt; allow this access for now by executing:<br>
&gt; # ausearch -c 'plugin-containe' --raw | audit2allow -M my-plugincontai=
ne<br>
&gt; # semodule -X 300 -i my-plugincontaine.pp<br>
&gt; <br>
&gt; <br>
&gt; Additional Information:<br>
&gt; Source Context&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unconfined_u:unconfined_r:mozilla_plugin=
_t:s0-s0:c0.c1023<br>
&gt; Target Context&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unconfined_u:unconfined_r:mozilla_plugin=
_t:s0-s0:c0.c1023<br>
&gt; Target Objects&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unknown [ capability ]<br>
&gt; Source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
plugin-containe<br>
&gt; Source Path&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plugin-containe<br>
&gt; Port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &lt;Unknown&gt;<br>
&gt; Host&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &lt;removed&gt;<br>
&gt; Source RPM Packages<br>
&gt; Target RPM Packages<br>
&gt; Policy RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; selinux-policy-3.13.=
1-191.19.fc24.noarch<br>
&gt; Selinux Enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; True<br>
&gt; Policy Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; targeted<br>
&gt; Enforcing Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enforcing<br>
&gt; Host Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;removed&gt;=
<br>
&gt; Platform&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Linux &lt;=
removed&gt; 4.8.4-200.fc24.x86_64 #1 SMP Tue Oct 25 13:06:04 UTC 2016 x86_6=
4 x86_64<br>
&gt; Alert Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br>
&gt; First Seen&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2016-11-06 10:23:58 =
MST<br>
&gt; Last Seen&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2016-11-06 10:4=
3:52 MST<br>
&gt; Local ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4ae65592-4=
2a8-4141-8977-fdef20ee84aa<br>
&gt; <br>
&gt; Raw Audit Messages<br>
&gt; type=3DAVC msg=3Daudit(1478454232.260:418): avc:&nbsp; denied&nbsp; { =
dac_override } for&nbsp; pid=3D5985 comm=3D&quot;plugin-containe&quot; capa=
bility=3D1&nbsp; scontext=3Dunconfined_u:unconfined_r:mozilla_plugin_t:s0-s=
0:c0.c1023 tcontext=3Dunconfined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c=
1023
 tclass=3Dcapability permissive=3D0<br>
&gt; <br>
&gt; <br>
&gt; Hash: plugin-containe,mozilla_plugin_t,mozilla_plugin_t,capability,dac=
_override<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; Selinux@tycho.nsa.gov<br>
&gt; To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.<br>
&gt; To get help, send an email containing &quot;help&quot; to Selinux-requ=
est@tycho.nsa.gov.<br>
&gt; <br>
<br>
<br>
-- <br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8&nbsp; 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" id=3D"LPlnk307410" previewremoved=3D"true">https://sks-keys=
ervers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR20MB14997374142FEB060A14ABF0CEA40DM5PR20MB1499namp_--
