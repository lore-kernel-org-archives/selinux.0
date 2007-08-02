Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7272A8b026602
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 03:02:10 -0400
Received: from web34809.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l727292K012015
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 07:02:09 GMT
Date: Thu, 2 Aug 2007 00:01:53 -0700 (PDT)
From: Louis Lam <lshoujun@yahoo.com>
Subject: Re: Containing vmware player 2.0.0 with SELINUX
To: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-501328788-1186038113=:47348"
Message-ID: <47609.47348.qm@web34809.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-501328788-1186038113=:47348
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,=0A=0AToday i managed to make the vmplayer run in its own domain. Wh=
at I did was added the statement to my vmware.te. Thanks to Ken and his sug=
gestion (and all of the help so far), i've got the "Selinux by example" boo=
k that i've been reading as a reference. =0A=0Adomain_auto_trans(unconfined=
_t, vmware_exec_t, vmware_t)=0A=0AEvident from the large amount of avc deni=
als in setroubleshoot when i launch vmplayer, i was able to see that vmplay=
er was running in the context of :=0A=0Aroot:system_r:vmware_t=0A=0ATwo que=
stions from security angle on this approach though:=0A=0A1. If i allow tran=
sition from unconfined_t to vmware_t, it means that any unconfined process =
can transit to vmware_t and be able to access the vmware files. This is pro=
bably not what i'd desire. What would be a good recommendation for this? An=
y best practices?=0A=0A2. I still want to start vmware as a user program, p=
robably not as a service. In that case, would I still need to do something =
in the vmware.if so that the domain auto trans can take on a role ?=0A=0ANo=
w that i'm able to run it under vmware_t domain, and see a lot of avcs, i i=
ntend to make vmware run properly again. I'd go with allowing whatever vmwa=
re wants to do, then tightening the security. There are a few approaches i =
can use, and i'd like to seek your opinions on how to go about doing it:=0A=
=0A1. audit2allow: This will list all of the avcs and turn them into allow =
statements. By adding these statements to my vmware.te, this would enable v=
mware to function again. Problem is that i may end up with too many stateme=
nts. There would probably be macros to cover these.=0A=0A2. macros: This is=
 somethings i'm not familiar with. Are there any documentation that describ=
e some of the more commonly used macros? Or it is better just to see the so=
urce?=0A=0A3. policygentool: From what i understand, this is a script that =
would generate a module for you. the question is how do i combine  it with =
the vmware source code that I've taken from the reference policy? (that i'm=
 using now)? I forsee a lot of conflicts to be resolved. and may actually n=
ot be so clean.=0A=0AWhats your take on these approach? Are there others th=
at I've missed out?=0A=0AThanks in advance,=0ALouis=0A=0A----- Original Mes=
sage ----=0AFrom: Ken YANG <spng.yang@gmail.com>=0ATo: Louis Lam <lshoujun@=
yahoo.com>=0ACc: Daniel J Walsh <dwalsh@redhat.com>; fedora-selinux-list@re=
dhat.com=0ASent: Tuesday, July 31, 2007 6:00:20 AM=0ASubject: Re: Containin=
g vmware player 2.0.0 with SELINUX=0A=0ALouis Lam wrote:=0A> Hi, =0A> =0A> =
Thanks for the reply.=0A> =0A> My conclusion is that not I'm not sure where=
 to place the domain_auto_trans() statement. If I can't place it in the vmw=
are.if file(since it will not be read during module compilation ) where can=
 I put this statement? All i need to do now is to make the vmware executabl=
e run in its own domain e.g. vmware_t. But it seems more difficult than I t=
hought. =0A=0Aif you want vmware program run in own domain, all necessary r=
ules=0Ashould be in te file, e.g.=0A=0Adomain_auto_trans(vmware_t, vmware_h=
ost_exec_t, vmware_host_t)=0A(just a example)=0A=0Asimilarly, domain_auto_t=
rans can also used in if file, especially used=0Ain per_role_template. All =
these are depend on your purpose.=0A=0Ato make vmware run in selinux-policy=
>3.0, the easiest way is to=0Afollow what tom guid, i.e. modify the net-ser=
vice.sh to restorce=0Alabel after creating device node.=0A=0Abut if you wan=
t to make policy contain vmware, you must resolve=0Athe "device node label"=
 problem, IMHO, you should use fs_use_trans=0Ato make label automatically:=
