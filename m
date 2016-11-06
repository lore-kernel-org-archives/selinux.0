Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA6JwlwD013540
 for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2016 14:58:47 -0500
From: Vaughn Clinton <vclinton@msn.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: setsebool or audit2allow rule
Date: Sun, 6 Nov 2016 19:58:43 +0000
Message-ID: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_DM5PR20MB1499D8228FF526F3A78CA3C4CEA40DM5PR20MB1499namp_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_DM5PR20MB1499D8228FF526F3A78CA3C4CEA40DM5PR20MB1499namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm trying to understand and looking for clarity with future events  when p=
resented with an option to either generate an allow rule using audit2allow =
or to execute setsebool to resolve an AVC denial, which would be considered=
 the correct option given the following event below?  I can't seem to find =
the answer via Google or maybe I'm phrasing the question incorrectly.


Thanks in advance.


Cheers,


***************************************************************************=
****************


Here's the query out:


sealert -l 4ae65592-42a8-4141-8977-fdef20ee84aa
SELinux is preventing plugin-containe from using the dac_override capabilit=
y.

*****  Plugin mozplugger (87.7 confidence) suggests   *********************=
***

If you want to use the plugin package
Then you must turn off SELinux controls on the Firefox plugins.
Do
# setsebool -P unconfined_mozilla_plugin_transition 0

*****  Plugin dac_override (12.1 confidence) suggests   *******************=
***

If you want to help identify if domain needs this access or you have a file=
 with the wrong permissions on your system
Then turn on full auditing to get path information about the offending file=
 and generate the error again.
Do

Turn on full auditing
# auditctl -w /etc/shadow -p w
Try to recreate AVC. Then execute
# ausearch -m avc -ts recent
If you see PATH record check ownership/permissions on file, and fix it,
otherwise report as a bugzilla.

*****  Plugin catchall (1.66 confidence) suggests   ***********************=
***

If you believe that plugin-containe should have the dac_override capability=
 by default.
Then you should report this as a bug.
You can generate a local policy module to allow this access.
Do
allow this access for now by executing:
# ausearch -c 'plugin-containe' --raw | audit2allow -M my-plugincontaine
# semodule -X 300 -i my-plugincontaine.pp


Additional Information:
Source Context                unconfined_u:unconfined_r:mozilla_plugin_t:s0=
-s0:c0.c1023
Target Context                unconfined_u:unconfined_r:mozilla_plugin_t:s0=
-s0:c0.c1023
Target Objects                Unknown [ capability ]
Source                        plugin-containe
Source Path                   plugin-containe
Port                          <Unknown>
Host                          <removed>
Source RPM Packages
Target RPM Packages
Policy RPM                    selinux-policy-3.13.1-191.19.fc24.noarch
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Enforcing
Host Name                     <removed>
Platform                      Linux <removed> 4.8.4-200.fc24.x86_64 #1 SMP =
Tue Oct 25 13:06:04 UTC 2016 x86_64 x86_64
Alert Count                   3
First Seen                    2016-11-06 10:23:58 MST
Last Seen                     2016-11-06 10:43:52 MST
Local ID                      4ae65592-42a8-4141-8977-fdef20ee84aa

Raw Audit Messages
type=3DAVC msg=3Daudit(1478454232.260:418): avc:  denied  { dac_override } =
for  pid=3D5985 comm=3D"plugin-containe" capability=3D1  scontext=3Dunconfi=
ned_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:=
unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tclass=3Dcapability permissive=
=3D0


Hash: plugin-containe,mozilla_plugin_t,mozilla_plugin_t,capability,dac_over=
ride


--_000_DM5PR20MB1499D8228FF526F3A78CA3C4CEA40DM5PR20MB1499namp_
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
<p>I'm trying to understand and looking for clarity with future events&nbsp=
; when presented with an option to either generate an allow rule using audi=
t2allow or to execute setsebool to resolve an AVC denial, which would be co=
nsidered the correct option given the
 following event below?&nbsp; I can't seem to find the answer via Google or=
 maybe I'm phrasing the question incorrectly.&nbsp;
