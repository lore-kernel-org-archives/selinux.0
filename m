Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6QApTVb018995
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 06:51:29 -0400
Received: by mail-qk0-f173.google.com with SMTP id o67so2188377qke.1
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 03:50:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <10070280.KoedIQp72C@x2>
References: <1469464627-2159-1-git-send-email-mvadkert@redhat.com>
 <10070280.KoedIQp72C@x2>
From: Miroslav Vadkerti <mvadkert@redhat.com>
Date: Tue, 26 Jul 2016 12:50:14 +0200
Message-ID: <CAGFJcwyA0MnfwZ8BaGC-2pJYwRtfk3iAzt1JqHq9_fQX1OCMtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] semanage: add auditing of changes in records
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114f856ec7808a053887ac80
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114f856ec7808a053887ac80
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Steve,

I did not know that I won't need to override those parameters when I
started to prepare the patch. I can just remove those and pass always "" as
hostname, addr and tty. I will submit a new patch in a few minutes ..

Thanks and best regards,
/M

On Mon, Jul 25, 2016 at 9:07 PM, Steve Grubb <sgrubb@redhat.com> wrote:

> Hello,
>
> Thanks for adding these audit events. I have just one question below.
>
> On Monday, July 25, 2016 6:37:06 PM EDT Miroslav Vadkerti wrote:
> > Common Criteria requirement FMT_MSA.1 needs any configuration change
> > that affect enforcement of policy to be audited. This patch adds
> > auditing of changes in security context mappings for network ports,
> > interfaces, nodes and file contexts.
> >
> > A new function log_change is introduced that audits additions,
> > modification and removal of the mappings via the USER_MAC_CONFIG_CHANGE
> > audit event.
> >
> > The format of the audit events was discussed with the audit userspace
> > maintainer.
> >
> > This patch resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D8291=
75
> >
> > Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
> > ---
> >  policycoreutils/semanage/seobject.py | 75
> > ++++++++++++++++++++++++++++++++++++ 1 file changed, 75 insertions(+)
> >
> > diff --git a/policycoreutils/semanage/seobject.py
> > b/policycoreutils/semanage/seobject.py index 3b0b108..799ce24 100644
> > --- a/policycoreutils/semanage/seobject.py
> > +++ b/policycoreutils/semanage/seobject.py
> > @@ -82,6 +82,21 @@ file_type_str_to_option =3D {"all files": "a",
> >                             "socket file": "s",
> >                             "symbolic link": "l",
> >                             "named pipe": "p"}
> > +
> > +proto_to_audit =3D {"tcp": 17,
> > +                  "udp": 6,
> > +                  "ipv4": 4,
> > +                  "ipv6": 41}
> > +
> > +ftype_to_audit =3D {"": "any",
> > +                  "b": "block",
> > +                  "c": "char",
> > +                  "d": "dir",
> > +                  "f": "file",
> > +                  "l": "symlink",
> > +                  "p": "pipe",
> > +                  "s": "socket"}
> > +
> >  try:
> >      import audit
> >
> > @@ -90,6 +105,7 @@ try:
> >          def __init__(self):
> >              self.audit_fd =3D audit.audit_open()
> >              self.log_list =3D []
> > +            self.log_change_list =3D []
> >
> >          def log(self, msg, name=3D"", sename=3D"", serole=3D"", serang=
e=3D"",
> > oldsename=3D"", oldserole=3D"", oldserange=3D""):
> >
> > @@ -109,10 +125,17 @@ try:
> >          def log_remove(self, msg, name=3D"", sename=3D"", serole=3D"",
> > serange=3D"", oldsename=3D"", oldserole=3D"", oldserange=3D""):
> > self.log_list.append([self.audit_fd, audit.AUDIT_ROLE_REMOVE,
> sys.argv[0],
> > str(msg), name, 0, sename, serole, serange, oldsename, oldserole,
> > oldserange, "", "", ""])
> >
> > +        def log_change(self, msg, hostname=3D"", addr=3D"", tty=3D""):
> > +            self.log_change_list.append([self.audit_fd,
> > audit.AUDIT_USER_MAC_CONFIG_CHANGE, str(msg), "semanage", hostname, add=
r,
> > tty]) +
> >          def commit(self, success):
> >              for l in self.log_list:
> >                  audit.audit_log_semanage_message(*(l + [success]))
> > +            for l in self.log_change_list:
> > +                audit.audit_log_user_comm_message(*(l + [success]))
> > +
> >              self.log_list =3D []
> > +            self.log_change_list =3D []
> >  except:
> >      class logger:
> >
> > @@ -138,6 +161,9 @@ except:
> >          def log_remove(self, msg, name=3D"", sename=3D"", serole=3D"",
> > serange=3D"", oldsename=3D"", oldserole=3D"", oldserange=3D""): self.lo=
g(msg,
> name,
> > sename, serole, serange, oldsename, oldserole, oldserange)
> >
> > +        def log_change(self, msg, hostname=3D"", addr=3D"", tty=3D""):
> > +            self.log_list.append(" %s" % msg)
> > +
>
> Is it really necessary to do something with hostname, addr, & tty here...
>
> >          def commit(self, success):
> >              if success =3D=3D 1:
> >                  message =3D "Successful: "
> > @@ -155,6 +181,9 @@ class nulllogger:
> >      def log_remove(self, msg, name=3D"", sename=3D"", serole=3D"", ser=
ange=3D"",
> > oldsename=3D"", oldserole=3D"", oldserange=3D""): pass
> >
> > +    def log_change(self, msg, hostname=3D"", addr=3D"", tty=3D""):
> > +        pass
> > +
>
> and here? I think those are already handled in the audit logging function=
.
>
> -Steve
>
> >      def commit(self, success):
> >          pass
> >
> > @@ -1109,6 +1138,8 @@ class portRecords(semanageRecords):
> >          semanage_port_key_free(k)
> >          semanage_port_free(p)
> >
> > +        self.mylog.log_change("resrc=3Dport op=3Dadd lport=3D%s proto=
=3D%s
> > tcontext=3D%s:%s:%s:%s" % (port, proto_to_audit[proto], "system_u",
> > "object_r", type, serange)) +
> >      def add(self, port, proto, serange, type):
> >          self.begin()
> >          self.__add(port, proto, serange, type)
> > @@ -1150,6 +1181,8 @@ class portRecords(semanageRecords):
> >          semanage_port_key_free(k)
> >          semanage_port_free(p)
> >
> > +        self.mylog.log_change("resrc=3Dport op=3Dmodify lport=3D%s pro=
to=3D%s
> > tcontext=3D%s:%s:%s:%s" % (port, proto_to_audit[proto], "system_u",
> > "object_r", setype, serange)) +
> >      def modify(self, port, proto, serange, setype):
> >          self.begin()
> >          self.__modify(port, proto, serange, setype)
> > @@ -1168,6 +1201,7 @@ class portRecords(semanageRecords):
> >              low =3D semanage_port_get_low(port)
> >              high =3D semanage_port_get_high(port)
> >              port_str =3D "%s-%s" % (low, high)
> > +
> >              (k, proto_d, low, high) =3D self.__genkey(port_str, proto_=
str)
> >              if rc < 0:
> >                  raise ValueError(_("Could not create a key for %s") %
> > port_str) @@ -1177,6 +1211,11 @@ class portRecords(semanageRecords):
> >                  raise ValueError(_("Could not delete the port %s") %
> > port_str) semanage_port_key_free(k)
> >
> > +            if low =3D=3D high:
> > +                port_str =3D low
> > +
> > +            self.mylog.log_change("resrc=3Dport op=3Ddelete lport=3D%s
> proto=3D%s"
> > % (port_str, proto_to_audit[proto_str])) +
> >          self.commit()
> >
> >      def __delete(self, port, proto):
> > @@ -1199,6 +1238,8 @@ class portRecords(semanageRecords):
> >
> >          semanage_port_key_free(k)
> >
> > +        self.mylog.log_change("resrc=3Dport op=3Ddelete lport=3D%s pro=
to=3D%s" %
> > (port, proto_to_audit[proto])) +
> >      def delete(self, port, proto):
> >          self.begin()
> >          self.__delete(port, proto)
> > @@ -1380,6 +1421,8 @@ class nodeRecords(semanageRecords):
> >          semanage_node_key_free(k)
> >          semanage_node_free(node)
> >
> > +        self.mylog.log_change("resrc=3Dnode op=3Dadd laddr=3D%s netmas=
k=3D%s
> > proto=3D%s tcontext=3D%s:%s:%s:%s" % (addr, mask,
> > proto_to_audit[self.protocol[proto]], "system_u", "object_r", ctype,
> > serange)) +
> >      def add(self, addr, mask, proto, serange, ctype):
> >          self.begin()
> >          self.__add(addr, mask, proto, serange, ctype)
> > @@ -1421,6 +1464,8 @@ class nodeRecords(semanageRecords):
> >          semanage_node_key_free(k)
> >          semanage_node_free(node)
> >
> > +        self.mylog.log_change("resrc=3Dnode op=3Dmodify laddr=3D%s net=
mask=3D%s
> > proto=3D%s tcontext=3D%s:%s:%s:%s" % (addr, mask,
> > proto_to_audit[self.protocol[proto]], "system_u", "object_r", setype,
> > serange)) +
> >      def modify(self, addr, mask, proto, serange, setype):
> >          self.begin()
> >          self.__modify(addr, mask, proto, serange, setype)
> > @@ -1452,6 +1497,8 @@ class nodeRecords(semanageRecords):
> >
> >          semanage_node_key_free(k)
> >
> > +        self.mylog.log_change("resrc=3Dnode op=3Ddelete laddr=3D%s net=
mask=3D%s
> > proto=3D%s" % (addr, mask, proto_to_audit[self.protocol[proto]])) +
> >      def delete(self, addr, mask, proto):
> >          self.begin()
> >          self.__delete(addr, mask, proto)
> > @@ -1581,6 +1628,8 @@ class interfaceRecords(semanageRecords):
> >          semanage_iface_key_free(k)
> >          semanage_iface_free(iface)
> >
> > +        self.mylog.log_change("resrc=3Dinterface op=3Dadd netif=3D%s
> > tcontext=3D%s:%s:%s:%s" % (interface, "system_u", "object_r", ctype,
> > serange)) +
> >      def add(self, interface, serange, ctype):
> >          self.begin()
> >          self.__add(interface, serange, ctype)
> > @@ -1618,6 +1667,8 @@ class interfaceRecords(semanageRecords):
> >          semanage_iface_key_free(k)
> >          semanage_iface_free(iface)
> >
> > +        self.mylog.log_change("resrc=3Dinterface op=3Dmodify netif=3D%=
s
> > tcontext=3D%s:%s:%s:%s" % (interface, "system_u", "object_r", setype,
> > serange)) +
> >      def modify(self, interface, serange, setype):
> >          self.begin()
> >          self.__modify(interface, serange, setype)
> > @@ -1646,6 +1697,8 @@ class interfaceRecords(semanageRecords):
> >
> >          semanage_iface_key_free(k)
> >
> > +        self.mylog.log_change("resrc=3Dinterface op=3Ddelete netif=3D%=
s" %
> > interface) +
> >      def delete(self, interface):
> >          self.begin()
> >          self.__delete(interface)
> > @@ -1775,6 +1828,8 @@ class fcontextRecords(semanageRecords):
> >                  if i.startswith(target + "/"):
> >                      raise ValueError(_("File spec %s conflicts with
> > equivalency rule '%s %s'") % (target, i, fdict[i]))
> >
> > +        self.mylog.log_change("resrc=3Dfcontext op=3Dadd-equal %s %s" =
%
> > (audit.audit_encode_nv_string("sglob", target, 0),
> > audit.audit_encode_nv_string("tglob", substitute, 0))) +
> >          self.equiv[target] =3D substitute
> >          self.equal_ind =3D True
> >          self.commit()
> > @@ -1785,6 +1840,9 @@ class fcontextRecords(semanageRecords):
> >              raise ValueError(_("Equivalence class for %s does not
> exists")
> > % target) self.equiv[target] =3D substitute
> >          self.equal_ind =3D True
> > +
> > +        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify-equal %s %=
s" %
> > (audit.audit_encode_nv_string("sglob", target, 0),
> > audit.audit_encode_nv_string("tglob", substitute, 0))) +
> >          self.commit()
> >
> >      def createcon(self, target, seuser=3D"system_u"):
> > @@ -1879,6 +1937,11 @@ class fcontextRecords(semanageRecords):
> >          semanage_fcontext_key_free(k)
> >          semanage_fcontext_free(fcontext)
> >
> > +        if not seuser:
> > +            seuser =3D "system_u"
> > +
> > +        self.mylog.log_change("resrc=3Dfcontext op=3Dadd %s ftype=3D%s
> > tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target=
,
> 0),
> > ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
> >      def add(self, target, type, ftype=3D"", serange=3D"",
> seuser=3D"system_u"):
> >          self.begin()
> >          self.__add(target, type, ftype, serange, seuser)
> > @@ -1939,6 +2002,11 @@ class fcontextRecords(semanageRecords):
> >          semanage_fcontext_key_free(k)
> >          semanage_fcontext_free(fcontext)
> >
> > +        if not seuser:
> > +            seuser =3D "system_u"
> > +
> > +        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=
=3D%s
> > tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target=
,
> 0),
> > ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
> >      def modify(self, target, setype, ftype, serange, seuser):
> >          self.begin()
> >          self.__modify(target, setype, ftype, serange, seuser)
> > @@ -1964,6 +2032,8 @@ class fcontextRecords(semanageRecords):
> >                  raise ValueError(_("Could not delete the file context
> %s")
> > % target) semanage_fcontext_key_free(k)
> >
> > +            self.mylog.log_change("resrc=3Dfcontext op=3Ddelete %s
> ftype=3D%s" %
> > (audit.audit_encode_nv_string("tglob", target, 0),
> > ftype_to_audit[ftype_str])) +
> >          self.equiv =3D {}
> >          self.equal_ind =3D True
> >          self.commit()
> > @@ -1972,6 +2042,9 @@ class fcontextRecords(semanageRecords):
> >          if target in self.equiv.keys():
> >              self.equiv.pop(target)
> >              self.equal_ind =3D True
> > +
> > +            self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal =
%s
> > ftype=3D%s" % (audit.audit_encode_nv_string("tglob", target, 0),
> > ftype_to_audit[ftype])) +
> >              return
> >
> >          (rc, k) =3D semanage_fcontext_key_create(self.sh, target,
> > file_types[ftype]) @@ -1996,6 +2069,8 @@ class
> > fcontextRecords(semanageRecords):
> >
> >          semanage_fcontext_key_free(k)
> >
> > +        self.mylog.log_change("resrc=3Dfcontext op=3Ddelete %s ftype=
=3D%s" %
> > (audit.audit_encode_nv_string("tglob", target, 0),
> ftype_to_audit[ftype]))
> > +
> >      def delete(self, target, ftype):
> >          self.begin()
> >          self.__delete(target, ftype)
>
>
>