=0A=0Ahttp://marc.info/?l=3Dselinux&m=3D118481693028190&w=3D2=0A=0Anow, i h=
ave not time to do this, so i have not solved the problems=0Ai encountered.=
=0A=0A=0A> =0A> Can you point me to resources to how to develop modules? Ca=
n someone help me with this problem?=0A=0A"Beginning is the most difficult =
one, but A Good Beginning is half=0Athe battle" :-)=0A=0Aafter you finish t=
he beginning, you will find it's not difficult.=0A=0AThe book <<SELinux by =
example>> is a good guide for developing modules,=0Abut i think the best gu=
ide to develop policy is the policy source.=0A=0A=0A=0A> =0A> Thanks & Rega=
rds,=0A> Louis=0A> =0A> ----- Original Message ----=0A> From: Ken YANG <spn=
g.yang@gmail.com>=0A> To: Louis Lam <lshoujun@yahoo.com>=0A> Cc: Daniel J W=
alsh <dwalsh@redhat.com>; fedora-selinux-list@redhat.com=0A> Sent: Monday, =
July 30, 2007 6:53:17 AM=0A> Subject: Re: Containing vmware player 2.0.0 wi=
th SELINUX=0A> =0A> Louis Lam wrote:=0A>> Hi,=0A>>=0A>> I think i'm having =
a policy compilation problem here=0A>>=0A>> I've moved the domain_auto_tran=
s($1_t, vmware_exec_t, $1_vmware_t) statement to vmware.if. I was following=
 the domain_auto_trans rules for other apps such as mozilla. The syntax err=
or problem went away. =0A>>=0A>> But the problem is that the domain transit=
ion didn't take place. My vmplayer is still running in unconfined state.=0A=
>>=0A>> I'm doing compilation of the vmware.pp module using make -f /usr/sh=
are/selinux/devel/Makefile. I've tried to purposely introduce errors into v=
mware.if to see if the compilation is effective:=0A>>=0A>> e.g. domain_auto=
_trans($2, $2, $1_t, vmware_exec_t, $1_vmware_t)=0A>>=0A>> But the make pro=
cess didn't detect any errors and the compilation still went on. I did a di=
ff between the vmware.pp at the /etc/selinux/targeted/modules/active/module=
s/vmware.pp and the development directory (where I do all my compilation), =
but there are no differences.=0A>>=0A>> Does it mean if the vmware.if file =
is modified it will not affect the make? =0A> =0A> as i infer (i'm not sure=
):=0A> =0A> the interface will not be checked, unless someone invoke it, be=
cause if=0A> there are not invokes, the parameter can not be determined.=0A=
> =0A> when you build vmware module, you will not use your own interface in=
=0A> own module, so build process will not detect error.=0A> =0A> =0A> =0A>=
> How do you ensure that the changes at vmware.if  effective? (well at leas=
t cause some compilation errors?)=0A>>=0A>>=0A>>=0A>> Thanks,=0A>> Louis=0A=
>>=0A>>=0A>>=0A>>=0A>>=0A>> ----- Original Message ----=0A>> From: Ken YANG=
 <spng.yang@gmail.com>=0A>> To: Louis Lam <lshoujun@yahoo.com>=0A>> Cc: Dan=
iel J Walsh <dwalsh@redhat.com>; fedora-selinux-list@redhat.com=0A>> Sent: =
Saturday, July 28, 2007 5:28:25 PM=0A>> Subject: Re: Containing vmware play=
er 2.0.0 with SELINUX=0A>>=0A>>=0A>> Louis Lam wrote:=0A>>> My mistakes, ap=
ologies for the confusion, under part 2, I was trying to do domain_auto_tra=
ns instead of doman_entry_file, so...=0A>>>=0A>>> 2. Created a domain trans=
ition so that the vmware user programs e.g.=0A>>> /usr/lib/vmplayer script,=
 /usr/lib/vmware/bin/vmplayer that are=0A>>> labelleled system_u:object_r:v=
mware_exec_t will transit to=0A>>> system_u:object_r:vmware_t when executed=
. I put it also in vmware.te:=0A>>>=0A>>> domain_auto_trans($1_t, vmware_ex=
ec_t, $1_vmware_t)=0A>>>=0A>>> but=0A>>>  on making the vmware.pp module I =
get this warning and error:=0A>>>=0A>>> 'syntax error' at token '1' on line=
 81143:=0A>>> #line 13=0A>>>     allow $1_t vmware_exec_t: file {getattr re=
