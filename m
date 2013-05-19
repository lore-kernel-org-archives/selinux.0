MIME-Version: 1.0
Date: Sun, 19 May 2013 17:10:45 +0400
Message-ID: <CAHw9pMUEcHa_HExVs+yyJOVk8oVEkQ84o4aywemZ+ZvMYT0=LA@mail.gmail.com>
Subject: network, deep drive
From: vlad halilov <vlad.halilov@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7ba9796aa458dd04dd11f171
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7ba9796aa458dd04dd11f171
Content-Type: text/plain; charset=ISO-8859-1

That's some strange issue appears with labeled networking. I tried to test
some basic rules before mlp expreiments, but got unexpected results. Base
configuration (tx-like):

netlabelctl unlbl add interface:eth0
address:0.0.0.0/0label:system_u:object_r:node_t:s1
netlabelctl unlbl add interface:eth0
address:192.168.1.196/0label:system_u:object_r:node_t:s4
netlabelctl map del default
netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
netlabelctl cipsov4 add pass doi:32 tags:1
netlabelctl map add default address:127.0.0.0/8 protocol:cipsov4,32
netlabelctl map add default address:192.168.1.96/32 protocol:cipsov4,32
#eth0

Iptables allowed all, and have no any secmark rules.

So, some examples. Here, i have executed nc in listen: nc -l 5000 with
user_u:user_r:user_t:s4 (additional policy that allow user_u to create
socket, allowing node_t, ingress  & etc in effect)

1) telnet from same user (user_u:user_r:user_t:s4)  and same context is
succesfull. Two way exchange via 127.0.0.1 or 192.168.1.96 interfaces.
Thats right.

2) telnet from external network from host (system_u:object_r:node_t:s4)
same result, two way exchange. That's right too.

3) telnet from external network (system_u:object_r:node_t:s1)  established,
but only one way (s1 -> s4). On trying to send string back from nc to
telnet and got connection closed... that's right from one side of view but
no deny avc in audit. Dontaudit rules disabled. One strange.

4) telnet from same host but user context is ' user_u:user_r:user_t:s1' to
127.0.0.1 or 192.168.1.96 - timed out... hmm.. that's strange. All needed
selinux context is allowed (or we got deny on step 1, but why we got
different result withing step 3? So, second issue.

5) And most strange.... telnet from same host, different user
(user_u:user_r:user_t:s1:c0.c255) to any local address (127 or 192) got an
error: no space left on device . ouch. what device.. what space. space
space, i need space (sorry). No deny avc in log again.. not dependent what
port i connected to, listen or not.. enforcing or permissive. Only one
dependence found:  with interface interface not configured with cipsov4
like above, error did not appear. I tried to some deep drive, so critical
value below:

mls range: s1, s1:c0, s1:c0:c2 ... s1:c0.c239 - working right
mls range: s1:c0.c240 ... s1:c0-c254, s1:c0-c255 - no space left.

Any idea?

--047d7ba9796aa458dd04dd11f171
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s some strange issue appears with labeled network=
ing. I tried to test some basic rules before mlp expreiments, but got unexp=
ected results. Base configuration (tx-like):<div><br></div><div><div>netlab=
elctl unlbl add interface:eth0 address:<a href=3D"http://0.0.0.0/0">0.0.0.0=
/0</a> label:system_u:object_r:node_t:s1</div>
<div>netlabelctl unlbl add interface:eth0 address:<a href=3D"http://192.168=
.1.196/0">192.168.1.196/0</a> label:system_u:object_r:node_t:s4<br></div><d=
iv>netlabelctl map del default</div><div>netlabelctl map add default addres=
s:<a href=3D"http://0.0.0.0/0">0.0.0.0/0</a> protocol:unlbl</div>
<div>netlabelctl cipsov4 add pass doi:32 tags:1=A0</div><div>netlabelctl ma=
p add default address:<a href=3D"http://127.0.0.0/8">127.0.0.0/8</a> protoc=
ol:cipsov4,32</div><div>netlabelctl map add default address:<a href=3D"http=
://192.168.1.96/32">192.168.1.96/32</a> protocol:cipsov4,32 #eth0</div>
</div><div><br></div><div>Iptables allowed all, and have no any secmark rul=
es.</div><div>=A0</div><div>So, some examples. Here, i have executed nc in =
listen: nc -l 5000 with user_u:user_r:user_t:s4 (additional policy that all=
ow user_u to create socket, allowing node_t, ingress =A0&amp; etc in effect=
)</div>
<div><br></div><div>1) telnet from same user (user_u:user_r:user_t:s4) =A0a=
nd same context is succesfull. Two way exchange via 127.0.0.1 or 192.168.1.=
96 interfaces. Thats right.</div><div><br></div><div>2) telnet from externa=
l network from host (system_u:object_r:node_t:s4) same result, two way exch=
ange. That&#39;s right too.</div>
<div><br></div><div>3) telnet from external network (system_u:object_r:node=
_t:s1) =A0established, but only one way (s1 -&gt; s4). On trying to send st=
ring back from nc to telnet and got connection closed... that&#39;s right f=
rom one side of view but no deny avc in audit. Dontaudit rules disabled. On=
e strange.</div>
<div><br></div><div>4) telnet from same host but user context is &#39;=A0us=
er_u:user_r:user_t:s1&#39; to 127.0.0.1 or 192.168.1.96 - timed out... hmm.=
. that&#39;s strange. All needed selinux context is allowed (or we got deny=
 on step 1, but why we got different result withing step 3? So, second issu=
e.</div>
<div><br></div><div>5) And most strange.... telnet from same host, differen=
t user (user_u:user_r:user_t:s1:c0.c255) to any local address (127 or 192) =
got an error: no space left on device . ouch. what device.. what space. spa=
ce space, i need space (sorry). No deny avc in log again.. not dependent wh=
at port i connected to, listen or not.. enforcing or permissive. Only one d=
ependence found: =A0with interface interface not configured with cipsov4 li=
ke above, error did not appear. I tried to some deep drive, so critical val=
ue below:</div>
<div><br></div><div>mls range: s1, s1:c0, s1:c0:c2 ... s1:c0.c239 - working=
 right</div><div>mls range: s1:c0.c240 ... s1:c0-c254, s1:c0-c255 - no spac=
e left.=A0</div><div><br></div><div style>Any idea?</div></div>

--047d7ba9796aa458dd04dd11f171--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