--=20
Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR

--001a114f856ec7808a053887ac80
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi Steve,</div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">I did not know that I won&#39;t need to overr=
ide those parameters when I started to prepare the patch. I can just remove=
 those and pass always &quot;&quot; as hostname, addr and tty. I will submi=
t a new patch in a few minutes ..<br></div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace">Thanks and best regards,</div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace">/M</=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon,=
 Jul 25, 2016 at 9:07 PM, Steve Grubb <span dir=3D"ltr">&lt;<a href=3D"mail=
to:sgrubb@redhat.com" target=3D"_blank">sgrubb@redhat.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hello,<br>
<br>
Thanks for adding these audit events. I have just one question below.<br>
<div><div class=3D"h5"><br>
On Monday, July 25, 2016 6:37:06 PM EDT Miroslav Vadkerti wrote:<br>
&gt; Common Criteria requirement FMT_MSA.1 needs any configuration change<b=
r>
&gt; that affect enforcement of policy to be audited. This patch adds<br>
&gt; auditing of changes in security context mappings for network ports,<br=
>
&gt; interfaces, nodes and file contexts.<br>
&gt;<br>
&gt; A new function log_change is introduced that audits additions,<br>
&gt; modification and removal of the mappings via the USER_MAC_CONFIG_CHANG=
E<br>
&gt; audit event.<br>
&gt;<br>
&gt; The format of the audit events was discussed with the audit userspace<=
br>
&gt; maintainer.<br>
&gt;<br>
&gt; This patch resolves: <a href=3D"https://bugzilla.redhat.com/show_bug.c=
gi?id=3D829175" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redha=
t.com/show_bug.cgi?id=3D829175</a><br>
&gt;<br>
&gt; Signed-off-by: Miroslav Vadkerti &lt;<a href=3D"mailto:mvadkert@redhat=
.com">mvadkert@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 policycoreutils/semanage/seobject.py | 75<br>
&gt; ++++++++++++++++++++++++++++++++++++ 1 file changed, 75 insertions(+)<=
br>
&gt;<br>
&gt; diff --git a/policycoreutils/semanage/seobject.py<br>
&gt; b/policycoreutils/semanage/seobject.py index 3b0b108..799ce24 100644<b=
r>
&gt; --- a/policycoreutils/semanage/seobject.py<br>
&gt; +++ b/policycoreutils/semanage/seobject.py<br>
&gt; @@ -82,6 +82,21 @@ file_type_str_to_option =3D {&quot;all files&quot;:=
 &quot;a&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;socket file&quot;: &quot;s&quot;,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;symbolic link&quot;: &quot;l&quot;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;named pipe&quot;: &quot;p&quot;}<br=