ad execute};=0A>> this rule is generated by domain_auto_trans, so i think t=
he=0A>> syntax error should be caused by other rules.=0A>>=0A>> you may che=
ck other rules in your policy.=0A>>=0A>>> Thanks in advance,=0A>>> Louis=0A=
>>>=0A>>>=0A>>> ----- Original Message ----=0A>>> From: Louis Lam <lshoujun=
@yahoo.com>=0A>>> To: Daniel J Walsh <dwalsh@redhat.com>=0A>>> Cc: fedora-s=
elinux-list@redhat.com=0A>>> Sent: Friday, July 27, 2007 5:05:05 AM=0A>>> S=
ubject: Re: Containing vmware player 2.0.0 with SELINUX=0A>>>=0A>>> Thanks =
Daniel for the information, hi everyone=0A>>>=0A>>> I've tried to make the =
following changes:=0A>>>=0A>>> 1. Defined the vmware_t type in vmware.te:=
=0A>>> type vmware_t;=0A>>>=0A>>> I need to do this since I'm trying to let=
 the vmware user program run under vmware_t domain but this is not defined.=
 In terms of overall code compliance is it correct to define here? or shoul=
d be at the vmware.if?=0A>> type definition should be in vmware.te=0A>>=0A>=
> Send instant messages to your online friends http://uk.messenger.yahoo.co=
m =0A> =0A> =0A> =0A> =0A> =0A> =0A> =0A> Send instant messages to your onl=
ine friends http://uk.messenger.yahoo.com =0A=0A=0A=0A=0A=0A=0A=0ASend inst=
ant messages to your online friends http://uk.messenger.yahoo.com 
--0-501328788-1186038113=:47348
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Hi all,<br><br>Today i managed to make the vmplayer=
 run in its own domain. What I did was added the statement to my vmware.te.=
 Thanks to Ken and his suggestion (and all of the help so far), i've got th=
e "Selinux by example" book that i've been reading as a reference. <br><br>=
domain_auto_trans(unconfined_t, vmware_exec_t, vmware_t)<br><br>Evident fro=
m the large amount of avc denials in setroubleshoot when i launch vmplayer,=
 i was able to see that vmplayer was running in the context of :<br><br>roo=
t:system_r:vmware_t<br><br>Two questions from security angle on this approa=
ch though:<br><br>1. If i allow transition from unconfined_t to vmware_t, i=
t means that any unconfined process can transit to vmware_t and be able to
 access the vmware files. This is probably not what i'd desire. What would =
be a good recommendation for this? Any best practices?<br><br>2. I still wa=
nt to start vmware as a user program, probably not as a service. In that ca=
se, would I still need to do something in the vmware.if so that the domain =
auto trans can take on a role ?<br><br>Now that i'm able to run it under vm=
ware_t domain, and see a lot of avcs, i intend to make vmware run properly =
again. I'd go with allowing whatever vmware wants to do, then tightening th=
e security. There are a few approaches i can use, and i'd like to seek your=
 opinions on how to go about doing it:<br><br>1. audit2allow: This will lis=
t all of the avcs and turn them into allow statements. By adding these stat=
ements to my vmware.te, this would enable vmware to function again. Problem=
 is that i may end up with too many statements. There would probably be mac=
ros to cover these.<br><br>2. macros: This is somethings i'm not
 familiar with. Are there any documentation that describe some of the more =
commonly used macros? Or it is better just to see the source?<br><br>3. pol=
icygentool: From what i understand, this is a script that would generate a =
module for you. the question is how do i combine&nbsp; it with the vmware s=
ource code that I've taken from the reference policy? (that i'm using now)?=
 I forsee a lot of conflicts to be resolved. and may actually not be so cle=
an.<br><br>Whats your take on these approach? Are there others that I've mi=
ssed out?<br><br>Thanks in advance,<br>Louis<br><br><div style=3D"font-fami=
ly: times new roman,new york,times,serif; font-size: 12pt;">----- Original =
Message ----<br>From: Ken YANG &lt;spng.yang@gmail.com&gt;<br>To: Louis Lam=
 &lt;lshoujun@yahoo.com&gt;<br>Cc: Daniel J Walsh &lt;dwalsh@redhat.com&gt;=
; fedora-selinux-list@redhat.com<br>Sent: Tuesday, July 31, 2007 6:00:20 AM=
<br>Subject: Re: Containing vmware player 2.0.0 with
 SELINUX<br><br><div>Louis Lam wrote:<br>&gt; Hi, <br>&gt; <br>&gt; Thanks =