<br>
</p>
<p><br>
</p>
<p>Thanks in advance.</p>
<p><br>
</p>
<p>Cheers,<br>
</p>
<p><br>
</p>
<p>************************************************************************=
*******************<br>
</p>
<p><br>
</p>
<p>Here's the query out:</p>
<p><br>
</p>
<p></p>
<div><span style=3D"background-color: rgb(255, 255, 0);">sealert -l 4ae6559=
2-42a8-4141-8977-fdef20ee84aa</span><br>
SELinux is preventing plugin-containe from using the dac_override capabilit=
y.<br>
<br>
*****&nbsp; Plugin mozplugger (87.7 confidence) suggests&nbsp;&nbsp; ******=
******************<br>
<br>
If you want to use the plugin package<br>
Then you must turn off SELinux controls on the Firefox plugins.<br>
Do<br>
# <span style=3D"background-color: rgb(255, 255, 0);">setsebool -P unconfin=
ed_mozilla_plugin_transition 0</span><br>
<br>
*****&nbsp; Plugin dac_override (12.1 confidence) suggests&nbsp;&nbsp; ****=
******************<br>
<br>
If you want to help identify if domain needs this access or you have a file=
 with the wrong permissions on your system<br>
Then turn on full auditing to get path information about the offending file=
 and generate the error again.<br>
Do<br>
<br>
Turn on full auditing<br>
# auditctl -w /etc/shadow -p w<br>
Try to recreate AVC. Then execute<br>
# ausearch -m avc -ts recent<br>
If you see PATH record check ownership/permissions on file, and fix it,<br>
otherwise report as a bugzilla.<br>
<br>
*****&nbsp; Plugin catchall (1.66 confidence) suggests&nbsp;&nbsp; ********=
******************<br>
<br>
If you believe that plugin-containe should have the dac_override capability=
 by default.<br>
Then you should report this as a bug.<br>
You can generate a local policy module to allow this access.<br>
Do<br>
allow this access for now by executing:<br>
# <span style=3D"background-color: rgb(255, 255, 0);">ausearch -c 'plugin-c=
ontaine' --raw | audit2allow -M my-plugincontaine</span><br>
# semodule -X 300 -i my-plugincontaine.pp<br>
<br>
<br>
Additional Information:<br>
Source Context&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unconfined_u:unconfined_r:mozilla_plugin_t:s0=
-s0:c0.c1023<br>
Target Context&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unconfined_u:unconfined_r:mozilla_plugin_t:s0=
-s0:c0.c1023<br>
Target Objects&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unknown [ capability ]<br>
Source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plugi=
n-containe<br>
Source Path&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plugin-containe<br>
Port&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &lt;Unknown&gt;<br>
Host&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &lt;removed&gt;<br>
Source RPM Packages&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;<br>
Target RPM Packages&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;<br>
Policy RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; selinux-policy-3.13.1-191=
.19.fc24.noarch<br>
Selinux Enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; True<br>
Policy Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; targeted<br>
Enforcing Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enforcing<br>
Host Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;removed&gt;<br>
Platform&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Linux &lt;remov=
ed&gt; 4.8.4-200.fc24.x86_64 #1 SMP Tue Oct 25 13:06:04 UTC 2016 x86_64 x86=
_64<br>
Alert Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br>
First Seen&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2016-11-06 10:23:58 MST<b=
r>
Last Seen&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2016-11-06 10:43:52 =
MST<br>
Local ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4ae65592-42a8-4=
141-8977-fdef20ee84aa<br>
<br>
Raw Audit Messages<br>
type=3DAVC msg=3Daudit(1478454232.260:418): avc:&nbsp; denied&nbsp; { dac_o=
verride } for&nbsp; pid=3D5985 comm=3D&quot;plugin-containe&quot; capabilit=
y=3D1&nbsp; scontext=3Dunconfined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.=
c1023 tcontext=3Dunconfined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 =
tclass=3Dcapability
 permissive=3D0<br>
<br>
<br>
Hash: plugin-containe,mozilla_plugin_t,mozilla_plugin_t,capability,dac_over=
ride<br>
</div>
<br>
<p></p>
</div>
</body>
</html>

--_000_DM5PR20MB1499D8228FF526F3A78CA3C4CEA40DM5PR20MB1499namp_--
