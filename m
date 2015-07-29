MIME-Version: 1.0
In-Reply-To: <20150729152550.GC19285@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-12-git-send-email-l.pawelczyk@samsung.com>
 <20150729152550.GC19285@mail.hallyn.com>
Date: Wed, 29 Jul 2015 18:10:11 +0200
Message-ID: <CACL4Mm8t5esKooxXDE-6=LCOKoWZFuzkjoCC3UXQuTL-P84PgQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] smack: documentation for the Smack namespace
From: Lukasz Pawelczyk <havner@gmail.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: multipart/alternative; boundary=001a11c23c9e414d68051c05d22e
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Jiri Slaby <jslaby@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Fabian Frederick <fabf@skynet.be>, Al Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 John Johansen <john.johansen@canonical.com>,
 Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Zefan Li <lizefan@huawei.com>, Joe Perches <joe@perches.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c23c9e414d68051c05d22e
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 29, 2015 at 5:25 PM, Serge E. Hallyn <serge@hallyn.com> wrote:

> On Fri, Jul 24, 2015 at 12:04:45PM +0200, Lukasz Pawelczyk wrote:
> > +--- Design ideas ---
> > +
> > +"Smack namespace" is rather "Smack labels namespace" as not the whole
> > +MAC is namespaced, only the labels. There is a great analogy between
> > +Smack labels namespace and the user namespace part that remaps UIDs.
> > +
> > +The idea is to create a map of labels for a namespace so the namespace
> > +is only allowed to use those labels. Smack rules are always the same
> > +as in the init namespace (limited only by what labels are mapped) and
> > +cannot be manipulated from the child namespace. The map is actually
> > +only for labels' names. The underlying structures for labels remain
> > +the same. The filesystem also stores the "unmapped" labels from the
> > +init namespace.
> > +
> > +Let's say we have those labels in the init namespace:
> > +label1
> > +label2
> > +label3
> > +
> > +and those rules:
> > +label1 label2 rwx
> > +label1 label3 rwx
> > +label2 label3 rwx
> > +
> > +We create a map for a namespace:
> > +label1 -> mapped1
> > +label2 -> mapped2
> > +
> > +This means that 'label3' is completely invisible in the namespace. As if
> > +it didn't exist. All the rules that include it are ignored.
> > +
> > +Effectively in the namespace we have only one rule:
> > +mapped1 mapped2 rwx
> > +
> > +Which in reality is:
> > +label1 label2 rwx
> > +
> > +All requests to access an object with a 'label3' will be denied. If it
> > +ever comes to a situation where 'label3' would have to be printed
> > +(e.g. reading an exec or mmap label from a file to which we have
> > +access) then huh sign '?' will be printed instead.
> > +
> > +All the operations in the namespace on the remaining labels will have
> > +to be performed using their mapped names. Things like changing own
> > +process's label, changing filesystem label. Labels will also be
> > +printed with their mapped names.
> > +
> > +You cannot import new labels in a namespace. Every operation that
> > +would do so in an init namespace will return an error in the child
> > +namespace. You cannot assign an unmapped or not existing label to an
> > +object. You can only operate on labels that have been explicitly
> > +mapped.
> > +
> > +
> > +--- Capabilities ---
> > +
> > +Enabling Smack related capabilities (CAP_MAC_ADMIN and
> > +CAP_MAC_OVERRIDE) is main goal of Smack namespace, so it can work
> > +properly in the container. And those capabilities do work to some
> > +extent. In several places where capabilities are checked compatibility
> > +with Smack namespace has been introduced. Capabilities are of course
> > +limited to operate only on mapped labels.
> > +
> > +CAP_MAC_OVERRIDE works fully, will allow you to ignore Smack access
> > +rules, but only between objects that have labels mapped. So in the
> > +example above having this CAP will allow e.g. label2 to write to
> > +label1, but will not allow any access to label3.
>
> (Sorry it took me this long to get to reading, and thanks for working
> on this)
>
> Oh my.  All this is not at all what I'd expected :)
>
> Is there rationale for these decisions?  Hm, I guess it really is
> following the user_ns design, but the huge difference is that the
> user_ns is partitioning an already-enumerated set of kuids.  The
> smack labels are inherently different.
>

There is a big rationale for this. This is not to make Smack limit how
namespace can be created (this can be done separately, no conflict here).
This is to make Smack work at all inside a namespace. Please note that
contrary to SELinux and AppArmor Smack needs CAP_MAC_ADMIN for it to
operate on a normal basis. There is no rule for changing labels.
CAP_MAC_ADMIN is always required for this. And you cannot unlock and give
this capability just like that to anyone. Like in every namespace you need
a level of abstraction to allow an unprivileged namespace to administer
something.


>
> In containers, something we'd really like to be able to do is:
>
> Create a new container.  Just run it as label 'c1'.  Inside the
> container, let the admin install mysql from a package which assigns
> type 'mysqld', protecting the rest of the container from mysql.
> Without the host admin doing anything.
>
> Normally the way I think of implementing something like this would be
> to allow the host to say "c1 is to be namespaceable."  Then on a userns
> unshare, if the task is in c1, it gets transitioned into the ns.  Then the
> container sees c1 as _ (or whatever).  It can create 'mysql' which is
> actually 'c1.mysql' on the host, and it can create and override rules
> to c1.*.
>