>
&gt; +<br>
&gt; +proto_to_audit =3D {&quot;tcp&quot;: 17,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
udp&quot;: 6,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
ipv4&quot;: 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
ipv6&quot;: 41}<br>
&gt; +<br>
&gt; +ftype_to_audit =3D {&quot;&quot;: &quot;any&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
b&quot;: &quot;block&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
c&quot;: &quot;char&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
d&quot;: &quot;dir&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
f&quot;: &quot;file&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
l&quot;: &quot;symlink&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
p&quot;: &quot;pipe&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
s&quot;: &quot;socket&quot;}<br>
&gt; +<br>
&gt;=C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 import audit<br>
&gt;<br>
&gt; @@ -90,6 +105,7 @@ try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.audit_fd =3D audi=
t.audit_open()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log_list =3D []<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log_change_list =3D []=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def log(self, msg, name=3D&quot;&quo=
t;, sename=3D&quot;&quot;, serole=3D&quot;&quot;, serange=3D&quot;&quot;,<b=
r>
&gt; oldsename=3D&quot;&quot;, oldserole=3D&quot;&quot;, oldserange=3D&quot=
;&quot;):<br>
&gt;<br>
&gt; @@ -109,10 +125,17 @@ try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def log_remove(self, msg, name=3D&qu=
ot;&quot;, sename=3D&quot;&quot;, serole=3D&quot;&quot;,<br>
&gt; serange=3D&quot;&quot;, oldsename=3D&quot;&quot;, oldserole=3D&quot;&q=
uot;, oldserange=3D&quot;&quot;):<br>
&gt; self.log_list.append([self.audit_fd, audit.AUDIT_ROLE_REMOVE, sys.argv=
[0],<br>
&gt; str(msg), name, 0, sename, serole, serange, oldsename, oldserole,<br>
&gt; oldserange, &quot;&quot;, &quot;&quot;, &quot;&quot;])<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def log_change(self, msg, hostname=3D&quo=
t;&quot;, addr=3D&quot;&quot;, tty=3D&quot;&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log_change_list.append=
([self.audit_fd,<br>
&gt; audit.AUDIT_USER_MAC_CONFIG_CHANGE, str(msg), &quot;semanage&quot;, ho=
stname, addr,<br>
&gt; tty]) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def commit(self, success):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for l in self.log_list=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 audit.au=
dit_log_semanage_message(*(l + [success]))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for l in self.log_change_li=
st:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 audit.audit_l=
og_user_comm_message(*(l + [success]))<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log_list =3D []<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log_change_list =3D []=
<br>
&gt;=C2=A0 except:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 class logger:<br>
&gt;<br>
&gt; @@ -138,6 +161,9 @@ except:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def log_remove(self, msg, name=3D&qu=
ot;&quot;, sename=3D&quot;&quot;, serole=3D&quot;&quot;,<br>
&gt; serange=3D&quot;&quot;, oldsename=3D&quot;&quot;, oldserole=3D&quot;&q=
uot;, oldserange=3D&quot;&quot;): self.log(msg, name,<br>
&gt; sename, serole, serange, oldsename, oldserole, oldserange)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def log_change(self, msg, hostname=3D&quo=
t;&quot;, addr=3D&quot;&quot;, tty=3D&quot;&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.log_list.append(&quot;=
 %s&quot; % msg)<br>
&gt; +<br>
<br>
</div></div>Is it really necessary to do something with hostname, addr, &am=
p; tty here...<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def commit(self, success):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if success =3D=3D 1:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 message =
=3D &quot;Successful: &quot;<br>
&gt; @@ -155,6 +181,9 @@ class nulllogger:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def log_remove(self, msg, name=3D&quot;&quot;, sen=
ame=3D&quot;&quot;, serole=3D&quot;&quot;, serange=3D&quot;&quot;,<br>
&gt; oldsename=3D&quot;&quot;, oldserole=3D&quot;&quot;, oldserange=3D&quot=
;&quot;): pass<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 def log_change(self, msg, hostname=3D&quot;&quot;, addr=
=3D&quot;&quot;, tty=3D&quot;&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; +<br>
<br>
</span>and here? I think those are already handled in the audit logging fun=
ction.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steve<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;=C2=A0 =C2=A0 =C2=A0 def commit(self, success):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt;<br>
&gt; @@ -1109,6 +1138,8 @@ class portRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_port_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_port_free(p)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dport =
op=3Dadd lport=3D%s proto=3D%s<br>
&gt; tcontext=3D%s:%s:%s:%s&quot; % (port, proto_to_audit[proto], &quot;sys=
tem_u&quot;,<br>
&gt; &quot;object_r&quot;, type, serange)) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def add(self, port, proto, serange, type):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__add(port, proto, serange, typ=
e)<br>
&gt; @@ -1150,6 +1181,8 @@ class portRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_port_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_port_free(p)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dport =
op=3Dmodify lport=3D%s proto=3D%s<br>
&gt; tcontext=3D%s:%s:%s:%s&quot; % (port, proto_to_audit[proto], &quot;sys=
tem_u&quot;,<br>
&gt; &quot;object_r&quot;, setype, serange)) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def modify(self, port, proto, serange, setype):<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__modify(port, proto, serange, =
setype)<br>
&gt; @@ -1168,6 +1201,7 @@ class portRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 low =3D semanage_port_=
get_low(port)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 high =3D semanage_port=
_get_high(port)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_str =3D &quot;%s-=
%s&quot; % (low, high)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (k, proto_d, low, high=
) =3D self.__genkey(port_str, proto_str)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Va=
lueError(_(&quot;Could not create a key for %s&quot;) %<br>
&gt; port_str) @@ -1177,6 +1211,11 @@ class portRecords(semanageRecords):<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Va=
lueError(_(&quot;Could not delete the port %s&quot;) %<br>
&gt; port_str) semanage_port_key_free(k)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if low =3D=3D high:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_str =3D =
low<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot=
;resrc=3Dport op=3Ddelete lport=3D%s proto=3D%s&quot;<br>
&gt; % (port_str, proto_to_audit[proto_str])) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.commit()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __delete(self, port, proto):<br>
&gt; @@ -1199,6 +1238,8 @@ class portRecords(semanageRecords):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_port_key_free(k)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dport =
op=3Ddelete lport=3D%s proto=3D%s&quot; %<br>
&gt; (port, proto_to_audit[proto])) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def delete(self, port, proto):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__delete(port, proto)<br>
&gt; @@ -1380,6 +1421,8 @@ class nodeRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_node_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_node_free(node)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dnode =
op=3Dadd laddr=3D%s netmask=3D%s<br>
&gt; proto=3D%s tcontext=3D%s:%s:%s:%s&quot; % (addr, mask,<br>
&gt; proto_to_audit[self.protocol[proto]], &quot;system_u&quot;, &quot;obje=
ct_r&quot;, ctype,<br>
&gt; serange)) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def add(self, addr, mask, proto, serange, ctype):<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__add(addr, mask, proto, serang=
e, ctype)<br>
&gt; @@ -1421,6 +1464,8 @@ class nodeRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_node_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_node_free(node)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dnode =
op=3Dmodify laddr=3D%s netmask=3D%s<br>
&gt; proto=3D%s tcontext=3D%s:%s:%s:%s&quot; % (addr, mask,<br>
&gt; proto_to_audit[self.protocol[proto]], &quot;system_u&quot;, &quot;obje=
ct_r&quot;, setype,<br>
&gt; serange)) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def modify(self, addr, mask, proto, serange, setyp=
e):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__modify(addr, mask, proto, ser=
ange, setype)<br>
&gt; @@ -1452,6 +1497,8 @@ class nodeRecords(semanageRecords):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_node_key_free(k)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dnode =
op=3Ddelete laddr=3D%s netmask=3D%s<br>
&gt; proto=3D%s&quot; % (addr, mask, proto_to_audit[self.protocol[proto]]))=
 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def delete(self, addr, mask, proto):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__delete(addr, mask, proto)<br>
