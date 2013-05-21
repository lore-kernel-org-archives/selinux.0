MIME-Version: 1.0
In-Reply-To: <2466345.2mjuuyBiSJ@sifl>
References: <CAHw9pMUEcHa_HExVs+yyJOVk8oVEkQ84o4aywemZ+ZvMYT0=LA@mail.gmail.com>
	<2466345.2mjuuyBiSJ@sifl>
Date: Tue, 21 May 2013 23:26:55 +0400
Message-ID: <CAHw9pMXbShFc9SPf-gD9baPn3Bq98_jfMyVS3B1WijcOyF5nyg@mail.gmail.com>
Subject: Re: network, deep drive
From: vlad halilov <vlad.halilov@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013cb9e0a8fc6a04dd3f6e71
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--089e013cb9e0a8fc6a04dd3f6e71
Content-Type: text/plain; charset=ISO-8859-1

> A few comments on your configuration below ...
>
> > netlabelctl unlbl add interface:eth0 address:0.0.0.0/0
> >       label:system_u:object_r:node_t:s1
> > netlabelctl unlbl add interface:eth0
> >       address:192.168.1.196/0 label:system_u:object_r:node_t:s4
>
> Generally node_t is used for network nodes while netif_t is used for
> interfaces.  I would recommend changing from "node_t:s1" to "netif_t:s1"
> and
> "node_t:s4" to "netif_t:s4".
>

Ok, i note that. Btw, is this reference is actual
http://marc.info/?l=selinux&m=119991234501200&w=2 ? Selinux extremaly need
faq/best practice network guide. It's absence cause a basic error in
network configuration like mine . Just audit2allow recommend to allow that,
that that and that - so we just do it, don't think what and for what...

>
> Also just for clarification, you do realize that 0.0.0.0/0 and
> 192.168.1.196/0
> are the same, yes?  In fact, you shouldn't even be able to configure the
> above
> you should get an "netlabelctl:error, File exists" error message (I do on
> my
> RHEL6 system).  Perhaps a cut-and-paste error when writing your email?
>

Sure, it's a typo. I mean 192.168.1.196/32.


> > 3) telnet from external network (system_u:object_r:node_t:s1)
>  established,
> > but only one way (s1 -> s4). On trying to send string back from nc to
> > telnet and got connection closed... that's right from one side of view
> but
> > no deny avc in audit. Dontaudit rules disabled. One strange.
>
> I assume that the external network/host is unlabeled and you are using the
> static/fallback labeling to label the incoming traffic?  If so, could you
> first correct your static/fallback configuration (see above) and try again?
>

I changed type to netif_t and that avc found in audit:

type=AVC msg=audit(1369158708.220:821): avc:  denied  { write } for
 pid=2440 comm="nc" path="socket:[19743]" dev=sockfs ino=19743
scontext=user_u:user_r:user_t:s4 tcontext=user_u:user_r:user_t:s1
tclass=tcp_socket

You right, i connected from unlabeled network from address with :s4 label,
and used only static/fallback. So, now that look right. :s4 can not write
to socket that connected to :s1 endpoint and avc present. Reverse channel
s1->s4 is allowed.