for the reply.<br>&gt; <br>&gt; My conclusion is that not I'm not sure wher=
e to place the domain_auto_trans() statement. If I can't place it in the vm=
ware.if file(since it will not be read during module compilation ) where ca=
n I put this statement? All i need to do now is to make the vmware executab=
le run in its own domain e.g. vmware_t. But it seems more difficult than I =
thought. <br><br>if you want vmware program run in own domain, all necessar=
y rules<br>should be in te file, e.g.<br><br>domain_auto_trans(vmware_t, vm=
ware_host_exec_t, vmware_host_t)<br>(just a example)<br><br>similarly, doma=
in_auto_trans can also used in if file, especially used<br>in per_role_temp=
late. All these are depend on your purpose.<br><br>to make vmware run in se=
linux-policy&gt;3.0, the easiest way is to<br>follow what tom guid, i.e. mo=
dify the net-service.sh to restorce<br>label after creating device
 node.<br><br>but if you want to make policy contain vmware, you must resol=
ve<br>the "device node label" problem, IMHO, you should use fs_use_trans<br=
>to make label automatically:<br><br><a target=3D"_blank" href=3D"http://ma=
rc.info/?l=3Dselinux&amp;m=3D118481693028190&amp;w=3D2">http://marc.info/?l=
=3Dselinux&amp;m=3D118481693028190&amp;w=3D2</a><br><br>now, i have not tim=
e to do this, so i have not solved the problems<br>i encountered.<br><br><b=
r>&gt; <br>&gt; Can you point me to resources to how to develop modules? Ca=
n someone help me with this problem?<br><br>"Beginning is the most difficul=
t one, but A Good Beginning is half<br>the battle" :-)<br><br>after you fin=
ish the beginning, you will find it's not difficult.<br><br>The book &lt;&l=
t;SELinux by example&gt;&gt; is a good guide for developing modules,<br>but=
 i think the best guide to develop policy is the policy source.<br><br><br>=
<br>&gt; <br>&gt; Thanks &amp; Regards,<br>&gt; Louis<br>&gt; <br>&gt; ----=
-
 Original Message ----<br>&gt; From: Ken YANG &lt;spng.yang@gmail.com&gt;<b=
r>&gt; To: Louis Lam &lt;lshoujun@yahoo.com&gt;<br>&gt; Cc: Daniel J Walsh =
&lt;dwalsh@redhat.com&gt;; fedora-selinux-list@redhat.com<br>&gt; Sent: Mon=
day, July 30, 2007 6:53:17 AM<br>&gt; Subject: Re: Containing vmware player=
 2.0.0 with SELINUX<br>&gt; <br>&gt; Louis Lam wrote:<br>&gt;&gt; Hi,<br>&g=
t;&gt;<br>&gt;&gt; I think i'm having a policy compilation problem here<br>=
&gt;&gt;<br>&gt;&gt; I've moved the domain_auto_trans($1_t, vmware_exec_t, =
$1_vmware_t) statement to vmware.if. I was following the domain_auto_trans =
rules for other apps such as mozilla. The syntax error problem went away. <=
br>&gt;&gt;<br>&gt;&gt; But the problem is that the domain transition didn'=
t take place. My vmplayer is still running in unconfined state.<br>&gt;&gt;=
<br>&gt;&gt; I'm doing compilation of the vmware.pp module using make -f /u=
sr/share/selinux/devel/Makefile. I've tried to purposely introduce
 errors into vmware.if to see if the compilation is effective:<br>&gt;&gt;<=
br>&gt;&gt; e.g. domain_auto_trans($2, $2, $1_t, vmware_exec_t, $1_vmware_t=
)<br>&gt;&gt;<br>&gt;&gt; But the make process didn't detect any errors and=
 the compilation still went on. I did a diff between the vmware.pp at the /=
