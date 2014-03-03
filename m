Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s23Nd7wL029062
 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2014 18:39:08 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3B17720D75
 for <selinux@tycho.nsa.gov>; Mon,  3 Mar 2014 18:39:08 -0500 (EST)
Received: from [192.168.43.3] (unknown [70.192.12.234])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4C7FEC007AE
 for <selinux@tycho.nsa.gov>; Mon,  3 Mar 2014 18:39:07 -0500 (EST)
Date: Mon, 03 Mar 2014 23:34:05 +0000
From: Colin Walters <walters@verbum.org>
Subject: OSTree <3 SELinux
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-ZJ7gdYOScN8B2qXOA2qA"
Message-Id: <20140303233907.4C7FEC007AE@frontend1.nyi.mail.srv.osa>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-ZJ7gdYOScN8B2qXOA2qA
Content-Type: text/plain; charset=utf-8; format=flowed

Hi all,

In case you didn't notice, I'm back doing SELinux stuff - it's fun to 
be back =)

Now, I've been working on a new general-purpose upgrade system for 
Linux-based operating systems, called OSTree.  There is a higher level 
project "Fedora Atomic Initiative" which I just announced a new release 
of here:
https://lists.fedoraproject.org/pipermail/devel/2014-March/196257.html

So why am I posting here?  Well, I designed OSTree from day 0 to 
support SELinux well, and I think it shows.  Let's just say the 
integration of traditional package systems (dpkg/rpm) and SELinux 
is...a bit ugly.

For example, whether and how we relabel existing contexts on disk when 
upgrading to a new policy.  Whether and how we restart running daemons 
after a new policy.

Say that an update changes policy and a daemon at the same time.  With 
the "partial live updates" model that traditional package systems 
create, you can have the *old* daemon running with the *new* policy, 
and the new policy now denies something only the old version needs.

This kind of problem is deeply evil and insidious because only live 
updates see it - if someone downstream tries to reproduce with the same 
package versions, they won't see it on a fresh boot.

So with OSTree, I solve this by simply not supporting "partial live 
updates".  Every upgrade is *fully atomic* you have to reboot for a new 
SELinux policy, a new daemon, etc.

Another example of a major change OSTree enables is that most SELinux 
file context labeling happens on the *build server side*.  This is 
significantly more efficient if one is replicating to many machines, 
and also more reliable.

Except that on the client end, we need to handle /etc specially:
https://git.gnome.org/browse/ostree/commit/?id=2313bdcb62eee1170b128737ca84664cf82b13b8

That's old code, but the basic idea is that on upgrades, we do a 3 way 
merge of /etc - and on the client end, OSTree will load the policy and 
ensure that the new /etc gets the property security contexts.

So that's some details about upgrades.

I could talk more here about how the OSTree model of shipping and 
testing complete *trees* melds well with the similarly centralized 
selinux-policy model, but hopefully that's obvious.

On the subject of testing - my goal is to get notification of a new AVC 
denial after a package build in Koji for one of my tracked trees down 
to minutes, if not faster.

This mail is already long, but I just wanted you all to know I'm 
committed to making SELinux work well, and if you have a chance to look 
at the OSTree-SELinux integration, I'm happy to hear any feedback.



--=-ZJ7gdYOScN8B2qXOA2qA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,<div><br></div><div>In case you didn't notice, I'm back doing SELinu=
x stuff - it's fun to be back =3D)</div><div><br></div><div>Now, I've been =
working on a new general-purpose upgrade system for Linux-based operating s=
ystems, called OSTree. &nbsp;There is a higher level project "Fedora Atomic=
 Initiative" which I just announced a new release of here:</div><div><a hre=
f=3D"https://lists.fedoraproject.org/pipermail/devel/2014-March/196257.html=
">https://lists.fedoraproject.org/pipermail/devel/2014-March/196257.html</a=
></div><div><br></div><div>So why am I posting here? &nbsp;Well, I designed=
 OSTree from day 0 to support SELinux well, and I think it shows. &nbsp;Let=
's just say the integration of traditional package systems (dpkg/rpm) and S=
ELinux is...a bit ugly.</div><div><br></div><div>For example, whether and h=
ow we relabel existing contexts on disk when upgrading to a new policy. &nb=
sp;Whether and how we restart running daemons after a new policy.</div><div=
><br></div><div>Say that an update changes policy and a daemon at the same =
time. &nbsp;With the "partial live updates" model that traditional package =
systems create, you can have the *old* daemon running with the *new* policy=
, and the new policy now denies something only the old version needs.</div>=
<div><br></div><div>This kind of problem is deeply evil and insidious becau=
se only live updates see it - if someone downstream tries to reproduce with=
 the same package versions, they won't see it on a fresh boot.</div><div><b=
r></div><div>So with OSTree, I solve this by simply not supporting "partial=
 live updates". &nbsp;Every upgrade is *fully atomic* you have to reboot fo=
r a new SELinux policy, a new daemon, etc.</div><div><br></div><div>Another=
 example of a major change OSTree enables is that most SELinux file context=
 labeling happens on the *build server side*. &nbsp;This is significantly m=
ore efficient if one is replicating to many machines, and also more reliabl=
e.</div><div><br></div><div>Except that on the client end, we need to handl=
e /etc specially:</div><div><a href=3D"https://git.gnome.org/browse/ostree/=
commit/?id=3D2313bdcb62eee1170b128737ca84664cf82b13b8">https://git.gnome.or=
g/browse/ostree/commit/?id=3D2313bdcb62eee1170b128737ca84664cf82b13b8</a></=
div><div><br></div><div>That's old code, but the basic idea is that on upgr=
ades, we do a 3 way merge of /etc - and on the client end, OSTree will load=
 the policy and ensure that the new /etc gets the property security context=
s.</div><div><br></div><div>So that's some details about upgrades.</div><di=
v><br></div><div>I could talk more here about how the OSTree model of shipp=
ing and testing complete *trees* melds well with the similarly centralized =
selinux-policy model, but hopefully that's obvious.</div><div><br></div><di=
v>On the subject of testing - my goal is to get notification of a new AVC d=
enial after a package build in Koji for one of my tracked trees down to min=
utes, if not faster.</div><div><br></div><div>This mail is already long, bu=
t I just wanted you all to know I'm committed to making SELinux work well, =
and if you have a chance to look at the OSTree-SELinux integration, I'm hap=
py to hear any feedback.</div><div><br></div>=

--=-ZJ7gdYOScN8B2qXOA2qA--
