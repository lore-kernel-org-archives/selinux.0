MIME-Version: 1.0
From: Nick Kralevich <nnk@google.com>
Date: Sun, 4 Dec 2016 10:29:20 -0800
Message-ID: <CAFJ0LnF5CXaNDMKMLtmVung4RXUujeL3jBZFopzeOwy6+iiWRg@mail.gmail.com>
Subject: INTERP ELF header and SELinux
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7ba979069971c80542d9596a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7ba979069971c80542d9596a
Content-Type: text/plain; charset=UTF-8

Scenerio:

1) Process P is running in the "P" SELinux domain.
2) A type transition is defined such that when P executes Q_exec, P
transitions into SELinux domain Q.
3) Q_exec is an ELF executable with an INTERP (dynamic linker) header
pointing to a file labeled R_interp_lib
4) Domain P has file execute permission on R_interp_lib and Q_exec. P does
NOT have execute_no_trans on Q_exec nor on R_interp_lib.
5) Domain Q has file execute permissions on Q_exec, but does NOT have file
execute permissions on R_interp_lib.
6) P executes Q_exec

What is the intended behavior? Is it:

1) P can successfully execute Q_exec. The process in domain Q has
R_interp_lib mapped into the process as executable memory even though it
wasn't explicitly allowed by policy. This was allowed because P has execute
on R_interp_lib.

2) P gets "permission denied" attempting to run Q_exec, because the
resulting domain Q does not have execute permission on R_interp_lib, and Q
needs R_interp_lib to successfully run.

Other?

>From my (admittedly weak) understanding of the current kernel code today,
it appears the answer is #1. The permission checks performed by the kernel
when loading the dynamic linker occur in the initiating SELinux domain, not
the resulting SELinux domain. So as long as the executing process has
execute on the dynamic linker, the target process will have the dynamic
linker mapped into it's memory.

Intuitively, I would have expected #2. In the same way that a process
shouldn't be able to be executed it doesn't have file execute on it's own
executable, it shouldn't be able to be executed if it doesn't have execute
on it's dynamic linker.

Thoughts?

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--047d7ba979069971c80542d9596a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Scenerio:<br></div><div><br></div><div>1) Process P i=
s running in the &quot;P&quot; SELinux domain.</div><div>2) A type transiti=
on is defined such that when P executes Q_exec, P transitions into SELinux =
domain Q.</div><div>3) Q_exec is an ELF executable with an INTERP (dynamic =
linker) header pointing to a file labeled R_interp_lib</div><div>4) Domain =
P has file execute permission on R_interp_lib and Q_exec. P does NOT have e=
xecute_no_trans on Q_exec nor on R_interp_lib.</div><div>5) Domain Q has fi=
le execute permissions on Q_exec, but does NOT have file execute permission=
s on R_interp_lib.</div><div>6) P executes Q_exec</div><div><br></div><div>=
What is the intended behavior? Is it:</div><div><br></div><div>1) P can suc=
cessfully execute Q_exec. The process in domain Q has R_interp_lib mapped i=
nto the process as executable memory even though it wasn&#39;t explicitly a=
llowed by policy. This was allowed because P has execute on R_interp_lib.</=
div><div><br></div><div>2) P gets &quot;permission denied&quot; attempting =
to run Q_exec, because the resulting domain Q does not have execute permiss=
ion on R_interp_lib, and Q needs R_interp_lib to successfully run.</div><di=
v><br></div><div>Other?</div><div><br></div><div>From my (admittedly weak) =
understanding of the current kernel code today, it appears the answer is #1=
. The permission checks performed by the kernel when loading the dynamic li=
nker occur in the initiating SELinux domain, not the resulting SELinux doma=
in. So as long as the executing process has execute on the dynamic linker, =
the target process will have the dynamic linker mapped into it&#39;s memory=
.</div><div><br></div><div>Intuitively, I would have expected #2. In the sa=
me way that a process shouldn&#39;t be able to be executed it doesn&#39;t h=
ave file execute on it&#39;s own executable, it shouldn&#39;t be able to be=
 executed if it doesn&#39;t have execute on it&#39;s dynamic linker.</div><=
div><br></div><div>Thoughts?</div><div><br></div><div>--=C2=A0<br></div><di=
v><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div>Ni=
ck Kralevich | Android Security | <a href=3D"mailto:nnk@google.com" target=
=3D"_blank">nnk@google.com</a> | 650.214.4037</div></div>
</div></div>

--047d7ba979069971c80542d9596a--