etc/selinux/targeted/modules/active/modules/vmware.pp and the development d=
irectory (where I do all my compilation), but there are no differences.<br>=
&gt;&gt;<br>&gt;&gt; Does it mean if the vmware.if file is modified it will=
 not affect the make? <br>&gt; <br>&gt; as i infer (i'm not sure):<br>&gt; =
<br>&gt; the interface will not be checked, unless someone invoke it, becau=
se if<br>&gt; there are not invokes, the parameter can not be determined.<b=
r>&gt; <br>&gt; when you build vmware module, you will not use your own int=
erface in<br>&gt; own module, so build process will not detect error.<br>&g=
t; <br>&gt; <br>&gt; <br>&gt;&gt; How do you ensure that the changes
 at vmware.if&nbsp;&nbsp;effective? (well at least cause some compilation e=
rrors?)<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; Thanks,<br>&gt;&gt;=
 Louis<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&=
gt; ----- Original Message ----<br>&gt;&gt; From: Ken YANG &lt;spng.yang@gm=
ail.com&gt;<br>&gt;&gt; To: Louis Lam &lt;lshoujun@yahoo.com&gt;<br>&gt;&gt=
; Cc: Daniel J Walsh &lt;dwalsh@redhat.com&gt;; fedora-selinux-list@redhat.=
com<br>&gt;&gt; Sent: Saturday, July 28, 2007 5:28:25 PM<br>&gt;&gt; Subjec=
t: Re: Containing vmware player 2.0.0 with SELINUX<br>&gt;&gt;<br>&gt;&gt;<=
br>&gt;&gt; Louis Lam wrote:<br>&gt;&gt;&gt; My mistakes, apologies for the=
 confusion, under part 2, I was trying to do domain_auto_trans instead of d=
oman_entry_file, so...<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; 2. Created a domain =
transition so that the vmware user programs e.g.<br>&gt;&gt;&gt; /usr/lib/v=
mplayer script, /usr/lib/vmware/bin/vmplayer that
 are<br>&gt;&gt;&gt; labelleled system_u:object_r:vmware_exec_t will transi=
t to<br>&gt;&gt;&gt; system_u:object_r:vmware_t when executed. I put it als=
o in vmware.te:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; domain_auto_trans($1_t, vmw=
are_exec_t, $1_vmware_t)<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; but<br>&gt;&gt;&gt=
;&nbsp;&nbsp;on making the vmware.pp module I get this warning and error:<b=
r>&gt;&gt;&gt;<br>&gt;&gt;&gt; 'syntax error' at token '1' on line 81143:<b=
r>&gt;&gt;&gt; #line 13<br>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; allow $1_t =
vmware_exec_t: file {getattr read execute};<br>&gt;&gt; this rule is genera=
ted by domain_auto_trans, so i think the<br>&gt;&gt; syntax error should be=
 caused by other rules.<br>&gt;&gt;<br>&gt;&gt; you may check other rules i=
n your policy.<br>&gt;&gt;<br>&gt;&gt;&gt; Thanks in advance,<br>&gt;&gt;&g=
t; Louis<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; ----- Original Mes=
sage ----<br>&gt;&gt;&gt; From: Louis Lam
 &lt;lshoujun@yahoo.com&gt;<br>&gt;&gt;&gt; To: Daniel J Walsh &lt;dwalsh@r=
edhat.com&gt;<br>&gt;&gt;&gt; Cc: fedora-selinux-list@redhat.com<br>&gt;&gt=
;&gt; Sent: Friday, July 27, 2007 5:05:05 AM<br>&gt;&gt;&gt; Subject: Re: C=
ontaining vmware player 2.0.0 with SELINUX<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; =
Thanks Daniel for the information, hi everyone<br>&gt;&gt;&gt;<br>&gt;&gt;&=
gt; I've tried to make the following changes:<br>&gt;&gt;&gt;<br>&gt;&gt;&g=
t; 1. Defined the vmware_t type in vmware.te:<br>&gt;&gt;&gt; type vmware_t=
;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; I need to do this since I'm trying to let=
 the vmware user program run under vmware_t domain but this is not defined.=
 In terms of overall code compliance is it correct to define here? or shoul=
d be at the vmware.if?<br>&gt;&gt; type definition should be in vmware.te<b=
r>&gt;&gt;<br>&gt;&gt; Send instant messages to your online friends <a targ=
et=3D"_blank"
 href=3D"http://uk.messenger.yahoo.com">http://uk.messenger.yahoo.com</a> <=
br>&gt; <br>&gt; <br>&gt; <br>&gt; <br>&gt; <br>&gt; <br>&gt; <br>&gt; Send=
 instant messages to your online friends <a target=3D"_blank" href=3D"http:=
//uk.messenger.yahoo.com">http://uk.messenger.yahoo.com</a> <br><br></div><=
/div><br></div></div><br>Send instant messages to your online friends http:=
//uk.messenger.yahoo.com </body></html>
--0-501328788-1186038113=:47348--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