&gt; @@ -1581,6 +1628,8 @@ class interfaceRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_iface_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_iface_free(iface)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dinter=
face op=3Dadd netif=3D%s<br>
&gt; tcontext=3D%s:%s:%s:%s&quot; % (interface, &quot;system_u&quot;, &quot=
;object_r&quot;, ctype,<br>
&gt; serange)) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def add(self, interface, serange, ctype):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__add(interface, serange, ctype=
)<br>
&gt; @@ -1618,6 +1667,8 @@ class interfaceRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_iface_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_iface_free(iface)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dinter=
face op=3Dmodify netif=3D%s<br>
&gt; tcontext=3D%s:%s:%s:%s&quot; % (interface, &quot;system_u&quot;, &quot=
;object_r&quot;, setype,<br>
&gt; serange)) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def modify(self, interface, serange, setype):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__modify(interface, serange, se=
type)<br>
&gt; @@ -1646,6 +1697,8 @@ class interfaceRecords(semanageRecords):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_iface_key_free(k)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dinter=
face op=3Ddelete netif=3D%s&quot; %<br>
&gt; interface) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def delete(self, interface):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__delete(interface)<br>
&gt; @@ -1775,6 +1828,8 @@ class fcontextRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if i.sta=
rtswith(target + &quot;/&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 raise ValueError(_(&quot;File spec %s conflicts with<br>
&gt; equivalency rule &#39;%s %s&#39;&quot;) % (target, i, fdict[i]))<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dfcont=
ext op=3Dadd-equal %s %s&quot; %<br>
&gt; (audit.audit_encode_nv_string(&quot;sglob&quot;, target, 0),<br>
&gt; audit.audit_encode_nv_string(&quot;tglob&quot;, substitute, 0))) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equiv[target] =3D substitute<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equal_ind =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.commit()<br>
&gt; @@ -1785,6 +1840,9 @@ class fcontextRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(_(&qu=
ot;Equivalence class for %s does not exists&quot;)<br>
&gt; % target) self.equiv[target] =3D substitute<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equal_ind =3D True<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dfcont=
ext op=3Dmodify-equal %s %s&quot; %<br>
&gt; (audit.audit_encode_nv_string(&quot;sglob&quot;, target, 0),<br>
&gt; audit.audit_encode_nv_string(&quot;tglob&quot;, substitute, 0))) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.commit()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def createcon(self, target, seuser=3D&quot;system_=
u&quot;):<br>
&gt; @@ -1879,6 +1937,11 @@ class fcontextRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_fcontext_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_fcontext_free(fcontext)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not seuser:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seuser =3D &quot;system_u&q=
uot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dfcont=
ext op=3Dadd %s ftype=3D%s<br>
&gt; tcontext=3D%s:%s:%s:%s&quot; % (audit.audit_encode_nv_string(&quot;tgl=
ob&quot;, target, 0),<br>
&gt; ftype_to_audit[ftype], seuser, &quot;object_r&quot;, type, serange)) +=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def add(self, target, type, ftype=3D&quot;&quot;, =
serange=3D&quot;&quot;, seuser=3D&quot;system_u&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__add(target, type, ftype, sera=
nge, seuser)<br>
&gt; @@ -1939,6 +2002,11 @@ class fcontextRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_fcontext_key_free(k)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_fcontext_free(fcontext)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not seuser:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seuser =3D &quot;system_u&q=
uot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dfcont=
ext op=3Dmodify %s ftype=3D%s<br>
&gt; tcontext=3D%s:%s:%s:%s&quot; % (audit.audit_encode_nv_string(&quot;tgl=
ob&quot;, target, 0),<br>
&gt; ftype_to_audit[ftype], seuser, &quot;object_r&quot;, type, serange)) +=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def modify(self, target, setype, ftype, serange, s=
euser):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__modify(target, setype, ftype,=
 serange, seuser)<br>