Few things here.
1. Such an extension with using prefixes (with two exceptions, see below)
could be added to my patches. I even planned to do so (make a prefix for a
container and assign it a group of labels, this doesn't conflict with
arbitrary mapping). But this was refused by Casey on a basis that by Smack
defintion labels have no meaning. So no prefixes.
2. (expcetion #1) Changing any rules in a container has been deemed too
insecure at this point.
3. (expcetion #2) About the: "Without the host admin doing anything.". With
this namespace you delegate part of CAP_MAC_ADMIN privilege to an
unprivileged user (as with any other namespace). There is now way that this
will not involve host admin. The way you described it you allow an
unprivileged process to change its own label and change labels on a
filesystem. This is simply against Smack rules and completely insecure.
Even with user_ns if you map several UID you need admin intervention.


> Also, allowing CAP_MAC_OVERRIDE in this way seems overly dangerous.
> If there were rules defined by the container, then I'd expect those to
> be overrideable - but not all rules pertaining to all labels mapped
> into the container.  But I guess based on  your envisioned usage (where
> I assume 'label1' is meant to *only* be used for that container) it
> might be ok.
>

CAP_MAC_OVERRIDE is only possible for labels that the admin explicitly
mapped. So it's up to him to decide what is dangerous or not. It can only
map labels that are not used outside of the container if it wishes to. But
the user himself will not be able to explot that without permission from
the admin.

So sorry this is not what you expected, but it seems that what you expected
is simply not feasible.


> thanks,
> -serge
>

Thanks,
Lukasz

--001a11c23c9e414d68051c05d22e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Jul 29, 2015 at 5:25 PM, Serge E. Hallyn <span dir=
=3D"ltr">&lt;<a href=3D"mailto:serge@hallyn.com" target=3D"_blank">serge@ha=
llyn.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div clas=
s=3D"h5">On Fri, Jul 24, 2015 at 12:04:45PM +0200, Lukasz Pawelczyk wrote:<=
br>
&gt; +--- Design ideas ---<br>
&gt; +<br>
&gt; +&quot;Smack namespace&quot; is rather &quot;Smack labels namespace&qu=
ot; as not the whole<br>
&gt; +MAC is namespaced, only the labels. There is a great analogy between<=
br>
&gt; +Smack labels namespace and the user namespace part that remaps UIDs.<=
br>
&gt; +<br>
&gt; +The idea is to create a map of labels for a namespace so the namespac=
e<br>
&gt; +is only allowed to use those labels. Smack rules are always the same<=
br>
&gt; +as in the init namespace (limited only by what labels are mapped) and=
<br>
&gt; +cannot be manipulated from the child namespace. The map is actually<b=
r>
&gt; +only for labels&#39; names. The underlying structures for labels rema=
in<br>
&gt; +the same. The filesystem also stores the &quot;unmapped&quot; labels =
from the<br>
&gt; +init namespace.<br>
&gt; +<br>
&gt; +Let&#39;s say we have those labels in the init namespace:<br>
&gt; +label1<br>
&gt; +label2<br>
&gt; +label3<br>
&gt; +<br>
&gt; +and those rules:<br>
&gt; +label1 label2 rwx<br>
&gt; +label1 label3 rwx<br>
&gt; +label2 label3 rwx<br>
&gt; +<br>
&gt; +We create a map for a namespace:<br>
&gt; +label1 -&gt; mapped1<br>
&gt; +label2 -&gt; mapped2<br>
&gt; +<br>
&gt; +This means that &#39;label3&#39; is completely invisible in the names=
pace. As if<br>
&gt; +it didn&#39;t exist. All the rules that include it are ignored.<br>
&gt; +<br>
&gt; +Effectively in the namespace we have only one rule:<br>
&gt; +mapped1 mapped2 rwx<br>
&gt; +<br>
&gt; +Which in reality is:<br>
&gt; +label1 label2 rwx<br>
&gt; +<br>
&gt; +All requests to access an object with a &#39;label3&#39; will be deni=
ed. If it<br>
&gt; +ever comes to a situation where &#39;label3&#39; would have to be pri=
nted<br>
&gt; +(e.g. reading an exec or mmap label from a file to which we have<br>
&gt; +access) then huh sign &#39;?&#39; will be printed instead.<br>
&gt; +<br>
&gt; +All the operations in the namespace on the remaining labels will have=
<br>
&gt; +to be performed using their mapped names. Things like changing own<br=
>
&gt; +process&#39;s label, changing filesystem label. Labels will also be<b=
r>
&gt; +printed with their mapped names.<br>
&gt; +<br>
&gt; +You cannot import new labels in a namespace. Every operation that<br>
&gt; +would do so in an init namespace will return an error in the child<br=
>
&gt; +namespace. You cannot assign an unmapped or not existing label to an<=
br>
&gt; +object. You can only operate on labels that have been explicitly<br>
&gt; +mapped.<br>
&gt; +<br>
&gt; +<br>
&gt; +--- Capabilities ---<br>
&gt; +<br>
&gt; +Enabling Smack related capabilities (CAP_MAC_ADMIN and<br>
&gt; +CAP_MAC_OVERRIDE) is main goal of Smack namespace, so it can work<br>
&gt; +properly in the container. And those capabilities do work to some<br>
&gt; +extent. In several places where capabilities are checked compatibilit=
y<br>
&gt; +with Smack namespace has been introduced. Capabilities are of course<=
br>
&gt; +limited to operate only on mapped labels.<br>
&gt; +<br>
&gt; +CAP_MAC_OVERRIDE works fully, will allow you to ignore Smack access<b=
r>
&gt; +rules, but only between objects that have labels mapped. So in the<br=
>
&gt; +example above having this CAP will allow e.g. label2 to write to<br>
&gt; +label1, but will not allow any access to label3.<br>
<br>
</div></div>(Sorry it took me this long to get to reading, and thanks for w=
orking<br>
on this)<br>
<br>
Oh my.=C2=A0 All this is not at all what I&#39;d expected :)<br>
<br>
Is there rationale for these decisions?=C2=A0 Hm, I guess it really is<br>
following the user_ns design, but the huge difference is that the<br>
user_ns is partitioning an already-enumerated set of kuids.=C2=A0 The<br>
smack labels are inherently different.<br></blockquote><div><br></div><div>=
There is a big rationale for this. This is not to make Smack limit how name=
space can be created (this can be done separately, no conflict here). This =
is to make Smack work at all inside a namespace. Please note that contrary =
to SELinux and AppArmor Smack needs CAP_MAC_ADMIN for it to operate on a no=
rmal basis. There is no rule for changing labels. CAP_MAC_ADMIN is always r=
equired for this. And you cannot unlock and give this capability just like =
that to anyone. Like in every namespace you need a level of abstraction to =
allow an unprivileged namespace to administer something.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
In containers, something we&#39;d really like to be able to do is:<br>
<br>
Create a new container.=C2=A0 Just run it as label &#39;c1&#39;.=C2=A0 Insi=
de the<br>
container, let the admin install mysql from a package which assigns<br>
type &#39;mysqld&#39;, protecting the rest of the container from mysql.<br>
Without the host admin doing anything.<br>
<br>
Normally the way I think of implementing something like this would be<br>
to allow the host to say &quot;c1 is to be namespaceable.&quot;=C2=A0 Then =
on a userns<br>
unshare, if the task is in c1, it gets transitioned into the ns.=C2=A0 Then=
 the<br>
container sees c1 as _ (or whatever).=C2=A0 It can create &#39;mysql&#39; w=
hich is<br>
actually &#39;c1.mysql&#39; on the host, and it can create and override rul=
es<br>
to c1.*.<br></blockquote><div><br></div><div>Few things here.<br></div><div=
>1. Such an extension with using prefixes (with two exceptions, see below) =
could be added to my patches. I even planned to do so (make a prefix for a =
container and assign it a group of labels, this doesn&#39;t conflict with a=
rbitrary mapping). But this was refused by Casey on a basis that by Smack d=
efintion labels have no meaning. So no prefixes.<br></div><div>2. (expcetio=
n #1) Changing any rules in a container has been deemed too insecure at thi=
s point.<br></div><div>3. (expcetion #2) About the: &quot;Without the host =
admin doing anything.&quot;. With this namespace you delegate part of CAP_M=
AC_ADMIN privilege to an unprivileged user (as with any other namespace). T=
here is now way that this will not involve host admin. The way you describe=
d it you allow an unprivileged process to change its own label and change l=
abels on a filesystem. This is simply against Smack rules and completely in=
secure. Even with user_ns if you map several UID you need admin interventio=
n.<br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
<br>
Also, allowing CAP_MAC_OVERRIDE in this way seems overly dangerous.<br>
If there were rules defined by the container, then I&#39;d expect those to<=
br>
be overrideable - but not all rules pertaining to all labels mapped<br>
into the container.=C2=A0 But I guess based on=C2=A0 your envisioned usage =
(where<br>
I assume &#39;label1&#39; is meant to *only* be used for that container) it=
<br>
might be ok.<br></blockquote><div><br></div><div>CAP_MAC_OVERRIDE is only p=
ossible for labels that the admin explicitly mapped. So it&#39;s up to him =
to decide what is dangerous or not. It can only map labels that are not use=
d outside of the container if it wishes to. But the user himself will not b=
e able to explot that without permission from the admin.<br><br>So sorry th=
is is not what you expected, but it seems that what you expected is simply =
not feasible.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
thanks,<br>
-serge<br></blockquote><div><br></div><div>Thanks,<br></div><div>Lukasz <br=
></div></div><br></div></div>

--001a11c23c9e414d68051c05d22e--