>
> > 4) telnet from same host but user context is ' user_u:user_r:user_t:s1'
> to
> > 127.0.0.1 or 192.168.1.96 - timed out... hmm.. that's strange. All needed
> > selinux context is allowed (or we got deny on step 1, but why we got
> > different result withing step 3? So, second issue.
>
> Any AVC denials?
>

Yeah, that it:

type=AVC msg=audit(1369160107.877:926): avc:  denied  { recv } for
 saddr=127.0.0.1 src=5000 daddr=127.0.0.1 dest=390         19 netif=lo
scontext=user_u:user_r:user_t:s1
tcontext=system_u:object_r:netlabel_peer_t:s4 tclass=peer


audit2allow make a rule:
------------------------------------------------------------------

module netlabpeer 1.0;

require {
        type netlabel_peer_t;
        type user_t;
        class peer recv;
}

#============= user_t ==============

#!!!! This avc is a constraint violation.  You will need to add an
attribute to either the source or target type to make it work.
#Contraint rule:
allow user_t netlabel_peer_t:peer recv;
------------------------------------------------------------------

That look right (i see  warning of course, but not sure what it sign) but
selinux have own point of view, and deny avc repeated in audit.. Early, i
think that deny caused by 's1->s4' connection, but i have established
channel with permissive mode, after that switch selinux  to enforcing and
got result like (3 - one way channel). So,  this rule is realy constraint
violation and telnet can't establish connection by disallowed context
access, not a label ...


>
> > 5) And most strange.... telnet from same host, different user
> > (user_u:user_r:user_t:s1:c0.c255) to any local address (127 or 192) got
> an
> > error: no space left on device . ouch. what device.. what space. space
> > space, i need space (sorry).
>
> You configured CIPSO to use only tag type #1 which is limited to categories
> c0.c240.  If you want to use more than that you will need to look at the
> other
> tag types: enumerated (#2) or ranged (#5).  Note that you can specify a
> prioritized list of CIPSO tags in your netlabelctl command line, e.g.
> 'tags:2,5,1'; see the man page and the CIPSO draft specification[1] for
> more
> details.
>
> [1]
> http://netlabel.sourceforge.net/files/draft-ietf-cipso-ipsecurity-01.txt


Now clear, thanks.

--089e013cb9e0a8fc6a04dd3f6e71
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
A few comments on your configuration below ...<br>
<div class=3D"im"><br>
&gt; netlabelctl unlbl add interface:eth0 address:<a href=3D"http://0.0.0.0=
/0" target=3D"_blank">0.0.0.0/0</a><br>
&gt; =A0 =A0 =A0 label:system_u:object_r:node_t:s1<br>
&gt; netlabelctl unlbl add interface:eth0<br>
&gt; =A0 =A0 =A0 address:<a href=3D"http://192.168.1.196/0" target=3D"_blan=
k">192.168.1.196/0</a> label:system_u:object_r:node_t:s4<br>
<br>
</div>Generally node_t is used for network nodes while netif_t is used for<=
br>
interfaces. =A0I would recommend changing from &quot;node_t:s1&quot; to &qu=
ot;netif_t:s1&quot; and<br>
&quot;node_t:s4&quot; to &quot;netif_t:s4&quot;.<br></blockquote><div style=
><br></div><div style>Ok, i note that. Btw, is this reference is actual <a =
href=3D"http://marc.info/?l=3Dselinux&amp;m=3D119991234501200&amp;w=3D2">ht=
tp://marc.info/?l=3Dselinux&amp;m=3D119991234501200&amp;w=3D2</a> ? Selinux=
 extremaly need faq/best practice network guide. It&#39;s absence cause a b=
asic error in network configuration like mine . Just audit2allow recommend =
to allow that, that that and that - so we just do it, don&#39;t think what =
and for what...</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
Also just for clarification, you do realize that <a href=3D"http://0.0.0.0/=
0" target=3D"_blank">0.0.0.0/0</a> and <a href=3D"http://192.168.1.196/0" t=
arget=3D"_blank">192.168.1.196/0</a><br>
are the same, yes? =A0In fact, you shouldn&#39;t even be able to configure =
the above<br>
you should get an &quot;netlabelctl:error, File exists&quot; error message =
(I do on my<br>
RHEL6 system). =A0Perhaps a cut-and-paste error when writing your email?<br=
></blockquote><div>=A0</div><div style>Sure, it&#39;s a typo. I mean <a hre=
f=3D"http://192.168.1.196/32">192.168.1.196/32</a>.</div><div style><br></d=
iv>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<div class=3D"im"><br></div><div class=3D"im">
&gt; 3) telnet from external network (system_u:object_r:node_t:s1) =A0estab=
lished,<br>
&gt; but only one way (s1 -&gt; s4). On trying to send string back from nc =
to<br>
&gt; telnet and got connection closed... that&#39;s right from one side of =
view but<br>
&gt; no deny avc in audit. Dontaudit rules disabled. One strange.<br>
<br>
</div>I assume that the external network/host is unlabeled and you are usin=
g the<br>
static/fallback labeling to label the incoming traffic? =A0If so, could you=
<br>
first correct your static/fallback configuration (see above) and try again?=
<br></blockquote><div><br></div><div style>I changed type to netif_t and th=
at avc found in audit:</div><div style><div><br></div><div>type=3DAVC msg=
=3Daudit(1369158708.220:821): avc: =A0denied =A0{ write } for =A0pid=3D2440=
 comm=3D&quot;nc&quot; path=3D&quot;socket:[19743]&quot; dev=3Dsockfs ino=