&gt; @@ -1964,6 +2032,8 @@ class fcontextRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Va=
lueError(_(&quot;Could not delete the file context %s&quot;)<br>
&gt; % target) semanage_fcontext_key_free(k)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot=
;resrc=3Dfcontext op=3Ddelete %s ftype=3D%s&quot; %<br>
&gt; (audit.audit_encode_nv_string(&quot;tglob&quot;, target, 0),<br>
&gt; ftype_to_audit[ftype_str])) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equiv =3D {}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equal_ind =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.commit()<br>
&gt; @@ -1972,6 +2042,9 @@ class fcontextRecords(semanageRecords):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if target in self.equiv.keys():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equiv.pop(target)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.equal_ind =3D Tru=
e<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot=
;resrc=3Dfcontext op=3Ddelete-equal %s<br>
&gt; ftype=3D%s&quot; % (audit.audit_encode_nv_string(&quot;tglob&quot;, ta=
rget, 0),<br>
&gt; ftype_to_audit[ftype])) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rc, k) =3D semanage_fcontext_key_cr=
eate(self.sh, target,<br>
&gt; file_types[ftype]) @@ -1996,6 +2069,8 @@ class<br>
&gt; fcontextRecords(semanageRecords):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 semanage_fcontext_key_free(k)<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Dfcont=
ext op=3Ddelete %s ftype=3D%s&quot; %<br>
&gt; (audit.audit_encode_nv_string(&quot;tglob&quot;, target, 0), ftype_to_=
audit[ftype]))<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def delete(self, target, ftype):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.begin()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__delete(target, ftype)<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><font face=3D"monospace, monospace">Mir=
oslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security</font></div><div>=
<span style=3D"font-family:monospace,monospace;font-size:12.8px">IRC mvadke=
rt #qe #urt #brno #rpmdiff :: GPG 0x25881087</span><br></div><div><span sty=
le=3D"font-family:monospace,monospace;font-size:12.8px">Desk Phone +420 532=
 294 129 :: Mobile +420 773 944 252</span><span style=3D"font-family:monosp=
ace,monospace;font-size:12.8px"><br></span></div><div><span style=3D"font-f=
amily:monospace,monospace;font-size:12.8px">Red Hat Czech s.r.o, Purky=C5=
=88ova 99/71, 612 00, Brno, CR</span><br></div><div><br></div></div></div><=
/div></div>
</div>

--001a114f856ec7808a053887ac80--