=3D19743 scontext=3Duser_u:user_r:user_t:s4 tcontext=3Duser_u:user_r:user_t=
:s1 tclass=3Dtcp_socket</div>
<div><br></div><div style>You right, i connected from unlabeled network fro=
m address with :s4 label, and used only static/fallback. So, now that look =
right. :s4 can not write to socket that connected to :s1 endpoint and avc p=
resent. Reverse channel s1-&gt;s4 is allowed.</div>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; 4) telnet from same host but user context is &#39; user_u:user_r:user_=
t:s1&#39; to<br>
&gt; 127.0.0.1 or 192.168.1.96 - timed out... hmm.. that&#39;s strange. All=
 needed<br>
&gt; selinux context is allowed (or we got deny on step 1, but why we got<b=
r>
&gt; different result withing step 3? So, second issue.<br>
<br>
</div>Any AVC denials?<br></blockquote><div><br></div><div style>Yeah, that=
 it:</div><div style><br></div><div style>type=3DAVC msg=3Daudit(1369160107=
.877:926): avc: =A0denied =A0{ recv } for =A0saddr=3D127.0.0.1 src=3D5000 d=
addr=3D127.0.0.1 dest=3D390 =A0 =A0 =A0 =A0 19 netif=3Dlo scontext=3Duser_u=
:user_r:user_t:s1 tcontext=3Dsystem_u:object_r:netlabel_peer_t:s4 tclass=3D=
peer<br>
</div><div style><br></div><div style><br></div><div style>audit2allow make=
 a rule:</div><div style>--------------------------------------------------=
----------------<br></div><div style><br></div><div style><div>module netla=
bpeer 1.0;</div>
<div><br></div><div>require {</div><div>=A0 =A0 =A0 =A0 type netlabel_peer_=
t;</div><div>=A0 =A0 =A0 =A0 type user_t;</div><div>=A0 =A0 =A0 =A0 class p=
eer recv;</div><div>}</div><div><br></div><div>#=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><b=
r>
</div><div>#!!!! This avc is a constraint violation. =A0You will need to ad=
d an attribute to either the source or target type to make it work.</div><d=
iv>#Contraint rule:</div><div>allow user_t netlabel_peer_t:peer recv;</div>
<div>------------------------------------------------------------------</di=
v><div><br></div><div style>That look right (i see =A0warning of course, bu=
t not sure what it sign) but selinux have own point of view, and deny avc r=
epeated in audit.. Early, i think that deny caused by &#39;s1-&gt;s4&#39; c=
onnection, but i have established channel with permissive mode, after that =
switch selinux =A0to enforcing and got result like (3 - one way channel). S=
o, =A0this rule is realy constraint violation and telnet can&#39;t establis=
h connection by disallowed context access, not a label ...=A0</div>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; 5) And most strange.... telnet from same host, different user<br>
&gt; (user_u:user_r:user_t:s1:c0.c255) to any local address (127 or 192) go=
t an<br>
&gt; error: no space left on device . ouch. what device.. what space. space=
<br>
&gt; space, i need space (sorry).<br>
<br>
</div>You configured CIPSO to use only tag type #1 which is limited to cate=
gories<br>
c0.c240. =A0If you want to use more than that you will need to look at the =
other<br>
tag types: enumerated (#2) or ranged (#5). =A0Note that you can specify a<b=
r>
prioritized list of CIPSO tags in your netlabelctl command line, e.g.<br>
&#39;tags:2,5,1&#39;; see the man page and the CIPSO draft specification[1]=
 for more<br>
details.<br>
<br>
[1] <a href=3D"http://netlabel.sourceforge.net/files/draft-ietf-cipso-ipsec=
urity-01.txt" target=3D"_blank">http://netlabel.sourceforge.net/files/draft=
-ietf-cipso-ipsecurity-01.txt</a></blockquote><div style><br></div><div sty=
le>
Now clear, thanks.</div><div style><br></div></div></div></div>

--089e013cb9e0a8fc6a04dd3f6e71--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
